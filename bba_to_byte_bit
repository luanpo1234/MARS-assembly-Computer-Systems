########################################################################################
#    Calculates bit position and byte address from Bit-Banding-Alias 
#    using the following formula:
#    BIT POS = (BBA & 0x1C)>>2
#    BYTE ADDR = ((BBA & 0x1FFFFE0)>>5)|S,
#    where S is the initial address of the interval.
########################################################################################

.data	
	bba: .word  0x421E411C
	mask1: .word 0x1C
	mask2: .word 0x1FFFFE0	
	mask3: .word 0xF0000000
	message1: .asciiz " Calculated bit: "
	message2: .asciiz " \n Calculated byte address: "

.text 	
	# Loads data in the registers.
	lw $t1, bba		#Loads BBA address
	lw $t2, mask1
	lw $t3, mask2
	lw $t4, mask3

	# Applies the formula described above.
	and $t4, $t4, $t1 	#Stores S	
	and $t6, $t1, $t2	#(BBA & 0x1C)
	srl $t6, $t6, 2		#>> 2, bit position stored in $t6
	and $t5, $t1, $t3	#(BBA & 0x1FFFFE0)
	srl $t5, $t5, 5		#>>5
	or $t7, $t5, $t4	#>> 2, byte address stored in $t7

	# Printing message1
	la $a0, message1	
	li $v0, 4
	syscall	

	# Printing calculated bit
	move $a0, $t6	
	li $v0, 34	
	syscall
	
	# Printing message2
	la $a0, message2	
	li $v0, 4
	syscall	

	# Printing calculated byte address
	move $a0, $t7
	li $v0, 34	
	syscall
