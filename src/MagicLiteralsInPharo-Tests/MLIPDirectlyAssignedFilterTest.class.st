"
A MLIPDirectlyAssignedFilterTest is a test class for testing the behavior of MLIPDirectlyAssignedFilter
"
Class {
	#name : #MLIPDirectlyAssignedFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPDirectlyAssignedFilterTest >> setUp [
	super setUp.
	filter := MLIPDirectlyAssignedFilter new
]

{ #category : #test }
MLIPDirectlyAssignedFilterTest >> testIsNotMagicLiteral [
	| methodAst literalNode |
	methodAst := RBParser parseMethod: 'test
	x := #((42))'.
	literalNode := methodAst body statements first value contents first contents first.
	
	self assert: (filter isNotMagicLiteral: literalNode)
]

{ #category : #test }
MLIPDirectlyAssignedFilterTest >> testIsNotMagicLiteral2 [
	| methodAst literalNode |
	methodAst := RBParser parseMethod: 'test
	x := 42'.
	literalNode := methodAst body statements first value.
	
	self assert: (filter isNotMagicLiteral: literalNode)
]

{ #category : #test }
MLIPDirectlyAssignedFilterTest >> testIsNotMagicLiteral3 [
	| methodAst literalArray |
	methodAst := RBParser parseMethod: 'test
	x := #(42 43 44 45)'.
	literalArray := methodAst body statements first value contents.
	
	self assert: literalArray size equals: 4.
	literalArray do: [ :literalNode |
		self assert: (filter isNotMagicLiteral: literalNode) ]
]
