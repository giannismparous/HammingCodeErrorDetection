#IWANNHS MPAROUS

.text
.globl main

main:

	la $t0,CodeWord
	li $t1,0
	
input:	#input gia 12 arithmous

	bge $t1,12,start
	li $v0,12
	syscall
	addi $v0,$v0,-48
	sb $v0,($t0)
	addi $t0,$t0,1
	addi $t1,$t1,1
	j input

start:	#arxikh arxikopoihsh gia to loop

	li $t2,1
	la $t0,CodeWord
	
loop: #loop pou chekarei an einai kwdikas hamming

	bgt $t2,4,ok #otan $t2>4 einai kwdikas sfalmatos ara jump sto ok
	li $t3,0
	beq $t2,1,PositionsForBit1
	beq $t2,2,PositionsForBit2
	beq $t2,3,PositionsForBit4
	beq $t2,4,PositionsForBit8
	
PositionsForBit1:

	la $t1,PotitionsForDigit1
	j SumCalculation

PositionsForBit2:

	la $t1,PotitionsForDigit2
	j SumCalculation

PositionsForBit4:

	la $t1,PotitionsForDigit4
	j SumCalculation

PositionsForBit8:	

	la $t1,PotitionsForDigit8


SumCalculation: #metraei tous assous ston kataxwrhth $t3 (sum) 

	lb $t4,($t1)
	beq $t4,-1,exit_loop
	add $t4,$t4,$t0
	addi $t4,$t4,-1
	lb $t5,($t4)
	add $t3,$t3,$t5
	addi $t1,$t1,1
	j SumCalculation


exit_loop:

	rem $t3,$t3,2
	bne $t3,0,not_ok #athroisma peritto ara den einai kwdikas hamming ara jump sto not_ok
	addi $t2,$t2,1
	j loop
	
ok:

	la $a0,ok_message #ektypwsh mhnymatos sfalmatos
	li $v0,4
	syscall
	j exit

not_ok:

	la $a0,not_ok_message #ektypwsh mhnymatos epityxias
	li $v0,4
	syscall


exit:

	li $v0,10
	syscall

	.data

CodeWord:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
PotitionsForDigit1: 	.byte 1, 3, 5, 7, 9, 11, -1
PotitionsForDigit2: 	.byte 2, 3, 6, 7, 10, 11, -1
PotitionsForDigit4: 	.byte 4, 5, 6, 7, 12, -1
PotitionsForDigit8: 	.byte 8, 9, 10, 11, 12, -1
not_ok_message:		.asciiz "\n - Error in CodeWord"
ok_message:		.asciiz "\n - No error in CodeWord"
