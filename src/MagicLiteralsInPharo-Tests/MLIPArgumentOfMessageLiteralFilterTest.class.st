"
A MLIPArgumentOfMessageLiteralFilterTest is a test class for testing the behavior of MLIPArgumentOfMessageLiteralFilter
"
Class {
	#name : #MLIPArgumentOfMessageLiteralFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'filter1',
		'filter2',
		'filter3',
		'filter4',
		'filter5'
	],
	#category : #'MagicLiteralsInPharo-Tests-Filters'
}

{ #category : #running }
MLIPArgumentOfMessageLiteralFilterTest >> setUp [
	super setUp.
	filter1 := MLIPArgumentOfMessageLiteralFilter selector: #copyFrom:to: literalType: Integer.
	filter2 := MLIPArgumentOfMessageLiteralFilter selector: #copyFrom:to: literalValue: 1.
	filter3 := MLIPArgumentOfMessageLiteralFilter selector: #copyFrom:to: literalType: Integer index: 2.
	filter4 := MLIPArgumentOfMessageLiteralFilter selector: #copyFrom:to: literalValue: 42 index: 2.
	filter5 := MLIPArgumentOfMessageLiteralFilter selector: #+ literalValue: 1 index: 1.
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral [
	| literalNode1 literalNode2 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	literalNode2 :=  RBLiteralValueNode value: 'str'.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #copyFrom:to: arguments: {literalNode1.literalNode2}.
	literalNode1 parent: messageNode.
	literalNode2 parent: messageNode.
	
	self assert: (filter1 isNotMagicLiteral: literalNode1).
	self deny: (filter1 isNotMagicLiteral: literalNode2).
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral2 [
	| literalNode1 literalNode2 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	literalNode2 :=  RBLiteralValueNode value: 'str'.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #copyFrom:to: arguments: {literalNode1.literalNode2}.
	literalNode1 parent: messageNode.
	literalNode2 parent: messageNode.
	
	self assert: (filter2 isNotMagicLiteral: literalNode1).
	self deny: (filter2 isNotMagicLiteral: literalNode2).
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral3 [
	| literalNode1 literalNode2 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	literalNode2 :=  RBLiteralValueNode value: 42.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #copyFrom:to: arguments: {literalNode1.literalNode2}.
	literalNode1 parent: messageNode.
	literalNode2 parent: messageNode.
	
	self deny: (filter3 isNotMagicLiteral: literalNode1).
	self assert: (filter3 isNotMagicLiteral: literalNode2).
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral4 [
	| literalNode1 literalNode2 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	literalNode2 :=  RBLiteralValueNode value: 42.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #copyFrom:to: arguments: {literalNode1.literalNode2}.
	literalNode1 parent: messageNode.
	literalNode2 parent: messageNode.
	
	self deny: (filter4 isNotMagicLiteral: literalNode1).
	self assert: (filter4 isNotMagicLiteral: literalNode2).
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral5 [
	| literalNode1 literalNode2 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	literalNode2 :=  RBLiteralValueNode value: 41.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #copyFrom:to: arguments: {literalNode1.literalNode2}.
	literalNode1 parent: messageNode.
	literalNode2 parent: messageNode.
	
	self deny: (filter4 isNotMagicLiteral: literalNode1).
	self deny: (filter4 isNotMagicLiteral: literalNode2).
]

{ #category : #test }
MLIPArgumentOfMessageLiteralFilterTest >> testIsNotMagicLiteral6 [
	| literalNode1 messageNode |
	literalNode1 := RBLiteralValueNode value: 1.
	messageNode := RBMessageNode receiver: (RBVariableNode named: 'foo') selector: #+ arguments: {literalNode1}.
	literalNode1 parent: messageNode.
	
	self assert: (filter5 isNotMagicLiteral: literalNode1).
]
