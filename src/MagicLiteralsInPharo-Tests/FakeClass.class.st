Class {
	#name : #FakeClass,
	#superclass : #Object,
	#category : #'MagicLiteralsInPharo-Tests'
}

{ #category : #'as yet unclassified' }
FakeClass >> methodReturningLiteral [
	^ 42
]

{ #category : #'as yet unclassified' }
FakeClass >> methodReturningPoint [
	^ 42@1
]
