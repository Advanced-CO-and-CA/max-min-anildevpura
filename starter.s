

/******************************************************************************
* file: starter.s
* author: Anil Kumar Devpura
* Guide: Prof. Madhumutyam IITM, PACE and G S Nitesh Narayana
******************************************************************************/


  @ BSS section
      .bss

  @ DATA SECTION
      .data
data_items: .word 10, 4, 28, 100, 8, 0 @0 is used to terminate the data

  @ TEXT section
      .text

.globl _main

_main:
/*
Algo for assignment 2
	Step 1: Initilization
		a. Load The data given to register R0
		b. Initilized register R1 (used to get total number of integers present in the given set) to 0
		c. Initilized Min (R2) and Max (R3) counter to first value of given set. i.e. when only 2 value present then min=max=first value
	Step 2: Start a loop to read all elements of the given set
		a. Load the value to register R4
		b. Verify if element is non zero:
			b.1. For None Zero , Call INC {This is responsible for counter, address, min and max update}
				b.1.1: update counter and memory location of next word in the given set
				b.1.2: Compare the current element to current min, update the current min if required. Step b.1.3, will be skiped if this condition is true and control will Step 2.a for next element processing
				b.1.3: Compare the current element to current Max, update the current max if required.if this condition is true and control will Step 2.a for next element processing
				b.1.4: Control will go to Step 2.a for next element processing
				
			b.2. if Zero, then programe terminates

Output:
	Register R1: total number of integers present
	Register R2: Minimum value in the given set
	Register R3: Maximum value in the given set
*/

	ldr r0, add_data_items
	ldr r1, =0x0 @Counter
	ldr r2, [r0] @Minimum value Holder, init with 1st value
	ldr r3, [r0] @Max Vlaue holder, init with 1st value
	Loop:
		ldr r4, [r0]	
		cmp r4, #0 @terminating condition
		bne INC
		b end @End of programe

INC:
	add r1, #1
	add r0, #4	
	cmp r4,r2
	ble Less	
	cmp r4,r3	
	bgt More	
	b Loop
	
Less:
	mov r2, r4 @updating new min Value
	b Loop
		
More:
	mov r3, r4 @updating new Max Value
	b Loop
		
end:
	bx lr
	
add_data_items: .word data_items
