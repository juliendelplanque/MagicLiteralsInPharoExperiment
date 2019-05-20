Class {
	#name : #MLIPCollector,
	#superclass : #Object,
	#instVars : [
		'methodsWithLiterals'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #'literals extraction' }
MLIPCollector class >> extractLiteralNodesFromAST: ast [
	((self isMethodReturningLiteral: ast) or: [ self isMethodReturningPoint: ast ])
		ifTrue: [ ^ #() ].

	^ ast allChildren select: [ :n | self isLiteralNode: n ]
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
	^ astNode isLiteralNode and: [ 
		((astNode class = RBLiteralValueNode and: [ 
			astNode value isSymbol or: [ 
				(self isBooleanValue: astNode value) or: [
					astNode value isNil  ] ] ]) or: [ 
						(self isPragmasArgument: astNode) or: [ 
							self isDirectlyAssigned: astNode ] ]) not ]
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
