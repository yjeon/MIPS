#################################################
# CS 465 Homework #3 part2
# Author: Jose Cano, Yoonchan Jeon
# ID: jcano, yjeon
#
# Algorithm:
#
#################################################
.data
promptInput1:	.asciiz "Multiplicand? "
promptInput2: 	.asciiz "Multiplier? "
promptOutput: 	.asciiz "Product: "


.text
main:
	la $a0, promptInput1					#ask user input
	li $v0, 4						#syscall that writes
	syscall

	li $v0, 5						#get user input
	syscall	
	addi $t0, $v0, 0					#save it into $t0
	
	la $a0, promptInput2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	addi $t1, $v0, 0
	
	addi $a0, $t0, 0
	addi $a1, $t1, 0
	jal opt_multiply
	
	j exit

.globl opt_multiply					#declare the subroutine to be global
opt_multiply:

	









exit:














