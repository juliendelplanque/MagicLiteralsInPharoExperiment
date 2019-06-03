Class {
	#name : #MLIPCollector,
	#superclass : #Object,
	#instVars : [
		'methodsWithLiterals'
	],
	#classInstVars : [
		'trie'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'literals extraction' }
MLIPCollector class >> extractLiteralNodesFromAST: ast [
	^ ast allChildren select: [ :n | self isLiteralNode: n ]
]

{ #category : #'magic extraction' }
MLIPCollector class >> extractMagicLiterals: ast [
	((self isMethodReturningLiteral: ast) or: [ self isMethodReturningPoint: ast ])
		ifTrue: [ ^ #() ].
		
	^ (self extractLiteralNodesFromAST: ast) reject: [ :astNode |
		(astNode class = RBLiteralValueNode and: [ 
			astNode value isSymbol or: [ 
				(self isBooleanValue: astNode value) or: [
					astNode value isNil
						or: [ astNode value isString and: [ astNode value isEmpty ] ] ] ] ]) or: [ 
						(self isPragmasArgument: astNode) or: [ 
							(self isDirectlyAssigned: astNode) or: [ 
								astNode isLiteralArray and: [ astNode contents isEmpty ] ] ] ] ]
]

{ #category : #testing }
MLIPCollector class >> isBooleanValue: astNode [
	^ #(true false) includes: astNode value
]

{ #category : #testing }
MLIPCollector class >> isDirectlyAssigned: literalNode [
	^ literalNode parent isAssignment
]

{ #category : #testing }
MLIPCollector class >> isLiteralNode: astNode [
	^ astNode isLiteralNode
]

{ #category : #testing }
MLIPCollector class >> isMethodReturningLiteral: ast [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: self methodReturningLiteralPredicate;
		runOn: ast childrenBlock: [ :n | 
			n isMethod
				ifTrue: [ n arguments , {n body} ]
				ifFalse: [ n children ] ].
	
]

{ #category : #testing }
MLIPCollector class >> isMethodReturningPoint: ast [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: (MLIPCollector methodReturningPointPredicate);
		runOn: ast childrenBlock: #children.
]

{ #category : #testing }
MLIPCollector class >> isPragmasArgument: literalNode [
	^ literalNode parent isPragma
]

{ #category : #predicates }
MLIPCollector class >> methodReturningLiteralPredicate [
	^ #isMethod asTQPredicate >> { 
			#isSequence asTQPredicate >> { 
				#isReturn asTQPredicate >> { 
					#isLiteralNode asTQPredicate
				}
			} 
		}
]

{ #category : #predicates }
MLIPCollector class >> methodReturningPointPredicate [
	^ #isMethod asTQPredicate >> { 
		#isSequence asTQPredicate >> { 
			#isReturn asTQPredicate >> { 
				[ :n | n isMessage and: [ n selector = #@ ] ] asTQPredicate >> { 
					[ :n | n isLiteralNode and: [ n value isNumber ] ] asTQPredicate.
					[ :n | n isLiteralNode and: [ n value isNumber ] ] asTQPredicate
				}
			}
		}
	}
]

{ #category : #accessing }
MLIPCollector class >> trie [
	^ trie ifNil: [ trie := CTTrie readFromFile: '/Users/julien/Documents/GIT/english-words/words.txt' ]
]

{ #category : #collecting }
MLIPCollector >> collectAllMethodsWithLiterals [
	^ SystemNavigation default allMethodsSelect: [ :m |
			m literalNodes isNotEmpty ]
]

{ #category : #accessing }
MLIPCollector >> methodsWithLiterals [
	^ methodsWithLiterals ifNil: [ methodsWithLiterals := self collectAllMethodsWithLiterals ]
]

{ #category : #accessing }
MLIPCollector >> methodsWithLiterals: anObject [
	methodsWithLiterals := anObject
]

{ #category : #collecting }
MLIPCollector >> methodsWithMagicLiterals [
	^ self methodsWithLiterals reject: [ :m |
		m literalNodes allSatisfy: [ :n | n class = RBLiteralValueNode and: [ n value isString ] ] ]
]
