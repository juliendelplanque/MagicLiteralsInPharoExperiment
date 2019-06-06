"
A MLIPArgumentOfMessageLiteralFilterTest is a test class for testing the behavior of MLIPArgumentOfMessageLiteralFilter
"
Class {
	#name : #MLIPArgumentOfMessageLiteralFilterTest,
	#superclass : #TestCase,
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral [

	self flag: #toImplement.
	self assert: false
]
