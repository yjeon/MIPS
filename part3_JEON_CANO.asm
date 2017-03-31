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
resultYes:	.asciiz "\nIt is a binary palindrome."
resultNo:	.asciiz	"\nIt is not a binary palindrome."
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
	
	
	addi $t1, $v0, 0
	beq $t1, 1, exit
	
	#test for checking return value
	#currently return 0 from binary_palindrome
	#addi $a0, $v0, 0
	j exit
	
	
.globl binary_palindrome					#declare the subroutine to be global
binary_palindrome:						#it has two arguments $a0, $a1
	addi $s0, $a0, 0
	addi $t9, $a0, 0
	addi $s1, $a1, 0
	addi $s2, $a0, 0
	beq $a1, 16, true_bp
	
	addi $t0, $s1, 0
	addi $t1, $zero, 31
	addi $s3, $zero,0
	
	sllv $s3, $s0, $t0
	addi $s4, $s3, 0
	srlv $s3, $s4, $t1
	
	sub $t2, $t1, $s1
	addi $s5, $zero,0
	
	sllv $s5, $s2, $t2
	addi $s6, $s5, 0
	srlv $s5, $s6, $t1
	
	#$s5 and $s3
	bne $s3, $s5, false_bp
	addi $a0, $t9, 0
	addi $a1, $a1, 1
	jal binary_palindrome
	

true_bp:
	
	la $a0, resultYes
	li $v0, 4
	j exit
	
	
false_bp:
	
	la $a0, resultNo
	li $v0, 4
	j exit
	
	
exit:
	syscall

