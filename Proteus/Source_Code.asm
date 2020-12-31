#include <p16f877A.inc>
	    
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	    
flag	    equ		    23
pasos	    equ		    24	    
	    
	    org		    0x00

	    GOTO	    conf
	    
;==============================[Interrupción]===================================	    

	    org		    0x04

	    BCF		    INTCON, 1
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    MOVLW	    0X01
	    CALL	    comando
	    
	    CALL	    paro
	    
espera_int
	    
	    BTFSS	    PORTB, 3
	    GOTO	    espera_int
	    
	    MOVLW	    0X01
	    CALL	    comando
	    
	    CALL	    programa
	    
	    BANKSEL	    CCPR1L  
	    MOVLW	    b'00000001'
	    MOVWF	    CCPR1L
	    
	    ;CALL	    retardo
	    
	    BANKSEL	    CCP1CON    			
	    MOVLW	    b'00001100'
	    MOVWF	    CCP1CON
	    
	    RETFIE
	    
;=============================[Configuración]===================================	    

conf
	    
	    BSF		    STATUS, 5
	
	    BANKSEL	    PORTA
	    CLRF	    PORTA

	    BANKSEL	    TRISA
	    MOVLW	    b'00011111'
	    MOVWF	    TRISA

	    BANKSEL	    PORTB
	    CLRF	    PORTB
	    
	    BANKSEL	    TRISB
	    MOVLW	    b'10001111'
	    MOVWF	    TRISB
	    
	    BANKSEL	    PORTC
	    CLRF	    PORTC

	    BANKSEL	    TRISC
	    MOVLW	    b'10000000'
	    MOVWF	    TRISC
	    
	    BANKSEL	    PORTD
	    CLRF	    PORTD

	    BANKSEL	    TRISD
	    MOVLW	    b'00000000'
	    MOVWF	    TRISD
	    
	    BANKSEL	    PORTE
	    CLRF	    PORTE

	    BANKSEL	    TRISE
	    MOVLW	    b'00000000'
	    MOVWF	    TRISE
	    
	    BANKSEL	    ADCON1
	    MOVLW	    b'00000110'
	    MOVWF	    ADCON1
	    
	    BANKSEL	    PR2
	    MOVLW	    .255
	    MOVWF	    PR2
	    
	    BANKSEL	    T2CON
	    MOVLW	    b'00000110'
	    MOVWF	    T2CON
	    
	    BANKSEL	    OPTION_REG
	    MOVLW	    b'00100000' 
	    MOVWF	    OPTION_REG

	    BANKSEL	    INTCON
	    MOVLW	    b'10010000'
	    MOVWF	    INTCON
	    
	    BANKSEL	    SPBRG
	    MOVLW	    .1
	    MOVWF	    SPBRG
	    
	    BANKSEL	    TXSTA
	    MOVLW	    b'00100100'
	    MOVWF	    TXSTA
	    
	    BANKSEL	    RCSTA
	    MOVLW	    b'10010000'
	    MOVWF	    RCSTA

	    BCF		    STATUS, 5
	    
lcd_on	    
	    
	    CALL	    retardo
	    CALL	    retardo
	    
	    MOVLW	    0X38	    ; # Líneas
	    CALL	    comando
	    MOVLW	    0X01	    ; Limpia Display
	    CALL	    comando
	    MOVLW	    0X0C	    ; Display on, cursor off
	    CALL	    comando
	    
sel_modo
	    
	    BTFSS	    PORTB, 7
	    GOTO	    secuencia
	    GOTO	    manual
	    
;==========================[Secuencia Programada]===============================	    
	    
secuencia
	    
	    BANKSEL	    INTCON
	    BSF		    INTCON, 7
	    
	    BTFSS	    INTCON, 0
	    GOTO	    continua_secuencia
	    BCF		    INTCON, 0
	    	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    MOVLW	    0X01
	    CALL	    comando
	    
continua_secuencia
	    	    
	    MOVLW	    0X80
	    CALL	    comando
	    
	    CALL	    programa
	    
inicio_secuencia
	    
recepcion_1
	    
	    BTFSC	    PORTB, 7
	    GOTO	    manual
	    
	    BTFSS	    PIR1, RCIF
	    GOTO	    recepcion_1
	    
	    MOVF	    RCREG, W
	    MOVWF	    PORTC
	    
	    MOVLW	    b'00000001'
	    MOVWF	    TXREG
	    
recepcion_2
	    
	    BTFSC	    PORTB, 7
	    GOTO	    manual
	    
	    BTFSS	    PIR1, RCIF
	    GOTO	    recepcion_2
	    
	    MOVF	    RCREG, W
	    MOVWF	    flag
	    
	    MOVLW	    b'00000001'
	    MOVWF	    TXREG	    
	    
recepcion_3
	    
	    BTFSC	    PORTB, 7
	    GOTO	    manual
	    
	    BTFSS	    PIR1, RCIF
	    GOTO	    recepcion_3
	    
	    MOVF	    RCREG, W
	    MOVWF	    pasos
	    
	    BANKSEL	    TMR0
	    CLRF	    TMR0
	    
	    BANKSEL	    CCPR1L  
	    MOVLW	    b'00000001'
	    MOVWF	    CCPR1L
	    
	    ;CALL	    retardo
	    
	    BANKSEL	    CCP1CON    			
	    MOVLW	    b'00001100'
	    MOVWF	    CCP1CON
	    
espera_1

	    BTFSC	    PORTB, 7
	    GOTO	    manual
	    
	    MOVF	    pasos, W
	    SUBWF	    TMR0, W
	    BTFSS	    STATUS, Z
	    
	    GOTO	    espera_1
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    BTFSS	    flag, 0
	    GOTO	    no_paso_extra
	    
	    BANKSEL	    PORTC
	    BSF		    PORTC, 2
	    
	    CALL	    retardo
	    
	    BCF		    PORTC, 2
	    
no_paso_extra	    
	    
	    MOVLW	    b'00000001'
	    MOVWF	    TXREG
	    
	    CALL	    retardo
	    
	    GOTO	    sel_modo
	    
;=============================[Control Manual]==================================	    
	    
manual
	    
	    BANKSEL	    INTCON
	    BCF		    INTCON, 7
	    
	    BTFSS	    INTCON, 0
	    GOTO	    continua_manual
	    BCF		    INTCON, 0
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    MOVLW	    0X01
	    CALL	    comando
	    
continua_manual
	    
	    MOVLW	    0X80
	    CALL	    comando
	    
	    CALL	    control_manual
	    
	    MOVLW	    0X90
	    CALL	    comando
	    
	    CALL	    eje
	    
	    MOVLW	    0XD0
	    CALL	    comando
	    
	    CALL	    movimiento
	    
inicio_manual
	    
	    BTFSC	    PORTB, 1
	    GOTO	    continua_3
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
continua_3
	    
	    MOVLW	    0XD6
	    CALL	    comando
	    
	    CALL	    sel_mov
	    
	    MOVF	    PORTA, W
	    
	    ANDLW	    b'00001111'
	    
	    ADDWF	    PCL
	    GOTO	    j1_menos
	    GOTO	    j1_mas
	    GOTO	    j2_menos
	    GOTO	    j2_mas
	    GOTO	    j3_menos
	    GOTO	    j3_mas
	    GOTO	    j4_menos
	    GOTO	    j4_mas
	    GOTO	    standby
	    
j1_menos	    
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '1'
	    CALL	    caracter
	    MOVLW	    '-'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00000010'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j1_mas
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '1'
	    CALL	    caracter
	    MOVLW	    '+'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00000011'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j2_menos	    
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '2'
	    CALL	    caracter
	    MOVLW	    '-'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00001000'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j2_mas
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '2'
	    CALL	    caracter
	    MOVLW	    '+'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00001001'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j3_menos	    
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '3'
	    CALL	    caracter
	    MOVLW	    '-'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00010000'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j3_mas
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '3'
	    CALL	    caracter
	    MOVLW	    '+'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00010001'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j4_menos	    
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '4'
	    CALL	    caracter
	    MOVLW	    '-'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00100000'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on
	    
j4_mas
	    
	    MOVLW	    0X95
	    CALL	    comando
	    
	    MOVLW	    'J'
	    CALL	    caracter
	    MOVLW	    '4'
	    CALL	    caracter
	    MOVLW	    '+'
	    CALL	    caracter
	    
	    BTFSC	    CCP1CON, 2
	    GOTO	    pwm_off
	    
	    BANKSEL	    PORTC
	    MOVLW	    b'00100001'
	    MOVWF	    PORTC
	    
	    CALL	    retardo
	    
	    BTFSS	    PORTB, 1
	    GOTO	    pulso
	    GOTO	    pwm_on

standby
	    
	    NOP
	    GOTO	    sel_modo
	    
;================================[Pulso]========================================

pulso
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    BANKSEL	    PORTC
	    BSF		    PORTC, 2
	    
	    CALL	    retardo
	    
	    BCF		    PORTC, 2
	    
	    GOTO	    sel_modo
	    
;=================================[PWM]=========================================
	    
pwm_off
	    
	    BANKSEL	    CCP1CON
	    CLRF	    CCP1CON
	    
	    CALL	    retardo
	    
	    GOTO	    sel_modo
	    
pwm_on	    
	    
	    BANKSEL	    CCPR1L  
	    MOVLW	    b'00000001'
	    MOVWF	    CCPR1L
	    
	    ;CALL	    retardo
	    
	    BANKSEL	    CCP1CON    			
	    MOVLW	    b'00001100'
	    MOVWF	    CCP1CON

	    GOTO	    sel_modo

;=================================[LCD]=========================================

comando
	   
	    BANKSEL	    PORTD
	    MOVWF	    PORTD

	    BCF		    PORTE, 1
	    BCF		    PORTE, 2
	    BSF		    PORTE, 0
	    CALL	    retardo1ms
	    BCF		    PORTE, 0

	    RETURN
	   
caracter
	   
	    BANKSEL	    PORTD
	    MOVWF	    PORTD

	    BCF		    PORTE, 1
	    BSF		    PORTE, 2
	    BSF		    PORTE, 0
	    CALL	    retardo1ms
	    BCF		    PORTE, 0

	    RETURN
	    
programa
	    
	    MOVLW	    'P'
	    CALL	    caracter
	    MOVLW	    'r'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    'g'
	    CALL	    caracter
	    MOVLW	    'r'
	    CALL	    caracter
	    MOVLW	    'a'
	    CALL	    caracter
	    MOVLW	    'm'
	    CALL	    caracter
	    MOVLW	    'a'
	    CALL	    caracter
	    
	    RETURN
	    
control_manual
	    
	    MOVLW	    'C'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    'n'
	    CALL	    caracter
	    MOVLW	    't'
	    CALL	    caracter
	    MOVLW	    'r'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    'l'
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    MOVLW	    'M'
	    CALL	    caracter
	    MOVLW	    'a'
	    CALL	    caracter
	    MOVLW	    'n'
	    CALL	    caracter
	    MOVLW	    'u'
	    CALL	    caracter
	    MOVLW	    'a'
	    CALL	    caracter
	    MOVLW	    'l'
	    CALL	    caracter
	    
	    RETURN
	    
eje
	    
	    MOVLW	    'E'
	    CALL	    caracter
	    MOVLW	    'j'
	    CALL	    caracter
	    MOVLW	    'e'
	    CALL	    caracter
	    MOVLW	    ':'
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    
	    RETURN
	    
movimiento
	    
	    MOVLW	    'M'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    'v'
	    CALL	    caracter
	    MOVLW	    '.'
	    CALL	    caracter
	    MOVLW	    ':'
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    
	    RETURN
	    
sel_mov
	    
	    BTFSS	    PORTB, 1
	    GOTO	    fino
	    GOTO	    continuo
	    
fino
	    
	    MOVLW	    'F'
	    CALL	    caracter
	    MOVLW	    'i'
	    CALL	    caracter
	    MOVLW	    'n'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    MOVLW	    ' '
	    CALL	    caracter
	    
	    RETURN
	    
continuo
	    
	    MOVLW	    'C'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    MOVLW	    'n'
	    CALL	    caracter
	    MOVLW	    't'
	    CALL	    caracter
	    MOVLW	    'i'
	    CALL	    caracter
	    MOVLW	    'n'
	    CALL	    caracter
	    MOVLW	    'u'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    
	    RETURN
	    
paro

	    MOVLW	    0X80
	    CALL	    comando
	    
	    MOVLW	    'P'
	    CALL	    caracter
	    MOVLW	    'a'
	    CALL	    caracter
	    MOVLW	    'r'
	    CALL	    caracter
	    MOVLW	    'o'
	    CALL	    caracter
	    
	    RETURN
	    
;===============================[Retardo]=======================================	    
	    
retardo		
		
	    MOVLW	    .150
	    MOVWF	    0X26
		
dec1		
		
	    MOVLW	    .50
	    MOVWF	    0X25
		
dec		
		
	    DECFSZ	    0X25, 1
	    GOTO	    dec
	    
	    DECFSZ	    0X26, 1
	    GOTO	    dec1
	    
	    RETURN
	    
;===========================[Retardo 1ms]=======================================	    
	    
retardo1ms		
		
	    MOVLW	    .10
	    MOVWF	    0X26
		
dec1_1ms		
		
	    MOVLW	    .5
	    MOVWF	    0X25
		
dec_1ms		
		
	    DECFSZ	    0X25, 1
	    GOTO	    dec_1ms
	    
	    DECFSZ	    0X26, 1
	    GOTO	    dec1_1ms
	    
	    RETURN
		
	    END