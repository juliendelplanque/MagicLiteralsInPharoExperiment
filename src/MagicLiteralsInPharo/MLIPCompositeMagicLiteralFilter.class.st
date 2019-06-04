Class {
	#name : #MLIPCompositeMagicLiteralFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'filters'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'instance creation' }
MLIPCompositeMagicLiteralFilter class >> filters: aCollectionOfMLIPMagicLiteralFilter [
	^ self new
		addAllFilters: aCollectionOfMLIPMagicLiteralFilter;
		yourself
]

{ #category : #'as yet unclassified' }
MLIPCompositeMagicLiteralFilter class >> withDefaultFilters [
	^ self filters: { 
		MLIPBooleanFilter new.
		MLIPDirectlyAssignedFilter new.
		MLIPEmptyLiteralArrayFilter new.
		MLIPNilFilter new.
		MLIPPragmaArgumentFilter new.
		MLIPStringFilter new.
		MLIPSymbolFilter new }
]

{ #category : #adding }
MLIPCompositeMagicLiteralFilter >> addAllFilters: aCollectionOfFilters [
	self filters addAll: aCollectionOfFilters
]

{ #category : #adding }
MLIPCompositeMagicLiteralFilter >> addFilters: aFilter [
	self filters add: aFilter
]

{ #category : #accessing }
MLIPCompositeMagicLiteralFilter >> filters [
	^ filters
]

{ #category : #accessing }
MLIPCompositeMagicLiteralFilter >> filters: anObject [
	filters := anObject
]

{ #category : #initialization }
MLIPCompositeMagicLiteralFilter >> initialize [
	super initialize.
	self filters: OrderedCollection new
	
]

{ #category : #testing }
MLIPCompositeMagicLiteralFilter >> isNotMagicLiteral: literalNode [
	^ self filters anySatisfy: [ :filter | filter isNotMagicLiteral: literalNode ]
]
