Class {
	#name : #MLIPRow,
	#superclass : #SQLite3Row,
	#category : #'MagicLiteralsInPharo-Core'
}

{ #category : #'inspector extensions' }
MLIPRow >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'Source';
		smalltalkClass: [ Object ];
		display: [ self atColumnNamed: 'source_code' ]
]
