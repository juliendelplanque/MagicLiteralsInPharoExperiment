Class {
	#name : #MLIPArgumentOfMessageLiteralFilter,
	#superclass : #MLIPTargetToMessageLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPArgumentOfMessageLiteralFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isMessage and: [ 
		literalNode parent receiver ~= literalNode and: [ 
			literalNode parent selector = self selector ] ]
]
