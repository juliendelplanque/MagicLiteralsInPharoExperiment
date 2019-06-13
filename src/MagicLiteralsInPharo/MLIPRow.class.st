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
MLIPRow >> gtInspectorMagicLiteralsIn: composite [
	<gtInspectorPresentationOrder: 0> 
	^ (composite fastList)
		title: 'Items';
		display: [ 
			"The FastTable renderer needs to access elements by index so we transform
			the collection to an OrderedCollection. Subclasses can override the #display
			block to provide a different behaviour. The previous renderer had this behaviour
			implemented in the renderer."
			self ast magicLiteralNodes asOrderedCollection ];
		beMultiple;	
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ];
		send: [ :result | result isNil 
			ifTrue:[nil]
			ifFalse:[ (result size = 1) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]]]
]

{ #category : #'inspector extensions' }
MLIPRow >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'Source';
		smalltalkClass: [ Object ];
		display: [ self atColumnNamed: 'source_code' ];
		withLineNumbers: true;
		withAnnotation: true
]
