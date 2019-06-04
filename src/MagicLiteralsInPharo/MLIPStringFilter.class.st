Class {
	#name : #MLIPStringFilter,
	#superclass : #MLIPMagicLiteralFilter,
	#classInstVars : [
		'trie'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #accessing }
MLIPStringFilter class >> resetTrie [
	<script>
	trie := nil
]

{ #category : #accessing }
MLIPStringFilter class >> trie [
	^ trie ifNil: [ trie := CTTrie readFromFile: '/Users/julien/Documents/GIT/english-words/words.txt' asFileReference withLineTransformer: #asLowercase ]
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
	^ 0.5
]

{ #category : #accessing }
MLIPStringFilter >> trie [
	^ self class trie
]
