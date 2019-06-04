Extension { #name : #RBMethodNode }

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> literalNodes [
	^ self allChildren select: #isLiteralNode
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> magicLiteralNodes [
	^ MLIPExtractor extractMagicLiterals: self
]
