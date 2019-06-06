Class {
	#name : #MLIPBooleanFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPBooleanFilter >> isNotMagicLiteral: literalNode [
	^  literalNode class = RBLiteralValueNode and: [ #(true false) includes: literalNode value ]
]
