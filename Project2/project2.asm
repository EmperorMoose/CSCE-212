#A. Pierce Matthews
#CSCE-212
#10/10/2017
.data
baseadd:  .word 43, -5, 11, -12, 64, -7, 14, 71, 103, 13, -27

string1:  .asciiz "Index i [0~10]:\n" 
string2:  .asciiz "\n MIN=" 
string3:  .asciiz "\n MAX=" 

.text
main:	
		# Input i to $s1
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5      # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# i in $s1
    		
   		#baseadd of the array to $s5
   		la $s5, baseadd   
   		
   		#Load A[0] to initialize MIN ($s6) and MAX ($s7)
   		lw $s6, ($s5)
   		lw $s7, ($s5) 	
  		
  		# initialize j=0 (j in $t1)
  		add $t1, $zero, $zero
  		
  		# You write code here to implement the following C code.
 		# This will find the MIN ($s6) and MAX ($s7) 
 		# in the array from A[0] through A[i].
 		# Note that you need to use lw to load A[j].
 
   		# while (j<=i)
  		#	{
  		#	if A[j]<MIN
  		#		MIN=A[j];
  		#	if A[j]>MAX
  		#		MAX=A[j];
  		#	j=j+1;
  		#	}
  		
  loop:		sle $t2, $t1, $s1
  		beq $t2, $zero, Exit #main while loop
  		sll $t1, $t1, 2		#j as byte offset
  		
  		lw $t3, 28($t1)       #A[i]
  		blt $t3, $s6, firstIf #If checks
  		bgt $t3, $s7, secondIf
  		j EndofLoop
  
  firstIf:	move $t3, $s6
  		j loop
  
  secondIf:	move $t3, $s6
  		j loop
  		
  EndofLoop:	addi $t0, $zero, 1
  		add $t1, $t1, $t0
   
     		# Print MIN from s6	
  Exit: 	addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s6, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

    		# Print MAX from s7	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s7, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

		# exit	
		addi $v0, $zero, 10
		syscall 

		

