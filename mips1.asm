#################################################
# CS 465 Homework #3
# Author: Jose Cano, Yoonchan Jeon
# ID: jcano, yjeon
#
# Algorithm:
#
#################################################



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
	
	
	addi $a0, $t0, 0
	li $v0, 35						#print the number base 2s
	syscall
								#First argument is the input number and saved at $a0
	addi $a1, $zero, 0					#Second argument is zero and saved at $a1
	jal binary_palindrome
	beq $v0, 1, exit_true
	
	#test for checking return value
	#currently return 0 from binary_palindrome
	addi $a0, $v0, 0
	
	
	j exit
	
	
.globl binary_palindrome					#declare the subroutine to be global
binary_palindrome:						#it has two arguments $a0, $a1
	
	bgt $a1, 16, true_bp
	addi $s0, $a0, 0					#save $a0 to $s0
	addi $s1, $a1, 0					#save $a1 to $s1
	
	 
	######################################################################################### 
	sub $s4, $31, $s1					# 31-i
	srlv $s2, $s0, $s4					#shift right (31-i)th
	sllv $s3, $s0, $s4					#shift left (31-i)
	srlv $s3, $s3, $s4					#shift right back (31-i)
	# i think this part is wrong
	# need to find another way
	#
	#########################################################################################
	
	#addi $a0, $s3, 0
	
	bne $s2, $s3, false_bp					# i-th digit != (31-1)th digit, go to exit_bp
	addi $a1, $a1, 1					#need to increase i
	
	jal binary_palindrome

true_bp:
	addi $v0, $zero, 1
	jr $ra
false_bp:
	addi $v0, $zero, 0
	jr $ra
	
	
exit_true:
	j last
exit:
	addi $t0, $v0, 0
	addi $t1, $a0, 0					#save return value
	
	la $a0, promptTest					#ask user input
	li $v0, 4						#syscall that writes
	syscall
	
	addi $v0, $t0, 0
	addi $a0, $t1, 0
	
	li $v0, 1
	syscall

last:
	