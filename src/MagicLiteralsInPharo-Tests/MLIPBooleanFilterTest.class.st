"
A MLIPBooleanFilterTest is a test class for testing the behavior of MLIPBooleanFilter
"
Class {
	#name : #MLIPBooleanFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPBooleanFilterTest >> setUp [
	super setUp.
	filter := MLIPBooleanFilter new
]

{ #category : #test }
MLIPBooleanFilterTest >> testIsNotMagicLiteral [
	self assert: (filter isNotMagicLiteral: (RBLiteralValueNode value: true)).
	self assert: (filter isNotMagicLiteral: (RBLiteralValueNode value: false)).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralValueNode value: 42)).
]
