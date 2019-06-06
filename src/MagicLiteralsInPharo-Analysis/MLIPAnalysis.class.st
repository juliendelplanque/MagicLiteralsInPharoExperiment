Class {
	#name : #MLIPAnalysis,
	#superclass : #Object,
	#instVars : [
		'databaseFile'
	],
	#category : #'MagicLiteralsInPharo-Analysis'
}

{ #category : #accessing }
MLIPAnalysis >> databaseFile [
	^ databaseFile
]

{ #category : #accessing }
MLIPAnalysis >> databaseFile: anObject [
	databaseFile := anObject
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
			generateIn: aDirectory / fileName ]
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
	<plotInFileNamed: 'repartition-class-level.pdf'>
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
				title: '# methods with at least one magic literal' ];
		configYAxis: [ :yAxis |
			yAxis
				title: '# magic literals in all methods of the class (log scale)';
				logScale ];
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
	<plotInFileNamed: 'repartition-probable-package-level.pdf'>
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
				title: '# classes with at least one magic literal' ];
		configYAxis: [ :yAxis |
			yAxis
				title: '# magic literals in all methods of all classes of the package'";
				logScale" ];
		yourself.
]
