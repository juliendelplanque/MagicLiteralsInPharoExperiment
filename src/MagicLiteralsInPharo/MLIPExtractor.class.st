Class {
	#name : #MLIPExtractor,
	#superclass : #Object,
	#classInstVars : [
		'trie'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'magic extraction' }
MLIPExtractor class >> extractMagicLiterals: ast [
	| filter |
	((self isMethodReturningLiteral: ast) or: [ self isMethodReturningPoint: ast ])
		ifTrue: [ ^ #() ].
	
	filter := MLIPCompositeMagicLiteralFilter withDefaultFilters.
	
	^ ast literalNodes
		reject: [ :astNode | filter isNotMagicLiteral: astNode ]
]

{ #category : #testing }
MLIPExtractor class >> isMethodReturningLiteral: ast [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: self methodReturningLiteralPredicate;
		runOn: ast childrenBlock: [ :n | 
			n isMethod
				ifTrue: [ n arguments , {n body} ]
				ifFalse: [ n children ] ].
	
]

{ #category : #testing }
MLIPExtractor class >> isMethodReturningPoint: ast [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: (MLIPExtractor methodReturningPointPredicate);
		runOn: ast childrenBlock: #children.
]

{ #category : #predicates }
MLIPExtractor class >> methodReturningLiteralPredicate [
	^ #isMethod asTQPredicate >> { 
			#isSequence asTQPredicate >> { 
				#isReturn asTQPredicate >> { 
					#isLiteralNode asTQPredicate
				}
			} 
		}
]

{ #category : #predicates }
MLIPExtractor class >> methodReturningPointPredicate [
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
