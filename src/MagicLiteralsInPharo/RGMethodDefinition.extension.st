Extension { #name : #RGMethodDefinition }

{ #category : #'*MagicLiteralsInPharo' }
RGMethodDefinition >> literalNodes [
	^ MLIPCollector extractLiteralNodesFromAST: self ast
]
