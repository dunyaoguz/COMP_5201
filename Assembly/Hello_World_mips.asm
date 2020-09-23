.data		#The information is stored in Random Access Memory

		myMessage: .asciiz "Hello World !\n"

.text		#Contains the instructions
		
	li $v0, 4		#li: Load Immediate
	la $a0, myMessage	#la: Load Address
	syscall