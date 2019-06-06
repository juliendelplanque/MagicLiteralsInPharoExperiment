Extension { #name : #RBMethodNode }

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> isMethodReturningLiteral [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: self mlipMethodReturningLiteralPredicate;
		runOn: self childrenBlock: [ :n | 
			n isMethod
				ifTrue: [ n arguments , {n body} ]
				ifFalse: [ n children ] ].
	
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> isMethodReturningPoint [
	^ TreeQuery breadthFirst
		checkMatch;
		predicate: (self mlipMethodReturningPointPredicate);
		runOn: self childrenBlock: #children.
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> literalNodes [
	^ self allChildren select: #isLiteralNode
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> magicLiteralNodes [
	| filter |
	(self isMethodReturningLiteral or: [ self isMethodReturningPoint ])
		ifTrue: [ ^ #() ].
	
	filter := MLIPCompositeMagicLiteralFilter withDefaultFilters.
	
	^ self literalNodes
		reject: [ :astNode | filter isNotMagicLiteral: astNode ]
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> mlipMethodReturningLiteralPredicate [
	^ #isMethod asTQPredicate >> { 
			#isSequence asTQPredicate >> { 
				#isReturn asTQPredicate >> { 
					#isLiteralNode asTQPredicate
				}
			} 
		}
]

{ #category : #'*MagicLiteralsInPharo' }
RBMethodNode >> mlipMethodReturningPointPredicate [
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
