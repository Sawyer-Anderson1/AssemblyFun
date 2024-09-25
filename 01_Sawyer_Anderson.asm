#----------------------------------------------------------------------------------------------
#Program File: 01_Sawyer_Anderson
#Written by: Sawyer Anderson
#Date Created: August 29, 2024
# Description: Homework 1 of Computer Architecture CS 2340
#----------------------------------------------------------------------------------------------

#----------------------------------
#Declaring constants
#----------------------------------

		.data
string: 	.asciiz 	"Enter X and Y: "
X:		.word	0
Y:		.word	0
S:		.word	0
result:	.asciiz	"The sum of X and Y (X + Y) is "

#-------------------------------
#Main program body
#-------------------------------

.text
main: 

li	$v0, 4 #get the "magic number" for write system call
la	$a0, string #get address of the string1 asciiz srting
syscall #system call

li	$v0, 5 #get the "magic number" for read system call
syscall
move $t0, $v0
sw	$t0, X

li	$v0, 5
syscall
move $t1, $v0
sw	$t1, Y

lw	$s2, X
lw	$s3, Y
add	$s4, $s2, $s3
sw	$s4, S

li	$v0, 4
la	$a0, result
syscall

lw	$a0, S
li	$v0, 1
la	$a0, 0($a0)
syscall

li $v0, 10
syscall
