Class {
	#name : #MLIPAnalysis,
	#superclass : #Object,
	#instVars : [
		'databaseFile',
		'literalsOccurencesInTestsAndNonTests'
	],
	#category : #'MagicLiteralsInPharo-Analysis'
}

{ #category : #computation }
MLIPAnalysis >> allLiteralNodes [
	^ self databaseFile sqlite3ConnectionDo: [ :connection |
		Array streamContents: [ :literalsStream |
			(connection execute: 'SELECT method.id, method.source_code , class.is_test_case FROM method, class WHERE method.class_id = class.id;') do: [ :row |
				|nodes|
				nodes := [ |ast|
					ast := (RBParser parseMethod: (row atColumnNamed: 'source_code')).
					ast propertyAt: #isFromTestCase put: (row atColumnNamed: 'is_test_case') = 1.
					ast literalNodes
				] on: SyntaxErrorNotification do: [ #() ].
				literalsStream nextPutAll: nodes ] ] ].
]

{ #category : #computation }
MLIPAnalysis >> allLiteralNodesNotInLiteralArray [
	^ self allLiteralNodes reject: [ :node | node parent class = RBLiteralArrayNode ]
]

{ #category : #accessing }
MLIPAnalysis >> databaseFile [
	^ databaseFile
]

{ #category : #accessing }
MLIPAnalysis >> databaseFile: anObject [
	databaseFile := anObject
]

{ #category : #'plot generation' }
MLIPAnalysis >> generateLatexIn: aDirectory [
	| fileNamesSeen |
	fileNamesSeen := Set new.
	(Pragma allNamed: #latexInFileNamed: in: self class) do: [ :pragma |
		|fileName|
		fileName := pragma argumentAt: 1.
		(fileNamesSeen includes: fileName)
			ifTrue: [ self error: 'Duplicated file names for latex. Aborting.' ]
			ifFalse: [ fileNamesSeen add: fileName ].
		(aDirectory / fileName) ensureDelete writeStreamDo: [ :stream |
			stream nextPutAll: (pragma methodSelector value: self) ] ]
]

{ #category : #'plot generation' }
MLIPAnalysis >> generatePlotsIn: aDirectory [
	| fileNamesSeen |
	fileNamesSeen := Set new.
	(Pragma allNamed: #plotInFileNamed: in: self class) do: [ :pragma |
		|fileName|
		fileName := pragma argumentAt: 1.
		(fileNamesSeen includes: fileName)
			ifTrue: [ self error: 'Duplicated file names for plots. Aborting.' ]
			ifFalse: [ fileNamesSeen add: fileName ].
		(pragma methodSelector value: self)
			generateIn: (aDirectory / fileName) ensureDelete ]
]

{ #category : #computation }
MLIPAnalysis >> literalsOccurencesInTestsAndNonTests [
	^ literalsOccurencesInTestsAndNonTests ifNil: [ 
		literalsOccurencesInTestsAndNonTests := (((self allLiteralNodesNotInLiteralArray 
			groupedBy: [ :l | self typeAggregationDict at: l value class ]) collect: [ :literals | 
		|fromTestCases|
		fromTestCases := literals select: [ :node | node parents first propertyAt: #isFromTestCase ].
		{ literals size . fromTestCases size / literals size. (literals size - fromTestCases size) / literals size } ]) associations sort: [ :assoc | assoc value first ] asSortFunction reversed) ]
]

{ #category : #latexing }
MLIPAnalysis >> literalsOccurencesInTestsAndNonTestsLatexTable [
	<latexInFileNamed: 'occurences-tests-nontests.tex'>
	^ String streamContents: [ :stream |
		stream nextPutAll: '\begin{tabular}{l|c|c|c}'.
		stream nextPutAll: 'Class & Total Occurences & \% in tests & \% in non-tests \\',String lf.
		stream nextPutAll: '\hline\hline',String lf.
		self literalsOccurencesInTestsAndNonTests do: [ :assoc |
			stream nextPutAll: assoc key printString.
			stream nextPutAll: ' & '.
			stream nextPutAll: assoc value first printString.
			stream nextPutAll: ' & '.
			assoc value allButFirst do: [ :v | stream nextPutAll: ((v * 100) printShowingDecimalPlaces: 2) ] separatedBy: [ stream nextPutAll: ' & ' ].
			stream nextPutAll: ' \\',String lf ].
		stream nextPutAll: '\end{tabular}' ].
]

{ #category : #plotting }
MLIPAnalysis >> literalsOccurencesInTestsAndNonTestsPlot [
	<plotInFileNamed: 'literals-occurence-tests-nontests.pdf'>
	| data |
	data := self literalsOccurencesInTestsAndNonTests.
	
	^ MLBStackedBarPlot new
		dataList: (data collect: [ :assoc | assoc value allButFirst ]);
		labels: (data collect: [:assoc | assoc key printString ]);
		colorList: { Color black . Color gray };
		configXAxis: [ :xAxis |
			xAxis
				labelsRotation: 90 ]
		yourself
]

{ #category : #computation }
MLIPAnalysis >> repartitionMagicLiteralsAtClassLevelData [
	^ self databaseFile sqlite3ConnectionDo: [ :c |
		(c execute: 'SELECT class.name, COUNT(*) AS methods_with_magic, SUM(literals_metadata.magic_literals_count) AS magic_count
	FROM method,literals_metadata,class
	WHERE method.id = literals_metadata.method_id
		AND class.id = method.class_id
		AND NOT class.is_test_case
		AND NOT class.name LIKE ''ConfigurationOf%''
		AND NOT class.name LIKE ''BaselineOf%''
		AND NOT (method.selector LIKE ''example%'' AND class.name LIKE ''% class'')
		AND literals_metadata.magic_literals_count > 0
	GROUP BY class.name
	ORDER BY methods_with_magic DESC;') rowsOfClass: MLIPRow ]
]

{ #category : #plotting }
MLIPAnalysis >> repartitionMagicLiteralsAtClassLevelPlot [
	"<plotInFileNamed: 'repartition-class-level.pdf'>"
	| data |
	data := self repartitionMagicLiteralsAtClassLevelData.
	^ MLBScatterPlot2 new
		data: (data collect: [ :row | 
			(MLBScatterData
				position: (row atColumnNamed: 'methods_with_magic') @ (row atColumnNamed: 'magic_count') size: 20)
				color: Color black;
				marker: '+' asMLBMarkerStyle;
				yourself ]);
		configXAxis: [ :xAxis |
			xAxis
				title: '# methods with at least one magic literal';
				max: 1000 ];
		configYAxis: [ :yAxis |
			yAxis
				title: '# magic literals in all methods of the class (log scale)';
				max: 1000";
				logScale" ];
		yourself
]

{ #category : #computation }
MLIPAnalysis >> repartitionMagicLiteralsAtProbablePackageLevelData [
	^ self databaseFile sqlite3ConnectionDo: [ :c |
		(c execute: 'SELECT substr(class.category, 0, instr(class.category, ''-'')) AS probable_package, COUNT(*) AS classes_with_magic, SUM(literals_metadata.magic_literals_count) AS magic_count
	FROM method,literals_metadata,class
	WHERE method.id = literals_metadata.method_id
		AND class.id = method.class_id
		AND NOT class.is_test_case
		AND NOT class.name LIKE ''ConfigurationOf%''
		AND NOT class.name LIKE ''BaselineOf%''
		AND NOT (method.selector LIKE ''example%'' AND class.name LIKE ''% class'')
		AND literals_metadata.magic_literals_count > 0
	GROUP BY probable_package
	ORDER BY classes_with_magic DESC;') rowsOfClass: MLIPRow ]
]

{ #category : #plotting }
MLIPAnalysis >> repartitionMagicLiteralsAtProbablePackageLevelPlot [
	"<plotInFileNamed: 'repartition-probable-package-level.pdf'>"
	| data |
	data := self repartitionMagicLiteralsAtProbablePackageLevelData.
	^ MLBScatterPlot2 new
		data: (data collect: [ :row | 
			(MLBScatterData position: (row atColumnNamed: 'classes_with_magic') @ (row atColumnNamed: 'magic_count') size: 20)
				color: Color black;
				marker: 'x' asMLBMarkerStyle;
				yourself ]);
		configXAxis: [ :xAxis |
			xAxis
				title: '# classes with at least one magic literal'; max: 5000 ];
		configYAxis: [ :yAxis |
			yAxis
				title: '# magic literals in all methods of all classes of the package'; max: 5000";
				logScale" ];
		yourself.
]

{ #category : #accessing }
MLIPAnalysis >> typeAggregationDict [
	^ { 
	SmallInteger -> Integer.
	ByteString -> String.
	ByteSymbol -> Symbol.
	Array -> Array.
	False -> Boolean.
	UndefinedObject -> UndefinedObject.
	True -> Boolean.
	Character -> Character.
	SmallFloat64 -> Float.
	LargePositiveInteger -> Integer.
	ByteArray -> ByteArray.
	LargeNegativeInteger -> Integer.
	WideString -> String.
	ScaledDecimal -> ScaledDecimal.
	BoxedFloat64 -> Float.
	WideSymbol -> Symbol } asDictionary
]
