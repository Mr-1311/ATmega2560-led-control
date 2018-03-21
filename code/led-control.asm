;this code written for atmega 2560
;buttons on portB
;portB's bit 0 for control speed
;portB's bit 1 for control direction
;portB's bit 2 for control number of leds
;leds on portC
					
.org 0				
	rjmp mymain				
	

mymain:
	ldi r20,0x00	
	ldi r21,0x00	
	ldi r19,0x03		
	ldi r22,0x0C	
	ldi r23,0x03	
	ldi r24,0x00	
	sts $40,r19		
	ldi r16,0x00	
	out DDRB,r16	
	sbi PORTB,0		
	sbi PORTB,1		
	sbi PORTB,2		
	ldi r16,0xFF 	
	out DDRC,r16	
    ldi r16,0x01

mainloop:
	
	out PORTC,r16	
	cpi r24,0x00
	brne reverse	
	rol r16			
	brcc delay		
	rol r16			

delay:
	lds r19,$40		
delay0:
	ldi r17,0xFF	
delay1:			
	ldi r18,0xFF	
delay2:

	sbis PINB,0		
	rjmp buttonS	
	ldi r21,0x00	
buttonSPost:
	sbis PINB,1		
	rjmp buttonD	
	ldi r20,0x00
buttonDPost:
	sbis PINB,2		
	rjmp buttonN	
	ldi r20,0x00
buttonNPost:
	dec r18
	brne delay2
	dec r17
	brne delay1
	dec r19
	brne delay0
	rjmp mainloop 	
	
buttonS:
	cpse r20,r21	
	rjmp buttonSPost	
	ldi r21,0x01	
	lds r19,$40		
	add r19,r23		
	sts $40,r19		
	cpse r19,r22	
	rjmp buttonSPost
	ldi r19,0x03	
	sts $40,r19		
	rjmp buttonSPost	

buttonD:
	cpi r20,0x00	
	brne buttonDPost	
	ldi r20,0x01	
	ldi r25,0x01
	eor r24,r25		
	rjmp buttonDPost

reverse:
	ror r16			
	brcc delay
	ror r16			
	rjmp delay	

buttonN:
	cpi r20,0x00		
	brne buttonNPost
	ldi r20,0x01
	mov r26,r16
	lsl r16
	add r16,r26
	rjmp buttonNPost


