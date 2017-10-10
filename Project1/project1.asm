.data
baseadd:  .word 43, -5, 11, -12, 64, -7, 14, 71, 103, 13, -27

string1:  .asciiz "Index i [0~10]:\n" 
string2:  .asciiz "Index j [0~10]:\n" 
string3:  .asciiz "\n A[i]=" 
string4:  .asciiz "\n A[j]=" 
string5:  .asciiz "\n A[i]+A[j]=" 
string6:  .asciiz "\n A[i]-A[j]=" 


.text
main:	
		# Read input i to $s1
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5      # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# i in $s1
 
 		# Read input j to $s2
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
   		#  Write code here to read input j to $s2
		addi $v0, $zero, 5
		syscall
		add $s2, $v0, $zero
		
   		#baseadd of the array to $s5
   		la $s5, baseadd    	
  		
   		# Write code here to load A[i] to $s3
   		li $t2, $s2 
   		add $t2, $t2, $t2
   		add $t2, $t2, $t2
   		add $t1, $t2, $s5
   		lw $s3, 0($t1)   
   		# Print A[i] from $s3	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s3, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

		# Write code here to load and print A[j]	  
		li $t2, $s2 
   		add $t2, $t2, $t2
   		add $t2, $t2, $t2
   		add $t1, $t2, $s5
   		lw $s4, 0($t1)   
   		# Print A[j] from $s3	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s4, $zero	
		addi $v0,$zero,1	# prints integer
		syscall		
										
		# Write code here to compute and print A[i]+A[j]	  
		add $t1, $s3, $s4
		addi $v0, $zero, 4
		la $t1, string5
		syscall
		add $a0, $t1, $zero
		addi $v0, $zero, 1
		syscall
 		# Write code here to compute and print A[i]-A[j]	  
		sub $t1, $s3, $s4
		subi $v0, $zero, 4
		la $t1, string5
		syscall
		sub $a0, $t1, $zero
		subi $v0, $zero, 1
		syscall
		# exit	
		addi $v0, $zero, 10
		syscall 

		

