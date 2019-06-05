Extension { #name : #AbstractFileReference }

{ #category : #'*MagicLiteralsInPharo' }
AbstractFileReference >> mlipSuperClassesOfClassNamed: className inVersion: versionId [
	^ self sqlite3ConnectionDo: [ :connection |
		connection mlipSuperClassesOfClassNamed: className inVersion: versionId ]
]
