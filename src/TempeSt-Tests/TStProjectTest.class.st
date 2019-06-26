"
A TTProjectTest is a test class for testing the behavior of TTProject
"
Class {
	#name : #TStProjectTest,
	#superclass : #TestCase,
	#category : #'TempeSt-Tests'
}

{ #category : #tests }
TStProjectTest >> testProjectCreation [

	| project name |
	
	name := self class name, '_', self selector.
	project := TStProject named: name.
	
	self assert: project isEmpty.
	
	project delete.
	
	self deny: (TStProject projects includes: project)
]
