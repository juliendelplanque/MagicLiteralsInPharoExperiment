Extension { #name : #RBLiteralNode }

{ #category : #'*MagicLiteralsInPharo' }
RBLiteralNode >> occurencesInClass [
	^ self methodNode method methodClass literalNodes select: [ :literalNode |
		literalNode value = self value ]
]
