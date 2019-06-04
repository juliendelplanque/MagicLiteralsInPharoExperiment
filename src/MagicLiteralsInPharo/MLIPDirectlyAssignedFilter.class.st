Class {
	#name : #MLIPDirectlyAssignedFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPDirectlyAssignedFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isAssignment
]
