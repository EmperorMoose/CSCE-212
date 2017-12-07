.data
size: .word  0
arr:  .float  0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0 
FPNum:  .word 0x0  # Float-point numbers 0
FPNum2: .word 0x1  # Float-point numbers 1
string1: .asciiz "Input a Float-Point #:(0 indicates the end)\n"
string2: .asciiz "\n Sorting Result:" 
string3: .asciiz ", "
string4: .asciiz "\n Inputted Numbers:"  

.text
main:
		la $s0,size  #0
 		lw $s1,0($s0)      # size in $s1
 		ori $s2,$zero,0    # i in $s2
 		la $s3,arr         # arr in $s3
 		
 		la $t0, FPNum
 		la $t1, FPNum2
 		lwc1 $f11, ($t1) # $f11=1.0
		lwc1 $f10, ($t0) 	# $f10=0.0
		addi $s1, $zero, 0	# FP number counts in array
 		
	# Input a number 
InputLoop:	addi $v0, $zero, 4 
      		la $a0, string1 	# load string to be printed into $a0    
      		syscall         	
		addi $v0, $zero, 6      # code for reading FP number is 6 
   		syscall           	# call operating system  

		add.s $f1, $f0, $f10	# move input fp number to $f1
		c.eq.s $f1, $f10
		bc1t DONE
		swc1 $f1,0($s3) 	#stores input into array 
  		j UPDATE

UPDATE:
  		addi $s3,$s3,4		
  		addi $s1,$s1,1 		#size = size +1 
 		
		j InputLoop

DONE:
		li $v0,4
  		la $a0,string4	
  		syscall			#prints "inputted numbers"

  		la $t0,arr
  		ori $t1,$zero,0
L2:					#loop for printing inputted numbers 
   		beq $t1,$s1,OutterLoop
   		
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system
      		
   		lwc1 $f20,0($t0)
   		li $v0,2
   		mov.s $f12,$f20
   		syscall
 
   		addi $t0,$t0,4
   		addi $t1,$t1,1
   		j L2

OutterLoop:				#determines when we are done iterating
		add.s $f1, $f10, $f10		#$f1 determine when the list is done sorting
		la $s4, arr		#sets $s4 to the base address of the Array
InnerLoop:				#inner loop will iterate over the array
		lwc1 $f2, 0($s4)	# $f2 = Mem[ $s4 + 0] first element 
		lwc1 $f3, 4($s4)	# $f3 = Mem[ $s4 + 4] second element
		c.lt.s $f2, $f3 	# if $f2 < $f3 = 1
		bc1t continue   # if f2 < f3 = 1, then swap them
		c.eq.s $f3,$f10 # if $f3 is 0, its the end of the array so dont swap 
		bc1t continue   # just go to continue, otherwise proceed to swap
  		add.s $f1, $f10, $f11     # if we need to swap, we need to check the list again
   	 	swc1 $f2, 4($s4)         # store the greater numbers contents in the higher position in array (swap)
    		swc1 $f3, 0($s4)         # store the lesser numbers contents in the lower position in array (swap)

continue:
    		addi $s4, $s4, 4            # advance the array to start at the next location from last time
    		bne $s4, $s3, InnerLoop    # If $s4 != the end of Array, jump back to innerLoop
    		c.eq.s  $f1,$f10    # $f1 = 1, another pass is needed, jump back to outterLoop
    		bc1f OutterLoop
    		j EXIT

EXIT:
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system
      		#j L3
      		
		la $t0,arr
  		ori $t1,$zero,0
L3:					#loop for printing inputted numbers 
   		beq $t1,$s1,EXIT2
   		
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system
      		
   		lwc1 $f20,0($t0)
   		li $v0,2
   		mov.s $f12,$f20
   		syscall
 
   		addi $t0,$t0,4
   		addi $t1,$t1,1
   		j L3
EXIT2:		
  		li $v0,10
  		syscall
