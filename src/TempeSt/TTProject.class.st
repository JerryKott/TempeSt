Class {
	#name : #TTProject,
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
TTProject class >> deleteProject: aProject [

	^ self projects removeKey: aProject projectName ifAbsent: [ nil ]
]

{ #category : #'class initialization' }
TTProject class >> initialize [
	"self initialize"
	
	projects := Dictionary new
]

{ #category : #accessing }
TTProject class >> named: aString [

	^ self projects at: aString ifAbsentPut: [ self newProjectNamed: aString ]
]

{ #category : #'instance creation' }
TTProject class >> newProjectNamed: aString [

	^ self new
		projectName: aString;
		yourself
]

{ #category : #accessing }
TTProject class >> projects [
	^ projects
]

{ #category : #actions }
TTProject >> delete [ 

	self class deleteProject: self
]

{ #category : #initialization }
TTProject >> initialize [
	
	super initialize.
	notes := OrderedCollection new.
	resources := Set new.
]

{ #category : #testing }
TTProject >> isEmpty [ 

	^ self notes isEmpty and: [ self resources isEmpty ]
]

{ #category : #accessing }
TTProject >> notes [ 

	^notes
]

{ #category : #accessing }
TTProject >> projectName [
	^ projectName
]

{ #category : #accessing }
TTProject >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
TTProject >> resources [ 

	^resources
]
