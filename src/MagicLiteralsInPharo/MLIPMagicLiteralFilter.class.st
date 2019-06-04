Class {
	#name : #MLIPMagicLiteralFilter,
	#superclass : #Object,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPMagicLiteralFilter >> isNotMagicLiteral: literalNode [
	"Returns true if literal node is not a magic literal."
	^ self subclassResponsibility
]
