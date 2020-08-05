########################################################################################
#   Calculates Bit-Banding-Alias using the following formula:
#   A = S + OFFSET + (ADDR - S) <<5 + BIT <<2
#   Where S is the initial address of the interval, ADDR the existing byte address,
#   BIT the existing bit, OFFSET the 0x02000000 offset.
########################################################################################

.data	
	address: .word  0x400FFCDF
	bit: .word 0x4
	mask1: .word 0xF0000000
	mask2: .word 0x0000FFFF	
	offset: .word 0x02000000
	
	message1: .asciiz " Calculated BBA: "

.text 	
	# Loads data in the registers.
	lw $t1, address		#Loads ADDR
	lw $t2, bit		#Loads BIT
	lw $t3, mask1
	lw $t4, mask2
	lw $t5, offset		#Loads OFFSET
	
	# Applies the formula described above.
	and $t3, $t3, $t1 	#Stores S
	add $t4,$t3, $t5	#Adds OFFSET
	sub $t6, $t1, $t3	#Subtracts S from ADDR
	sll $t6, $t6, 5		#(ADDR-S) << 5
	sll $t2, $t2, 2		#BIT << 2
	add $t7, $t6, $t4	# Final sum of results
	add $t7, $t7, $t2	# Final sum of results
	
	# Printing message1
	la $a0, message1	
	li $v0, 4
	syscall	

	# Printing BBA address
	move $a0, $t7	
	li $v0, 34	
	syscall
