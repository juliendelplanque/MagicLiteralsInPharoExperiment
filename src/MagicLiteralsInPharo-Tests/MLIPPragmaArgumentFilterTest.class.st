"
A MLIPPragmaArgumentFilterTest is a test class for testing the behavior of MLIPPragmaArgumentFilter
"
Class {
	#name : #MLIPPragmaArgumentFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPPragmaArgumentFilterTest >> setUp [
	super setUp.
	filter := MLIPPragmaArgumentFilter new
]

{ #category : #test }
MLIPPragmaArgumentFilterTest >> testIsNotMagicLiteral [
	| literalNode pragmaNode |
	literalNode := RBLiteralValueNode value: 42.
	pragmaNode := RBPragmaNode selector: #foo: arguments: literalNode.
	literalNode parent: pragmaNode.
	
	self assert: (filter isNotMagicLiteral: literalNode)
]
