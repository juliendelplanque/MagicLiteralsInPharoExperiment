"
A MLIPEmptyLiteralArrayFilterTest is a test class for testing the behavior of MLIPEmptyLiteralArrayFilter
"
Class {
	#name : #MLIPEmptyLiteralArrayFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPEmptyLiteralArrayFilterTest >> setUp [
	super setUp.
	filter := MLIPEmptyLiteralArrayFilter new
]

{ #category : #test }
MLIPEmptyLiteralArrayFilterTest >> testIsNotMagicLiteral [
	self assert: (filter isNotMagicLiteral: (RBLiteralArrayNode value: #())).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralArrayNode value: #(1 2 3))).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralValueNode value: 42))
]
