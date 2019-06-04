Extension { #name : #CompiledMethod }

{ #category : #'*MagicLiteralsInPharo' }
CompiledMethod >> literalNodes [
	^ self ast literalNodes
]

{ #category : #'*MagicLiteralsInPharo' }
CompiledMethod >> magicLiteralNodes [
	^ self ast magicLiteralNodes
]
