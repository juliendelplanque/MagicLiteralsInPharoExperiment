Class {
	#name : #MLIPExtractor,
	#superclass : #Object,
	#classInstVars : [
		'trie'
	],
	#category : #MagicLiteralsInPharo
}

{ #category : #adding }
MLIPExtractor class >> addIsTestCaseColumnOnClassTableIn: fileReference [
	fileReference sqlite3ConnectionExecute: 'ALTER TABLE class ADD COLUMN is_test_case BOOLEAN;'.

	fileReference sqlite3ConnectionDo: [ :connection |
		|cursor row|
		cursor := (connection execute: 'SELECT * FROM class;').
		[ (row := cursor next) isNotNil ]
			whileTrue: [ |superClassesCursor superRow isTestCase|
				superClassesCursor := (connection mlipSuperClassesOfClassNamed: (row atColumnNamed: 'name') inVersion: (row atColumnNamed: 'pharo_version_id')).
				isTestCase := false.
			[ (superRow := superClassesCursor next) isNotNil ]
				whileTrue: [ 
					isTestCase := isTestCase or: [ (superRow atColumnNamed: 'name') = 'TestCase' ] ].
			connection execute: 'UPDATE class SET is_test_case = ? WHERE name = ? AND pharo_version_id = ?' value: isTestCase value: (row atColumnNamed: 'name') value: (row atColumnNamed: 'pharo_version_id') ] ].
]

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
