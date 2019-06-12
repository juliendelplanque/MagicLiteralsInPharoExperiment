Class {
	#name : #MLIPValueFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'value'
	],
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #accessing }
MLIPValueFilter class >> value: anObject [
	^ self new
		value: anObject;
		yourself
]

{ #category : #testing }
MLIPValueFilter >> isNotMagicLiteral: literalNode [
	^  literalNode class = RBLiteralValueNode and: [ literalNode value = self value ]
]

{ #category : #accessing }
MLIPValueFilter >> value [
	^ value
]

{ #category : #accessing }
MLIPValueFilter >> value: anObject [
	value := anObject
]
