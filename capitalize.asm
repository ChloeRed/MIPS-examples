# This program illustrates an exercise of capitalizing a string.
# The test string is hardcoded. The program should capitalize the input string
# Comment your work

	.data

inputstring: 	.asciiz "I am a student at McGill University. "
outputstring:	.space 100
buffer:		.space 100


	.text
	.globl main

main:	li $t0, 0			#load immediate value into register 
	li $v0, 4 			#print the string 
	la $a0, inputstring
	syscall	

loop:
	lb $t1, inputstring($t0) 	#start at offset of 0 (so the beginning), load into t1
	beq $t1, 0, exit 		#if $t1 is 0, you've reached the end of the word, you're done	
	blt $t1, 'a', case		# if the byte is less than a, go to case
 	bgt $t1, 'z', case		#if the byte is greater than z, go to case 
	sub $t1, $t1, 32 		#subtract 32 from the value of t1 to make it a capital letter 
	sb $t1, inputstring($t0)	#store byte $t0 of input string in $t1

case: 
	addi $t0, $t0, 1 		#change the offset for non-lowercase letters 
	j loop				#jump back to loop  

exit:
	li $v0, 4 			#print the string 
	la $a0, inputstring
	syscall

	li $v0, 10 			#exit the program 
   	syscall
	
	
