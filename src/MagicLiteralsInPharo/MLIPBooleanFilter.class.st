Class {
	#name : #MLIPBooleanFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPBooleanFilter >> isNotMagicLiteral: literalNode [
	^  literalNode class = RBLiteralValueNode and: [ #(true false) includes: literalNode value ]
]
