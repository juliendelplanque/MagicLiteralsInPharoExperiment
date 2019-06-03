Extension { #name : #String }

{ #category : #'*MagicLiteralsInPharo' }
String >> mlipKnowWordsRatioWith: trie [
	^ self mlipTokens in: [ :tokens |
		(tokens count: [ :word | trie contains: word asLowercase ]) / tokens size ]
]

{ #category : #'*MagicLiteralsInPharo' }
String >> mlipTokens [
	| toRemove |
	toRemove := '.,?!:;"'''.
	^ self substrings collect: [ :s | (s reject: [ :c | toRemove includes: c ]) asLowercase ]
]
