Class {
	#name : #MLIPEmptyLiteralArrayFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPEmptyLiteralArrayFilter >> isNotMagicLiteral: literalNode [
	^ literalNode isLiteralArray and: [ literalNode contents isEmpty ]
]
