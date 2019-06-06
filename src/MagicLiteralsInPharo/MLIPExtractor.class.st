Class {
	#name : #MLIPExtractor,
	#superclass : #Object,
	#classInstVars : [
		'trie'
	],
	#category : #'MagicLiteralsInPharo-Core'
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
