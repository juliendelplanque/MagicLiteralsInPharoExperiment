Class {
	#name : #MLIPPragmaArgumentFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#category : #MagicLiteralsInPharo
}

{ #category : #testing }
MLIPPragmaArgumentFilter >> isNotMagicLiteral: literalNode [
	^ literalNode parent isPragma
]
