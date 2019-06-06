Class {
	#name : #MLIPPragmaArgumentFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #testing }
MLIPPragmaArgumentFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isPragma
]
