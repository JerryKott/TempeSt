"
A TStBashScriptTest is a test class for testing the behavior of TStBashScript
"
Class {
	#name : #TStBashScriptTest,
	#superclass : #TestCase,
	#category : #'TempeSt-Tests'
}

{ #category : #tests }
TStBashScriptTest >> testBashEcho [

	| result |
	result := TStBashScript new
		addCommand: 'echo -n "Hello"';
		doIt.
	
	self assert: result equals: 'Hello'
]

{ #category : #tests }
TStBashScriptTest >> testBashId [

	| result |
	result := TStBashScript new
		addCommand: 'id';
		doIt.
	
	self assert: ('uid*gid*' match: result)
]

{ #category : #tests }
TStBashScriptTest >> testBashStreamEcho [

	| result |

	result := ReadWriteStream on: String new.
	
	TStBashScript new
		addCommand: 'echo -n "Hello"';
		readStreamDo: [ :stream |
			[stream atEnd] whileFalse: [result nextPut: stream next]].

	self assert: result contents equals: 'Hello'
]

{ #category : #tests }
TStBashScriptTest >> testPingSweep [

	| results range bashScript |

	results := OrderedCollection new.
	range := 1 to: 254.
	
	bashScript := TStBashScript new.
	
	range do: [  :each |
		| ip command |
		ip := '192.168.0.', each printString.
		command := 'ping -c 1 ', ip, ' | grep "bytes from" &'.
		bashScript addCommand: command ].

	bashScript readStreamDo: [ :stream |
			[stream atEnd] whileFalse: [results add: stream nextLine]].

	self assert: results notEmpty
]
