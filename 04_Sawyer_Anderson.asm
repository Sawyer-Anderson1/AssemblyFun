#---------------------------------------------------
# Program file: 04_Sawyer_Anderson
# Written by: Sawyer Anderson
# Date created: 10/16/2024
#---------------------------------------------------

#-------------
# Data Segment
#-------------

		.data
roundPrompt:	.asciiz "Enter the number of round pizzas sold: "
squarePrompt:	.asciiz "Enter the number of square pizzas sold: "
roundPizzas:	.word 0
squarePizzas:	.word 0

dimRound:	.float 4.0
dimFeet:	.float 12.0

estimatePrompt:	.asciiz "Enter your estimate of total pizzas in square feet: "
estimate:	.float 0

round:		.word 0
square:		.float 0
total:		.float 0

PI:		.float 3.14159

#-------------
# Text Segment
#-------------

.text
# getting the inputs
li	$v0, 4
la	$a0, roundPrompt
syscall

li	$v0, 5
syscall
move	$t0, $v0
sw	$t0, roundPizzas

li	$v0, 4
la	$a0, squarePrompt
syscall

li	$v0, 5
syscall
move	$t0, $v0
sw	$t0, squarePizzas

li	$v0, 4
la	$a0, estimatePrompt
syscall

li	$v0, 6
syscall
swc1	$f0, estimate

# calculating the values
lwc1	$f8, squarePizzas
lwc1	$f9, roundPizzas
lwc1	$f4, estimate
lwc1	$f1, PI
lwc1	$f6, dimRound
lwc1	$f7, dimFeet

sw	$s0 square

div.s	$f2, $f6, $f7 # to get the fraction 4/12 = r
# pi*r^2
mul.s	$f2, $f2, $f2 # to get the r^2
mul.s	$f3, $f1, $f2 # get the square footage per round pizza

mul.s	$f3, $f3, $f9 # gets the total square footage

swc1	$f3, round 

add.s	$f5, $f3, $f8
swc1	$f5, total

# now the output

