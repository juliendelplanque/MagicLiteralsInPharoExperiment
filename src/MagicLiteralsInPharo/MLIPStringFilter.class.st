Class {
	#name : #MLIPStringFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#instVars : [
		'knownWordsRatioThreshold'
	],
	#classInstVars : [
		'trie'
	],
	#category : #'MagicLiteralsInPharo-Filters'
}

{ #category : #accessing }
MLIPStringFilter class >> defaultKnownWordsRatioThreshold [
	^ 0.5
]

{ #category : #accessing }
MLIPStringFilter class >> resetTrie [
	<script>
	trie := nil
]

{ #category : #accessing }
MLIPStringFilter class >> trie [
	^ trie ifNil: [ |memoryFile|
		memoryFile := FileSystem memory / 'words.txt'.
		memoryFile writeStreamDo: [ :s |
			s nextPutAll: (ZnEasy get: 'https://github.com/dwyl/english-words/blob/master/words.txt?raw=true') contents ].
		trie := CTTrie readFromFile: memoryFile withLineTransformer: #asLowercase.
		memoryFile ensureDelete.
		trie ]
]

{ #category : #accessing }
MLIPStringFilter >> defaultKnownWordsRatioThreshold [
	^ self class defaultKnownWordsRatioThreshold
]

{ #category : #testing }
MLIPStringFilter >> isNotMagicLiteral: literalNode [
	^ literalNode class = RBLiteralValueNode
		and: [ literalNode value isString
				and: [ literalNode value isEmpty
						or: [ (literalNode value mlipKnownWordsRatioWith: self trie) > self knownWordsRatioThreshold ] ] ]
]

{ #category : #testing }
MLIPStringFilter >> knownWordsRatioThreshold [
	^ knownWordsRatioThreshold ifNil: [ knownWordsRatioThreshold := self defaultKnownWordsRatioThreshold ]
]

{ #category : #accessing }
MLIPStringFilter >> knownWordsRatioThreshold: anObject [
	knownWordsRatioThreshold := anObject
]

{ #category : #accessing }
MLIPStringFilter >> trie [
	^ self class trie
]
