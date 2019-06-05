Extension { #name : #SQLite3Connection }

{ #category : #'*MagicLiteralsInPharo' }
SQLite3Connection >> mlipSuperClassesOfClassNamed: className inVersion: versionId [
	^ self execute: 'WITH RECURSIVE
	super_class_of(id, name, category, super, pharo_version_id) AS (
		SELECT class.id, class.name, class.category, super, pharo_version_id
		FROM class
		WHERE class.name = ? AND pharo_version_id = ?
		UNION
			SELECT class.id, class.name, class.category, class.super, class.pharo_version_id
			FROM super_class_of, class
			WHERE class.name = super_class_of.super
				AND class.pharo_version_id = super_class_of.pharo_version_id
) SELECT * FROM super_class_of;' value: className value: versionId
]
