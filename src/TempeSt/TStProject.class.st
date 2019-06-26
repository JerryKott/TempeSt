Class {
	#name : #TStProject,
	#superclass : #Object,
	#instVars : [
		'projectName',
		'resources',
		'notes'
	],
	#classInstVars : [
		'projects'
	],
	#category : #TempeSt
}

{ #category : #actions }
TStProject class >> deleteProject: aProject [

	^ self projects removeKey: aProject projectName ifAbsent: [ nil ]
]

{ #category : #'class initialization' }
TStProject class >> initialize [
	"self initialize"
	
	projects := Dictionary new
]

{ #category : #accessing }
TStProject class >> named: aString [

	^ self projects at: aString ifAbsentPut: [ self newProjectNamed: aString ]
]

{ #category : #'instance creation' }
TStProject class >> newProjectNamed: aString [

	^ self new
		projectName: aString;
		yourself
]

{ #category : #accessing }
TStProject class >> projects [
	^ projects
]

{ #category : #actions }
TStProject >> delete [ 

	self class deleteProject: self
]

{ #category : #initialization }
TStProject >> initialize [
	
	super initialize.
	notes := OrderedCollection new.
	resources := Set new.
]

{ #category : #testing }
TStProject >> isEmpty [ 

	^ self notes isEmpty and: [ self resources isEmpty ]
]

{ #category : #accessing }
TStProject >> notes [ 

	^notes
]

{ #category : #accessing }
TStProject >> projectName [
	^ projectName
]

{ #category : #accessing }
TStProject >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
TStProject >> resources [ 

	^resources
]
