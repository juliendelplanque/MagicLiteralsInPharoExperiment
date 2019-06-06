Class {
	#name : #MLIPRow,
	#superclass : #SQLite3Row,
	#category : #'MagicLiteralsInPharo-Core'
}

{ #category : #accessing }
MLIPRow >> ast [
	^ RBParser parseMethod: (self atColumnNamed: 'source_code')
]

{ #category : #'inspector extensions' }
MLIPRow >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'Source';
		smalltalkClass: [ Object ];
		display: [ self atColumnNamed: 'source_code' ]
]
