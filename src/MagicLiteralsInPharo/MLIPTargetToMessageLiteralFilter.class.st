Class {
	#name : #MLIPTargetToMessageLiteralFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'selector'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'instance creation' }
MLIPTargetToMessageLiteralFilter class >> selector: aSymbol [
	^ self new
		selector: aSymbol;
		yourself
]

{ #category : #testing }
MLIPTargetToMessageLiteralFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isMessage and: [ 
		literalNode parent receiver = literalNode and: [ 
			literalNode parent selector = self selector ] ]
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> selector [
	^ selector
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> selector: anObject [
	selector := anObject
]
