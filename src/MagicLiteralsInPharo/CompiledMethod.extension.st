Extension { #name : #CompiledMethod }

{ #category : #'*MagicLiteralsInPharo' }
CompiledMethod >> literalNodes [
	^ MLIPCollector extractLiteralNodesFromAST: self ast
]
