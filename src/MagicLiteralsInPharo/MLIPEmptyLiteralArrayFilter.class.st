Class {
	#name : #MLIPEmptyLiteralArrayFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPEmptyLiteralArrayFilter >> isNotMagicLiteral: literalNode [
	^ literalNode isLiteralArray and: [ literalNode contents isEmpty ]
]
