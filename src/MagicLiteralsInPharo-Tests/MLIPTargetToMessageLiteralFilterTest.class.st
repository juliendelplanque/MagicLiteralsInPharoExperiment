"
A MLIPTargetToMessageLiteralFilterTest is a test class for testing the behavior of MLIPTargetToMessageLiteralFilter
"
Class {
	#name : #MLIPTargetToMessageLiteralFilterTest,
	#superclass : #TestCase,
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #test }
MLIPTargetToMessageLiteralFilterTest >> testIsNotMagicLiteral [

	self flag: #toImplement.
	self assert: false
]
