Class {
	#name : #MLIPCompositeMagicLiteralFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'filters'
	],
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #'instance creation' }
MLIPCompositeMagicLiteralFilter class >> filters: aCollectionOfMLIPMagicLiteralFilter [
	^ self new
		addAllFilters: aCollectionOfMLIPMagicLiteralFilter;
		yourself
]

{ #category : #'instance creation' }
MLIPCompositeMagicLiteralFilter class >> withDefaultFilters [
	^ self filters: { 
		MLIPBooleanFilter new.
		MLIPDirectlyAssignedFilter new.
		MLIPEmptyLiteralArrayFilter new.
		MLIPNilFilter new.
		MLIPPragmaArgumentFilter new.
		MLIPStringFilter new.
		MLIPSymbolFilter new.
		MLIPLiteralInLiteralArrayFilter new.
		MLIPArgumentOfMessageLiteralFilter selector: #extent:depth:fromArray:offset: literalType: ByteArray index: 3.
		MLIPArgumentOfMessageLiteralFilter selector: #+ literalValue: 1 index: 1.
		MLIPArgumentOfMessageLiteralFilter selector: #- literalValue: 1 index: 1 } ,
		(#(#to: #to:by: #to:do: #timesRepeat:) collect: [ :selector | MLIPTargetToMessageLiteralFilter selector: selector literalType: Integer ]) ,
		(#(#nextPut: #<<) collect: [ :selector | MLIPArgumentOfMessageLiteralFilter selector: selector literalType: Character ]) ,
		(#(#nextPutAll: #<< #name:) collect: [ :selector | MLIPArgumentOfMessageLiteralFilter selector: selector literalType: String ])
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
