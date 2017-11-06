.data
OddArray:  .space 100
EvenArray: .space 100

string1:  .asciiz "Input a Number:\n" 
string2:  .asciiz "\n Odd #'s:" 
string3:  .asciiz "\n Even #'s:" 
string4:  .asciiz ", "

.text
main:	
		addi $s2, $zero, 99999	# Indicator for stop input new number
		addi $s3, $zero, 0	# Initialize # of input odd numbers
		addi $s4, $zero, 0	# Initialize # of input even numbers
		la $s5, OddArray	# BaseAddress of Odd Array
		la $s6, EvenArray	# BaseAddress of Even Array
		
		# Read input number until 99999 is input. 99999 is the indicator of the end and it will not be counted as an input number.
InputLoop:	addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5      # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# input into $s1
   		
   		beq $s1, $s2, ExitLoop  # No more input if 99999 is input
   			
  		
   		# You write code here to decide whether the input is odd or even
   		# If it is odd, store into the odd array, move to the next space and increase $s3, the count of the odd numbers.
   		# If it is even, store into the even array, move to the next space and increase $s4, the count of the even numbers.
   		
   		andi $t0, $s1, 1
   		beq $t0, $zero, isEven
   		
   		la $t2, OddArray 	#Load the address of the array
   		addu $t1, $t1, $s1	#get user input
   		sb $t1, 0($t2)		#store in the array
   		addi $s3, $s3, 1	#increment # of numbers
   		addi $t2, $t2, 4	#increment pointer
   		
		j InputLoop

ExitLoop:
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall  
      		# You write the code here to print out the odd numbers in the OddArray. This is basically a for loop over $s3 elements in OddArray.
 		# The printed numbers are separted by ', ' as in string4 defined above.
 		
 		la $t1, OddArray
 		li, $t2, 0	#loop counter
 
OddLoop:
		beq $t2, $s3, Exit	#Check for array end
		
		lw $a0, ($t1)	#print block
		li $v0, 1
		syscall
		
		addi $t2, $t2, 1	#increment counter
		addi $t1, $t1, 4	#increment array pointer
		j OddLoop
		
 		     		
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall  
      		# You write the code here to print out the even numbers in the EvenArray. This is basically a for loop over $s4 elements in EvenArray.
		# The printed numbers are separted by ', ' as in string4 defined above.
		
		la $t1, EvenArray
 		li, $t2, 0	#loop counter
 
EvenLoop:
		beq $t2, $s4, Exit	#Check for array end
		
		lw $a0, ($t1)	#print block
		li $v0, 1
		syscall
		
		addi $t2, $t2, 1	#increment counter
		addi $t1, $t1, 4	#increment array pointer
		j EvenLoop

Exit:	
		# exit	
		addi $v0, $zero, 10
		syscall 

isEven:
   		la $t2, EvenArray 	#Load the address of the array
   		addu $t1, $t1, $s1	#get user input
   		sb $t1, 0($t2)		#store in the array
   		addi $s3, $s3, 1	#increment # of numbers
   		addi $t2, $t2, 4	#increment pointer		

		j InputLoop
