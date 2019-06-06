Class {
	#name : #MLIPArgumentOfMessageLiteralFilter,
	#superclass : #MLIPTargetToMessageLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPArgumentOfMessageLiteralFilter >> isNotMagicLiteral: literalNode [
	^ (literalNode value isKindOf: self literalType) and: [ 
		literalNode parent isMessage and: [ 
			literalNode parent receiver ~= literalNode and: [ 
				literalNode parent selector = self selector ] ] ]
]
