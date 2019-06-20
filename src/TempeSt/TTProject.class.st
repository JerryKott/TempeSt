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

{ #category : #'class initialization' }
TTProject class >> initialize [
	"self initialize"
	
	projects := Dictionary new
]

{ #category : #'class initialization' }
TTProject class >> named: aString [

	^ self projects at: aString ifAbsentPut: [ self newProjectNamed: aString ]
]

{ #category : #'class initialization' }
TTProject class >> newProjectNamed: aString [

	^ self new
		projectName: aString;
		yourself
]

{ #category : #accessing }
TTProject class >> projects [
	^ projects
]

{ #category : #initialization }
TTProject >> initialize [
	
	super initialize.
	notes := OrderedCollection new.
	resources := Set new.
]

{ #category : #accessing }
TTProject >> projectName [
	^ projectName
]

{ #category : #accessing }
TTProject >> projectName: anObject [
	projectName := anObject
]
