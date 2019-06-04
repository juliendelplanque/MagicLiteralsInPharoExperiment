Extension { #name : #RGMethodDefinition }

{ #category : #'*MagicLiteralsInPharo' }
RGMethodDefinition >> literalNodes [
	^ self ast literalNodes
]

{ #category : #'*MagicLiteralsInPharo' }
RGMethodDefinition >> magicLiteralNodes [
	^ self ast magicLiteralNodes
]
