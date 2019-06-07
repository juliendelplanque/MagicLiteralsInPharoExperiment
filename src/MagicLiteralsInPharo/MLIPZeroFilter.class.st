Class {
	#name : #MLIPZeroFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPZeroFilter >> isNotMagicLiteral: literalNode [
	^  literalNode class = RBLiteralValueNode and: [ literalNode value = 0 ]
]
