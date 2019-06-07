Class {
	#name : #MLIPLiteralInLiteralArrayFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPLiteralInLiteralArrayFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isLiteralArray
]
