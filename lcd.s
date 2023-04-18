.macro enableLCD
        GPIOpinLOW ENABLE
        sleep_by zero_second mili_1_seconds
        GPIOpinHIGH ENABLE
        sleep_by zero_second mili_1_seconds
        GPIOpinLOW ENABLE
.endm

.macro clearLCD

        GPIOpinLOW RS

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinLOW DB5
        GPIOpinLOW DB4
        enableLCD

        GPIOpinHIGH DB4
        enableLCD
.endm

.macro startLCD

        setGPIOoutputPin RS
        setGPIOoutputPin ENABLE
        setGPIOoutputPin DB7
        setGPIOoutputPin DB6
        setGPIOoutputPin DB6
        setGPIOoutputPin DB5
        setGPIOoutputPin DB4

        GPIOpinLOW RS

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinHIGH DB4
        enableLCD
        sleep_by zero_second, mili_5_seconds

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinHIGH DB4
        enableLCD
        sleep_by zero_second, micro_150_seconds

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinHIGH DB4
        enableLCD

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinLOW DB4
        enableLCD

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinLOW DB4
        enableLCD

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinLOW DB5
        GPIOpinLOW DB4
        enableLCD

        enableLCD
        GPIOpinHIGH DB7
        GPIOpinLOW DB6
        GPIOpinLOW DB5
        GPIOpinLOW DB4
        enableLCD

        GPIOpinLOW DB7
        enableLCD

        GPIOpinHIGH DB4
        enableLCD

        GPIOpinLOW DB4
        enableLCD

        GPIOpinLOW DB7
        GPIOpinHIGH DB6
        GPIOpinHIGH DB5
        enableLCD

        GPIOpinLOW DB6
        GPIOpinLOW DB5
        enableLCD

        GPIOpinHIGH DB7
        GPIOpinHIGH DB6
        GPIOpinHIGH DB5
        enableLCD

        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinLOW DB5
        GPIOpinLOW DB4
        enableLCD

        GPIOpinLOW DB7
        GPIOpinHIGH DB6
        GPIOpinHIGH DB5
        GPIOpinLOW DB4
        enableLCD
        .ltorg
.endm

.macro prefixNumberLCD
        GPIOpinLOW DB7
        GPIOpinLOW DB6
        GPIOpinHIGH DB5
        GPIOpinHIGH DB4
        enableLCD
.endm

.macro writeLCD number
        GPIOpinHIGH RS
        prefixNumberLCD

        @ para D4
        MOV R1, #0b00001
        AND R1, \number         @ 0001 & 0011 -> 0001
        LDR R0, =DB4
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D5
        MOV R1, #0b00010
        AND R1, \number         @ 0010 & 0011 -> 0010
        LSR R1, #1              @ Desloca o bit 1x para direita  -> 0001
        LDR R0, =DB5
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D6
        MOV R1, #0b00100
        AND R1, \number         @ 0100 & 0101 -> 0100
        LSR R1, #2              @ Desloca o bit 2x para direita  -> 0001
        LDR R0, =DB6
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D7
        MOV R1, #0b01000
        AND R1, \number         @ 01000 & 01000 -> 01000
        LSR R1, #3              @ Desloca o bit 3x para direita  -> 00001
        LDR R0, =DB7
        LDR R7, [R0, #8]
        BL switchLogicValuePin
        enableLCD
.endm
@ fim do arquivo
