Extension { #name : #ClassDescription }

{ #category : #'*MagicLiteralsInPharo' }
ClassDescription >> literalNodes [
	^ self methods flatCollect: #literalNodes
]
