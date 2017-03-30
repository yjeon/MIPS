.data
promptInput:	.asciiz "Number to check? "
promptOutput1: 	.asciiz "\nBinary pattern 1: "
promptOutput2: 	.asciiz "\nBinary pattern 2: "
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
	
	la $a0, promptOutput1					#print the statement
	li $v0, 4
	syscall
	#################################################################################
	
	addi $t1, $zero, 9
	#sub $t1, $t4, 10
						# 31-i
	#srlv $s2, $t0, $t1					#shift right (31-i)th
	addi $t5, $zero, 31
	#sllv $s3, $a0, $t1					#shift left (31-i)
	sllv $s2, $t0, $t1
	addi $s3, $s2, 0
	srlv $s2, $s3, $t5
	
	#addi $t5, $zero, 24
	addi $t2, $a0, 0
	
	sllv $s3, $t2, $t1
	srlv $s3, $s3, $t1

	
	#################################################################################
	
	addi $a0, $s2, 0
	addi $v0, $a0, 0
	li $v0, 35			#print the number base 2s
	syscall
	
	
	la $a0, promptOutput2					#print the statement
	li $v0, 4
	syscall
	
	addi $a0, $s3, 0
	li $v0, 35
	syscall
