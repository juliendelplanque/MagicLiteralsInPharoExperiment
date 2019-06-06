"
A MLIPSymbolFilterTest is a test class for testing the behavior of MLIPSymbolFilter
"
Class {
	#name : #MLIPSymbolFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPSymbolFilterTest >> setUp [
	super setUp.
	filter := MLIPSymbolFilter new
]

{ #category : #test }
MLIPSymbolFilterTest >> testIsNotMagicLiteral [
	self assert: (filter isNotMagicLiteral: (RBLiteralValueNode value: #anySymbol)).
	self assert: (filter isNotMagicLiteral: (RBLiteralValueNode value: #anySymbol:)).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralValueNode value: 42)).
]
