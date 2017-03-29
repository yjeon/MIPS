.data
promptInput:	.asciiz "Number to check? "
promptOutput: 	.asciiz "Binary pattern: "
resultYes:	.asciiz "It is a binary palindrome."
resultNo:	.asciiz	"It is not a binary palindrome."
promptTest: 	.asciiz "\ntest"


.text
main:
	la $a0, promptInput					#ask user input
	li $v0, 4						#syscall that writes
	syscall

	li $v0, 5						#get user input
	syscall
	
	addi $a0, $v0, 0					#save it into $a0
	addi $t0, $a0, 0					#save it into $t0
	
	la $a0, promptOutput					#print the statement
	li $v0, 4
	syscall
	#################################################################################
	
	
	addi $t1, $zero, 31
						# 31-i
	srlv $s2, $t0, $t1					#shift right (31-i)th
	sllv $s3, $t0, $t1					#shift left (31-i)
	srlv $s3, $s3, $t1
	
	
	
	
	
	#################################################################################
	
	addi $a0, $s3, 1
	#addi $v0, $a0, 0
	li $v0, 35						#print the number base 2s
	syscall