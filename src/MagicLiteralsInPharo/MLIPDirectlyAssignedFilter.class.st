Class {
	#name : #MLIPDirectlyAssignedFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPDirectlyAssignedFilter >> isNotMagicLiteral: literalNode [
	|parents assignmentIndex|
	parents := literalNode parents.
	assignmentIndex := parents detectIndex: #isAssignment ifNone: [ ^ false ].	
	^ (parents copyFrom: assignmentIndex + 1 to: parents size - 1)
		allSatisfy: [ :node | node isLiteralArray ]
]
