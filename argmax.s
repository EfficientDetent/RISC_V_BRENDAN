# Author: EfficientDetent
#define c_exit32 32
.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#    element. If there are multiple, return the one
#    with the smallest index.
# Arguments:
#     a0 (int*) is the pointer to the start of the vector
#    a1 (int)  is the # of elements in the vector
# Returns:
#    a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 32
# =================================================================


argmax:

    #Prologue

    #branches to exit statement if passed in an empty vector
    beq a1, x0, exit32
	
	
#############################################################################################################################################
# Main Logic Starts

	add $t0, $zero, $zero			# currPosition = 0
	lw $t1, 0(a0)					# currMax = arr[0]
	add $t2, $zero, $zero			# currMaxPosition = 0

loop_start:
	bge $t0, $a1, loop_end			# if currPosition>=n then end the loop
	
	# $t4 should contain arr[currPosition]
	mul $t4, $t0, 4					# t4 = 4*currPosition
	add $t4, $t4, $a0				# $t4 = arr + 4*currMaxPosition	
	lw $t4, 0($t4)					# $t4 = arr[currPosition]
	
	ble $t4, $t1, loop_continue		# if arr[currPosition] <= currMax then continue the loop
	
	add $t2, $t4, $zero				# else currMaxPosition = currPosition
	add $t1, $t4, $zero				# currMax = arr[currPosition]
	
loop_continue:
	addi $t0, $t0, 1				# currPosition = currPosition+1
	j loop_start
	
loop_end:
	mv $a0, $t0

# main logic ends
#############################################################################################################################################


    #Epilogue
    ret

exit32:
    addi a1, x0, 32
    jal exit2

