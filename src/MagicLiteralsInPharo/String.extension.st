Extension { #name : #String }

{ #category : #'*MagicLiteralsInPharo' }
String >> mlipKnownWordsRatioWith: trie [
	^ self mlipTokens in: [ :tokens |
		(tokens count: [ :word | trie contains: word asLowercase ]) / (tokens size max: 1) ]
]

{ #category : #'*MagicLiteralsInPharo' }
String >> mlipTokens [
	^ self substrings collect: [ :s | s asLowercase select: #isLetter ]
]
