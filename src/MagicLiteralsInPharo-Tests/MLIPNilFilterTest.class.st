"
A MLIPNilFilterTest is a test class for testing the behavior of MLIPNilFilter
"
Class {
	#name : #MLIPNilFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests'
}

{ #category : #running }
MLIPNilFilterTest >> setUp [
	super setUp.
	filter := MLIPNilFilter new
]

{ #category : #test }
MLIPNilFilterTest >> testIsNotMagicLiteral [
	self assert: (filter isNotMagicLiteral: (RBLiteralValueNode value: nil)).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralValueNode value: 42)).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralValueNode value: true)).
]
