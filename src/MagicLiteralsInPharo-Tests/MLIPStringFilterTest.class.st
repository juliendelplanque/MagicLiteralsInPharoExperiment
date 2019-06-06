"
A MLIPStringFilterTest is a test class for testing the behavior of MLIPStringFilter
"
Class {
	#name : #MLIPStringFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPStringFilterTest >> setUp [
	super setUp.
	filter := MLIPStringFilter new
]

{ #category : #test }
MLIPStringFilterTest >> testIsNotMagicLiteral [
	self assert: (filter isNotMagicLiteral: (RBLiteralNode value: 'Hello you')).
	
	self assert: (filter isNotMagicLiteral: (RBLiteralNode value: 'Hello?!')).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralNode value: 'deqdqdqw')).
	
	self deny: (filter isNotMagicLiteral: (RBLiteralNode value: 'Hello  dqdww wwdwee'))
]
