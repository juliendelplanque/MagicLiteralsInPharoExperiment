Extension { #name : #String }

{ #category : #'*MagicLiteralsInPharo' }
String >> mlipTokens [
	| toRemove |
	toRemove := '.,?!:;"'''.
	^ self substrings collect: [ :s | (s reject: [ :c | toRemove includes: c ]) asLowercase ]
]
