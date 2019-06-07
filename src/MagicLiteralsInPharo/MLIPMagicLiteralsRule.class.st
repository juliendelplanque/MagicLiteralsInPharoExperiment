Class {
	#name : #MLIPMagicLiteralsRule,
	#superclass : #ReNodeBasedRule,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPMagicLiteralsRule class >> checksNode [

	^ true
]

{ #category : #running }
MLIPMagicLiteralsRule >> check: aNode forCritiquesDo: aBlock [
	(aNode isLiteralNode and: [ aNode parents first magicLiteralNodes includes: aNode ])
		ifTrue: [ aBlock cull: (self critiqueFor: aNode) ]
]

{ #category : #accessing }
MLIPMagicLiteralsRule >> group [

	^ 'Coding Idiom Violation'
]

{ #category : #accessing }
MLIPMagicLiteralsRule >> name [
	^ 'Magic literals'
]

{ #category : #accessing }
MLIPMagicLiteralsRule >> rationale [
	^ 'Magic literal should be extracted either in method or class variable.'
]

{ #category : #accessing }
MLIPMagicLiteralsRule >> severity [
	^ #warning
]
