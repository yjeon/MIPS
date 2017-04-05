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
	addi $s1, $v0, 0
	
	addi $a0, $t0, 0
	addi $a1, $s1, 0
	jal opt_multiply
	addi $s7, $v0, 0
	j exit

.globl opt_multiply					#declare the subroutine to be global
opt_multiply:
	addi $s0, $a0, 0				# multiplicand
	addi $s1, $a1, 0				# it will be the product
	addi $t1, $a1, 0 				# checking original multiplier
	
	addi $t9, $zero, 1
	addi $t8, $s1, 0
	
loop2:
	addi $t9, $t9, 1
	srl $t8, $t8, 1
	bne $t8, $zero, loop2
	
loop:	
	beq $t1, $zero, ExitReturn
	andi $t2, $s1, 1
	beq $t2, $zero, zeroTerm
	#case last bit is 1
	addi $t4, $s0, 0
	

	######################this one should be upper half of multiplier 
	sllv $t5, $t4, $t9
	##################33
	addi $t4, $zero, 0
	
	add $t4, $t5, $s1
	addi $s1, $t4, 0
	
	srl $s2, $s1, 1
	addi $s1, $zero, 0
	addi $s1, $s2, 0
	#####################
	#need to check overflow
	#if there was overflow before shifting then add 2147483648
	#addi $s1, $s2, 2147483648
	srl $t3, $t1, 1
	addi $t1, $zero, 0
	addi $t1, $t3, 0
	j loop
	
zeroTerm:
	 srl $s2, $s1, 1
	 addi $s1, $zero, 0
	 addi $s1, $s2, 0
	 srl $t3, $t1, 1
	 addi $t1, $zero, 0
	 addi $t1, $t3, 0
	 j loop
	
ExitReturn:
	addi $s4, $zero, 0
	srl $s4, $s2, 1
	addi $v0, $s4, 0
	jr $ra
	 

exit:
	la $a0, promptOutput					#print the total
	li $v0, 4						#syscall that print
	syscall
	
	addi $v0, $s7, 0					#save it into $v0
	addi $a0, $v0, 0					#save it into $a0
	li $v0, 1						#print the sum
	syscall














