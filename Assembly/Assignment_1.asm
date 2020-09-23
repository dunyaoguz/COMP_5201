.text

	set r1, 1024       #r1 = address of a[0]
	set r2, 2048       #r2 = address of b[0]
	addi r2, r2, 248   #r2 = address of b[31]	
	addi r3, r1, 256   #r3 = address of the byte immediately following end of array a[]

	loop:
		l.d f4, 0(r1)       	#/f4 = a[j]
		l.d f6, 0(r2)       	#f6 = b[n-j-1]
		mul.d f0, f4, f6   	#f0 = a[j] * b[n-j-1]
		addi r1, r1, 8       #r1 = address of a[j+1]
		subi r2, r2, 8       #r2 = address of a[n-(j+1)-1]
   		bne r1, r3, loop   	#if(r1 != r3) branch to loop