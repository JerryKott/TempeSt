Class {
	#name : #TStBashScript,
	#superclass : #Object,
	#instVars : [
		'commands',
		'tempDir',
		'input',
		'output'
	],
	#category : #TempeSt
}

{ #category : #'instance creation' }
TStBashScript class >> new [

	^ super new initialize 
]

{ #category : #actions }
TStBashScript >> addCommand: aString [

	commands add: aString
]

{ #category : #enumerating }
TStBashScript >> createPipes [

	tempDir := self resultOfCommand: 'echo -n $(mktemp -d)'.
	input := tempDir , '/pipeIn'.
	output := tempDir , '/pipeOut'.
	self runCommand: 'mkfifo ' , input.
	self runCommand: 'mkfifo ' , output
]

{ #category : #enumerating }
TStBashScript >> doIt [

	| resultStream |

	resultStream := ReadWriteStream on: String new.
	self readStreamDo: [ :stream | 
			[stream atEnd] whileFalse: [resultStream nextPut: stream next]].
	^ resultStream contents
]

{ #category : #enumerating }
TStBashScript >> execute [

	| bashCommand |

	self createPipes.
	bashCommand := 'cat ' , input , ' | bash > ' , output , ' &'.
	self runCommand: 'bash -c "' , bashCommand , '"'.

	50 milliSeconds wait.
	(File named: input) writeStreamDo: [ :stream | 
		commands do: [ :eachCommand | 
			stream nextPutAll: eachCommand; lf ] ].
	50 milliSeconds wait
]

{ #category : #enumerating }
TStBashScript >> finish [

	self runCommand: 'rm input'.
	self runCommand: 'rm output'.
	self runCommand: 'rm -rf ' , tempDir
]

{ #category : #initialization }
TStBashScript >> initialize [ 

	super initialize.
	commands := OrderedCollection new
]

{ #category : #'lib-C' }
TStBashScript >> pipe: command mode: mode [

	^ LibC pipe: command mode: mode 
]

{ #category : #actions }
TStBashScript >> readStreamDo: aBlock [

	self execute.
	^ [(File named: output) readStreamDo: [ :pipe |
		aBlock value: (pipe readStreamEncoded: 'utf-8') ]] ensure: [ self finish ]

]

{ #category : #'lib-C' }
TStBashScript >> resultOfCommand: anOSCommandString [

	^ LibC uniqueInstance resultOfCommand: anOSCommandString 
]

{ #category : #'lib-C' }
TStBashScript >> runCommand: anOSCommandString [

	^ LibC uniqueInstance runCommand: anOSCommandString 
]
