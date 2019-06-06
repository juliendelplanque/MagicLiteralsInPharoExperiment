Class {
	#name : #MLIPDirectlyAssignedFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPDirectlyAssignedFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isAssignment
]
