#################################################
# CS 465 Homework #3 part2
# Author: Jose Cano, Yoonchan Jeon
# ID: jcano, yjeon
#
# Algorithm:
#	a0 <- get integer input for Multiplicand;
#	a1 <- get integer input for Multiplier;
#	call opt_multiply(a0, a1);
#		loop for 
#			t9 <- count the number of a1 bits;
#		t9--;
#		loop for until multiplier == 0
#			checking the lsb for Multiplier
#			if the lsb == 0
#				then no add, and product shift right 1
#			else:
#				product shift right1
#				shift left t9 multiplicand 
#				add to product
#			multiplier shift 1
#		return product
#	print the return value		
#################################################
.data
promptInput1:	.asciiz "Multiplicand? "
promptInput2: 	.asciiz "Multiplier? "
promptOutput: 	.asciiz "Product: "

.text
main:
	la $a0, promptInput1					#ask user input Multiplicand
	li $v0, 4						#syscall that writes
	syscall

	li $v0, 5						#get user input
	syscall	
	addi $t0, $v0, 0					#save it into $t0
	
	la $a0, promptInput2					#ask user input Multiplier
	li $v0, 4
	syscall
	
	li $v0, 5						#get user input
	syscall
	
	addi $s1, $v0, 0					#save it into $s1
	addi $a0, $t0, 0					#move $t0 to $a0
	addi $a1, $s1, 0					#move $s1 to $a1
	jal opt_multiply					#call the function opt_multiply(a0,a1)
	addi $s7, $v0, 0					#get the return value
	j exit							#change the branch to print

.globl opt_multiply						#declare the subroutine to be global
opt_multiply:
	addi $s0, $a0, 0					# multiplicand
	addi $s1, $a1, 0					# it will be the product
	addi $t1, $a1, 0 					# checking original multiplier
	
	addi $t8, $s1, 0					#set up for counting bits for multiplier
	addi $t9, $zero, 0
loop2:
	addi $t9, $t9, 1					#increase the count
	srl $t8, $t8, 1						#shift left 1
	beq $t8, $zero, temp					#if it become zero goto temp
	j loop2							#loop go to loop2
	
temp:			
	subi $t9, $t9, 1					#set up for shifting value

loop:	
	andi $t2, $s1, 1					#checking lsb
	beq $t2, $zero, zeroTerm				#if it is 0 goto zeroTerm
	addi $t4, $s0, 0					#case lsb ==1
								#need to shift product right and
								#shift multiplicand left $t9
								#and add
								
	srl $s2, $s1, 1						#shift product right
	sllv $t5, $t4, $t9					#shfit multiplicand left $t9
	addi $t4, $zero, 0			
	addu $t4, $t5, $s2					#add that to product
	
	addi $s1, $t4, 0					#move it to $s1
	
	srl $t3, $t1, 1						#checking end value 
	addi $t1, $zero, 0
	addi $t1, $t3, 0
	beq $t1, $zero, ExitReturn				#if it is not zero goto loop
								#it it is goto ExitReturn
	j loop
	
	
zeroTerm:							#zeroTerm
								#no add, shift product right
								#goto loop
	 slt $s5, $s1, $zero
	 srl $s2, $s1, 1
	 addi $s1, $zero, 0
	 addi $s1, $s2, 0
	 
	 srl $t3, $t1, 1
	 addi $t1, $zero, 0
	 addi $t1, $t3, 0
	 j loop
	
ExitReturn:							#return 
	addi $s4, $s1, 0					
	addi $v0, $s4, 0					#move $s4 to $v0
	jr $ra							#return 
	 

exit:
	la $a0, promptOutput					#print the total
	li $v0, 4						#syscall that print
	syscall
	
	addi $v0, $s7, 0					#save it into $v0
	addi $a0, $v0, 0					#save it into $a0
	li $v0, 36						#print the sum
	syscall














