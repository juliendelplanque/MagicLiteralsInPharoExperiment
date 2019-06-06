Class {
	#name : #MLIPArgumentOfMessageLiteralFilter,
	#superclass : #MLIPTargetToMessageLiteralFilter,
	#instVars : [
		'expectedIndex'
	],
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #'instance creation' }
MLIPArgumentOfMessageLiteralFilter class >> selector: aSymbol literalType: aClass index: anInteger [
	^ (self selector: aSymbol literalType: aClass)
		expectedIndex: anInteger;
		yourself
]

{ #category : #'instance creation' }
MLIPArgumentOfMessageLiteralFilter class >> selector: aSymbol literalValue: anObject index: anInteger [
	^ (self selector: aSymbol literalValue: anObject)
		expectedIndex: anInteger;
		yourself
]

{ #category : #accessing }
MLIPArgumentOfMessageLiteralFilter >> expectedIndex [
	^ expectedIndex
]

{ #category : #accessing }
MLIPArgumentOfMessageLiteralFilter >> expectedIndex: anObject [
	expectedIndex := anObject
]

{ #category : #testing }
MLIPArgumentOfMessageLiteralFilter >> isNotMagicLiteral: literalNode [
	| indexOfArgument |
	indexOfArgument := literalNode parent arguments indexOf: literalNode.
	^ (self literalValidationBlock value: literalNode) and: [ 
		(self expectedIndex isNil or: [ self expectedIndex = indexOfArgument ]) and: [
			literalNode parent isMessage and: [ 
				literalNode parent receiver ~= literalNode and: [ 
					literalNode parent selector = self selector ] ] ] ]
]
