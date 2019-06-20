"
A TTProjectTest is a test class for testing the behavior of TTProject
"
Class {
	#name : #TTProjectTest,
	#superclass : #TestCase,
	#category : #'TempeSt-Tests'
}

{ #category : #tests }
TTProjectTest >> testProjectCreation [

	| project name |
	
	name := self class name, '_', self selector.
	project := TTProject named: name.
	
	self assert: project isEmpty.
	
	project delete.
	
	self deny: (TTProject projects includes: project)
]
