Extension { #name : #BinaryFileStream }

{ #category : #'*TempeSt' }
BinaryFileStream >> readStreamEncoded: anEncoding [

	^ ZnCharacterReadStream
		on: self
		encoding: anEncoding
]
