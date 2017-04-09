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
	
	addi $t9, $zero, 0
	addi $t8, $s1, 0
	
loop2:
	
	addi $t9, $t9, 1
	srl $t8, $t8, 1
	beq $t8, $zero, loop
	j loop2
	

loop:	

	andi $t2, $s1, 1
	beq $t2, $zero, zeroTerm
	#case last bit is 1
	addi $t4, $s0, 0
	
	#addi $t9, $zero, 16
	######################this one should be upper half of multiplier 
	sllv $t5, $t4, $t9
	##################33
	addi $t4, $zero, 0
	
	addu $t4, $t5, $s1
	####
	#checking overflow
	########################
	addu $t6, $t5, $s1
	########################
	#case adding two positive and result sign is 1
	
	#sgt $t7, $s0, $t4
	#beq $t7, $zero, noOverFlow
	#j overFlow
	
	
	
	slt $t7, $t5, $zero
	beq $t7, 0, check3
	j check1

check1:
	##case one is negative
	#need to check the other number is negative or not
	#if yes, check the sign,
	#if sign is 0 then overFlow
	slt $s3, $s4, $zero
	beq $s3, $zero, noOverFlow
	j check2
	
check2:
	srl $t6, $t6, 31
	beq $t6, $zero, overFlow
	j noOverFlow

check3:
	#case one is positive
	#need to check other number is positive and sign is 1
	#it then overflow
	slt $t7, $s1, $zero
	beq $t7, 0, check4
	j noOverFlow
check4:
	srl $t6, $t6, 31
	beq $t6, 1, overFlow
	j noOverFlow
	

overFlow:
	addi $s1, $t4, 0
	
	srl $s2, $s1, 1
	ori $s1, $s2, 2147483648
	addi $s4, $s1, 0
	
	srl $t3, $t1, 1
	addi $t1, $zero, 0
	addi $t1, $t3, 0
	beq $t1, $zero, ExitReturn
	j loop
	
noOverFlow:	
	addi $s1, $t4, 0
	addi $s4, $s1, 0
	srl $s2, $s1, 1
	slt $s5, $s1, $zero
	addi $s1, $s2, 0
	srl $t3, $t1, 1
	addi $t1, $zero, 0
	addi $t1, $t3, 0
	beq $t1, $zero, ExitReturn
	j loop
	
	
zeroTerm:
	 slt $s5, $s1, $zero
	 srl $s2, $s1, 1
	 addi $s1, $zero, 0
	 addi $s1, $s2, 0
	 
	 srl $t3, $t1, 1
	 addi $t1, $zero, 0
	 addi $t1, $t3, 0
	 j loop
	
ExitReturn:
	addi $s4, $s1, 0
	addi $v0, $s4, 0
	jr $ra
	 

exit:
	la $a0, promptOutput					#print the total
	li $v0, 4						#syscall that print
	syscall
	
	addi $v0, $s7, 0					#save it into $v0
	addi $a0, $v0, 0					#save it into $a0
	li $v0, 36						#print the sum
	syscall














