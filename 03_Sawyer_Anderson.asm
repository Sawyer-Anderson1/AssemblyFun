#----------------------------------------
# Program File: 03_Sawyer_Anderson.asm
# Written by: Sawyer Anderson
# Date Created: 9/25/2024
# ---------------------------------------

#-------------
# Data segment
#-------------
		.data
string:		.asciiz "Enter an integer from 0 to 100:"
errorString:	.asciiz "The number was invalid (not 0-100)"
integer:	.word 0
array:		.space 404 # allocates array space for the maximum input and array that the program allows
index:		.word 0
sum:		.word 0

#-------------
# Text segment
#-------------

# I only use the native instruction set for my loops.

.text
main: 
	li 	$v0, 4
	la 	$a0, string # prompting the input
	syscall

	li 	$v0, 5
	syscall
	move 	$t0, $v0 # getting the input

	#check if the integer is valid	
	beq	$t0, $zero, exit # if the integer is zero exit

	slt	$t1, $zero, $t0 # if the integer is less than zero
	beq	$t1, $zero, error # then return error message  

	slti	$t1, $t0, 101 # if the integer is less than 101 then it will return 1,
	# else if it is greater than or equal to 101 it will return 0.
	beq	$t1, $zero, error

	#else store the inputed integer and use it for the rest of the problem
	sw	$t0, integer# storing the inputed integer

	lw	$t0, integer # loading in the integer
	la	$t1, array # loading the array
	lw	$t2, index # loading the current index
	
_arrayLoop:

	addi	$t3, $t0, 1 #to make it be a while(index <= N) (i.e. N + 1)
	# the index starts at 0 so it will loop N + 1 for the array that is N + 1 long
	# the index will be also used for the values, since 0*2, 1*2, 2*2, 3*2,.., N*2 are the values for this array

	beq	$t2, $t3, _sumLoop
	
	add	$t4, $t2, $t2 # to get the values
	add	$t5, $t4, $t4 # to get the actual index position
	addu	$t5, $t1, $t5 # go to the position in the array
	
	sw	$t4, 0($t5)
	
	addi	$t2, $t2, 1 #increment the index

	j	_arrayLoop # loop

_sumLoop: 

error: 

	li	$v0, 4
	la	$a0, errorString
	syscall

	j	exit

exit: 

	li	$v0, 10 # exits the program 
	syscall 


