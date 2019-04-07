.file "solar.S"
      .data
      .comm lightVal1, 1
      .global lightVal1
      .comm lightVal2, 1
      .global lightVal2

      .text
      .extern delay
      .global operatePanel
      .global initializePanel
      .global resetPanel
      .global parkPanel
      .global queryPanel
      .global readAD

      ; portB setup
      .set PORTB,0x05
      .set DDIRB,0x04
      .set MOTDATA,0
      .set MOTLATCH,4
      .set M1ENABLE,3
      .set BOARDLED, 5
      
      ; portD setup
      .set PORTD,0x0B
      .set DDIRD,0x0A
      .set MOTCLOCK,4
      .set M2ENABLE,3
      .set M4ENABLE,6
      .set M3ENABLE,5

      .set PINB, 0x03
      .set SWITCH2,2

      .set DIDR0, 0x007E
      .set ADCL, 0x0078
      .set ADCSRA, 0x007A
      .set ADCH, 0x0079
      .set ADCSRB, 0x007B
      .set ADMUX, 0x007C

initializePanel:
      clr   r25
      ldi   r24, 1
      ret

operatePanel:
      lightTracking:

      LDI R18, 0b00111111
      STS DIDR0, R18

      LDI R18, 0b10000111
      STS ADCSRA, R18

L3:

      LDI R20, 0b01100000
      LDI R23, 3
      ADD R20, R23
      STS ADMUX, R20
     
      LDI R21, 0b11000111
      STS ADCSRA, R21

L4:   
      LDS R21, ADCSRA
      SBRC R21, 6
      RJMP L4
     
      LDS R24, ADCH
      MOV R19, R24
      CLR R25

      //END OF READING WEST IN R19

      LDI R20, 0b01100000
      LDI R23, 1
      ADD R20, R23
      STS ADMUX, R20
     
      LDI R21, 0b11000111
      STS ADCSRA, R21

L5:   
      LDS R21, ADCSRA
      SBRC R21, 6
      RJMP L5
     
      LDS R24, ADCH
      MOV R26, R24
      CLR R25

      //END OF READING EAST IN R26

      STS lightVal1, R19
      
      

      
L9:
      CP R19, R26
      BREQ dontTurn

      CP R19, R26
      BRSH turnWest

      CP R19, R26
      BRLO turnEast

dontTurn:

      LDI R24, 0x00
      CALL sendMotorByte 
      CALL Delay
      RJMP L3

turnWest:

      SUB R19, R26
      CPI R19, 4
      BRLO dontTurn
      
      //LDI R20, 0xFF
      //OUT DDIRB, R20
      //OUT DDIRD, R20
      
      CBI DDIRB, 1
      SBI PORTB, 1
      CALL delay1
      
L6:
      SBIC PINB, 1
      RJMP notPressed3
      //when west switch iS pressed
      
      LDI R24, 0x00
      CALL sendMotorByte
      CPI R19, 4
      BRLO LONE2
      CALL Delay
      //RJMP LONE2
      RJMP L3
      
      
notPressed3:
      //when switch is not pressed

      LDI R24, 0b11011000
      CALL sendMotorByte
      CALL delay1
      LDI R24, 0x00
      CALL sendMotorByte

      ret
      
turnEast:

      SUB R26, R19
      CPI R26, 4
      BRLO dontTurn

      //LDI R20, 0xFF
     // OUT DDIRB, R20
      //OUT DDIRD, R20
      
     CBI DDIRB, 2
     SBI PORTB, 2
     CALL delay1
     
L7:
      SBIC PINB, 2
      RJMP notPressed4
      //when east switch iS pressed
      
      LDI R24, 0x00
      CALL sendMotorByte
      ret
      
      
notPressed4:
      //when switch is not pressed

      LDI R24, 0b00100111
      CALL sendMotorByte
      CALL delay1
      LDI R24, 0x00
      CALL sendMotorByte

      ret

      

LONE2:
      SBIC PINB, 2
      RJMP notPressed5
      //when east switch iS pressed
      
      LDI R24, 0x00
      CALL sendMotorByte
      ret
      
notPressed5:
      //when switch is not pressed

      LDI R24, 0b00100111
      CALL sendMotorByte
      CALL delay1
      LDI R24, 0x00
      CALL sendMotorByte

      RJMP LONE2
      

//this causes the onboard LED to blink 3 times then 
//returns the panel to the east position 
//then immediately start tracking the sun
//if it reaches west stay until light is below threshold
//then go east and wait for light to rise
resetPanel:

      //blink LED 3 times
      LDI R18, 0x20
      OUT 0x05, R18
      CALL Delay

      LDI R18, 0x00
      OUT 0x05, R18
      CALL Delay

      LDI R18, 0x20
      OUT 0x05, R18
      CALL Delay

      LDI R18, 0x00
      OUT 0x05, R18
      CALL Delay

      LDI R18, 0x20
      OUT 0x05, R18
      CALL Delay

      LDI R18, 0x00
      OUT 0x05, R18
      CALL Delay

      LDI R20, 0xFF
      OUT DDIRB, R20
      OUT DDIRD, R20

      CBI DDIRB, 2
      SBI PORTB, 2
      CALL delay1
      
L1:
      SBIC PINB, 2
      RJMP notPressed
      //when east switch iS pressed
      
      LDI R24, 0x00
      CALL sendMotorByte
      
      CALL Delay
      ret
notPressed:
      //when switch is not pressed

      LDI R24, 0b00100111
      CALL sendMotorByte

      RJMP L1



//this causes the panel to return to the east and stay there
parkPanel:

      LDI R20, 0xFF
      OUT DDIRB, R20
      OUT DDIRD, R20

      CBI DDIRB, 2
      SBI PORTB, 2
      CALL delay1
      
L2:
      SBIC PINB, 2
      RJMP notPressed2
      //when east switch iS pressed
      
      LDI R24, 0x00
      CALL sendMotorByte
      LDI R20, 0x00
      OUT DDIRB, R20
      OUT DDIRD, R20
      
      CBI DDIRB, 0
      SBI PORTB, 0
      CALL delay1
      CALL Delay
      ret
      RJMP L2
notPressed2:
      //when switch is not pressed

      LDI R24, 0b00100111
      CALL sendMotorByte

      RJMP L2
      

//requests information on how much light has been hitting the panel recently
queryPanel:
     
     
     ret 
readAD:
     LDI R20, 0b01100000
     ADD R20, R24
     STS ADMUX, R20
     
     LDI R21, 0b11000111
     STS ADCSRA, R21

L10:  LDS R21, ADCSRA
     SBRC R21, 6
     RJMP L10
     
     LDS R24, ADCH
     
     CLR R25
     ret
      
      
sendOneBit:
      sbi PORTB,MOTDATA
      call delay1
      sbi PORTD,MOTCLOCK
      call delay1
      cbi PORTD,MOTCLOCK
      call delay1
      cbi PORTB,MOTDATA
      call delay1
      ret

sendZeroBit:
      cbi PORTB,MOTDATA
      call delay1
      sbi PORTD,MOTCLOCK
      call delay1
      cbi PORTD,MOTCLOCK
      call delay1
      ret
      
#
# latch now should be enabled (one) in order to release 
# the control pattern to the motor driver chips 
#
latchData:
      sbi   PORTB,MOTLATCH
      call  delay1
      ; make sure PWM outputs are on
      sbi   PORTB, M1ENABLE
      sbi   PORTD, M2ENABLE
      sbi   PORTD, M3ENABLE
      sbi   PORTD, M4ENABLE
      ret

# latch should be zero in order to send the control 
# pattern to shift register    
latchReset: 
      cbi   PORTB,MOTLATCH
      call  delay1
      ret

sendMotorByte:
      push  r15
      push  r16
      mov   r15, r24
      call  latchReset
      ldi   r16, 8
smbloop:
      lsl   r15
      brcs  smbone
      call  sendZeroBit   
      rjmp  smbdone
smbone:
      call  sendOneBit
smbdone:
      dec   r16
      brne  smbloop
      call  latchData
      call  latchReset
      pop   r16
      pop   r15
      ret
      
delay1:
      push r18
      push r19
      push r20
      push r21
      push r22
      push r23
      push r24
      push r25
      ldi   r22, 0x01
      ldi   r23, 0x00
      ldi   r24, 0
      ldi   r25, 0
      call  delay
      pop r25
      pop r24
      pop r23
      pop r22
      pop r21
      pop r20
      pop r19
      pop r18
      ret
      
Delay:
   push r18
   push r19
   push r20
   push r21
   push r22
   push r23
   push r24
   push r25
   ldi  r22, 0xff
   ldi  r23, 0x00
   ldi  r24, 0x00     
   ldi  r25, 0x00 
   call delay
   pop r25
   pop r24
   pop r23
   pop r22
   pop r21
   pop r20
   pop r19
   pop r18
   ret 
