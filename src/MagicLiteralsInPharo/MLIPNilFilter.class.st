Class {
	#name : #MLIPNilFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPNilFilter >> isNotMagicLiteral: literalNode [
	^  literalNode class = RBLiteralValueNode and: [ literalNode value isNil ]
]
