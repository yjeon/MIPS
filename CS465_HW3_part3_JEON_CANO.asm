#################################################
# CS 465 Homework #3 part3
# Author: Jose Cano, Yoonchan Jeon
# ID: jcano, yjeon
#
# Algorithm:
#	main:
#		a0 <- get user input
#		print a0 as binary numver
#		call binary_palindrome(a0,0) as recursive
#		binary_palindrome (a,i):
#			a is the first argument
#			if(i>=16) goto true_bp
#			else:
#				t1 <- shift left a to i
#				and shift right it to 31
#				t2 <-shift left a to 31-i
#				and shift right it to 31
#				and compare (t1,t2)
#				if it is true
#					return binary_palindrome(a,i+1)
#				else
#					False
#		if return value is true
#			print "It is a binary palindrome."
#		else
#			print "It is not a binary palindrome."		
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
	addi $t1, $zero, 31					#set the value for shifting
	addi $s3, $zero,0
	
	sllv $s3, $s0, $t0					#shift left a0 to $t0 bits
	addi $s4, $s3, 0
	srlv $s3, $s4, $t1					#shift right a0 to 31 bits
	
	sub $t2, $t1, $s1					#31-i
	addi $s5, $zero,0
	
	sllv $s5, $s2, $t2					#shift left a0 to 31-i bits
	addi $s6, $s5, 0
	srlv $s5, $s6, $t1					#shift right 10 to 31 bits
	
	#$s5 and $s3
	bne $s3, $s5, false_bp					#compare it
	addi $a0, $t9, 0					#it it is not the same, goto false_bp
	addi $a1, $a1, 1
	jal binary_palindrome					#if it is the same, return binary_palindrome
								#recursive
	

true_bp:							#case true state
	
	la $a0, resultYes
	li $v0, 4
	j exit
	
	
false_bp:							#case false state
	
	la $a0, resultNo
	li $v0, 4
	j exit
	
	
exit:
	syscall							#print the result

