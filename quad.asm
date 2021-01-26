	.data

firstMessage: .asciiz "Please input an int a: "
secondMessage: .asciiz "Please input an int b: " 
thirdMessage: .asciiz "Please input an int c: " 
amodb: .asciiz "\na mod b = "
answers: .asciiz " \nAnswer: " 
noSol: .asciiz "\nNo Solution"  
	
	.text
	.globl main
	
main: 				#prompting user for input a
	addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, firstMessage	#displaying first message
	syscall 

	
	addi $v0, $zero, 5	#reading the input given for a
	syscall 
	
	move $t0, $v0		#storing user input for a into $t0 
	
				#prompting user for input b
	addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, secondMessage	#displaying second message
	syscall 

	addi $v0, $zero, 5	#reading the input given for b
	syscall 
	
	move $t1, $v0		#storing user input for b into $t1 
		
				#prompting user for input c
	addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, thirdMessage	#displaying third message
	syscall 

	addi $v0, $zero, 5	#reading the input given for c
	syscall 
	
	move $t2, $v0		#storing user input for c into $t2
	
	div $t0, $t1		#divide a by b
	
	mfhi $t3		#store remainder in $t3 
	
	addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, amodb		#displaying a mod b = 
	syscall 
	
	li $v0, 1		#print a mod b
	move $a0, $t3
	syscall
	
	li $t4, 0		#loop through numbers less than c (x= 0 ==> c is stored in $t4)
	addi $t7, $t2, 1	#store one more than c into $t7
	
	li $s0, 0
	
loop: 	beq $t4, $t7, exit 	#if x is greater than c ($t7-1), go to exit
	add $t4, $t4, 1		#increment $t4 (x) 
	
	mult $t4, $t4 		#square current x
	mflo $t5 		#obtain the lower bits and store it in $t5
	
	div $t5, $t1		#divide x^2 by b
	
	mfhi $t6		#obtain the divisor and store it in $t6
	
	beq $t6,$t3, print	#if $t6 is equal to a mod b, go to print answer
	
	j loop 			#loop back 
	

	
	
print: 	addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, answers		#print message for answers
	syscall 
	
	li $v0, 1		#storing value 1 into $v0 to make correct system call
	move $a0, $t4		#move value of $t4 into $a0 
	syscall
	
	addi $s0, $s0, 1	#add 1 to this increment (to see if there were any solutions)
	
	j loop			#loop back 
	

exit: 	beq $s0, 0, noSolution	#if $s0 = 0, then there were no solutions
	j end			#else, go to the end
	
	
noSolution: addi $v0, $zero, 4	#storing value 4 into $v0 to make correct system call
	la $a0, noSol		#print the message no Solution
	syscall 
	
	j end			#go to the end
	
end: 	li $v0, 10		#end the program
	syscall

	
	
	
