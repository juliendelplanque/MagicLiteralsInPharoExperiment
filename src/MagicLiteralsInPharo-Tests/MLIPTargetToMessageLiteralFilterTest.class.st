"
A MLIPTargetToMessageLiteralFilterTest is a test class for testing the behavior of MLIPTargetToMessageLiteralFilter
"
Class {
	#name : #MLIPTargetToMessageLiteralFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter1',
		'filter2'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPTargetToMessageLiteralFilterTest >> setUp [
	super setUp.
	filter1 := MLIPTargetToMessageLiteralFilter selector: #timesRepeat: literalType: Integer.
	filter2 := MLIPTargetToMessageLiteralFilter selector: #timesRepeat: literalValue: 1.
]

{ #category : #test }
MLIPTargetToMessageLiteralFilterTest >> testIsNotMagicLiteral [
	| literalNode argNode messageNode |
	literalNode := RBLiteralValueNode value: 42.
	argNode := RBBlockNode new.
	messageNode := RBMessageNode receiver: literalNode selector: #timesRepeat: arguments: {argNode}.
	literalNode parent: messageNode.
	argNode parent: messageNode.
	
	self assert: (filter1 isNotMagicLiteral: literalNode).
	
	self deny: (filter2 isNotMagicLiteral: literalNode)
]

{ #category : #test }
MLIPTargetToMessageLiteralFilterTest >> testIsNotMagicLiteral2 [
	| literalNode argNode messageNode |
	literalNode := RBLiteralValueNode value: 1.
	argNode := RBBlockNode new.
	messageNode := RBMessageNode receiver: literalNode selector: #timesRepeat: arguments: {argNode}.
	literalNode parent: messageNode.
	argNode parent: messageNode.
	
	self assert: (filter1 isNotMagicLiteral: literalNode).
	self assert: (filter2 isNotMagicLiteral: literalNode).
]

{ #category : #test }
MLIPTargetToMessageLiteralFilterTest >> testIsNotMagicLiteral3 [
	| literalNode argNode messageNode |
	literalNode := RBLiteralValueNode value: 'str'.
	argNode := RBBlockNode new.
	messageNode := RBMessageNode receiver: literalNode selector: #timesRepeat: arguments: {argNode}.
	literalNode parent: messageNode.
	argNode parent: messageNode.
	
	self deny: (filter1 isNotMagicLiteral: literalNode).
	self deny: (filter2 isNotMagicLiteral: literalNode).
]

{ #category : #test }
MLIPTargetToMessageLiteralFilterTest >> testIsNotMagicLiteral4 [
	| literalNode argNode messageNode |
	literalNode := RBLiteralValueNode value: 1.
	argNode := RBBlockNode new.
	messageNode := RBMessageNode receiver: literalNode selector: #foo: arguments: {argNode}.
	literalNode parent: messageNode.
	argNode parent: messageNode.
	
	self deny: (filter1 isNotMagicLiteral: literalNode).
	self deny: (filter2 isNotMagicLiteral: literalNode).
]
