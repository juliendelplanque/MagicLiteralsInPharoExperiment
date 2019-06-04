Class {
	#name : #MLIPTargetToMessageLiteralFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'selector',
		'literalType'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'instance creation' }
MLIPTargetToMessageLiteralFilter class >> selector: aSymbol literalType: aClass [
	^ self new
		selector: aSymbol;
		literalType: aClass;
		yourself
]

{ #category : #testing }
MLIPTargetToMessageLiteralFilter >> isNotMagicLiteral: literalNode [
	^ (literalNode value isKindOf: self literalType) and: [ 
		literalNode parent isMessage and: [ 
			literalNode parent receiver = literalNode and: [ 
				literalNode parent selector = self selector ] ] ]
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> literalType [
	^ literalType
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> literalType: anObject [
	literalType := anObject
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> selector [
	^ selector
]

{ #category : #accessing }
MLIPTargetToMessageLiteralFilter >> selector: anObject [
	selector := anObject
]
