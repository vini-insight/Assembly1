
.macro habilitarLCD
        GPIOpinLOW PA18toENABLE
        sleep zeroSecond oneMILLIsecond
        GPIOpinHIGH PA18toENABLE
        sleep zeroSecond oneMILLIsecond
        GPIOpinLOW PA18toENABLE
.endm

.macro clearLCD

        GPIOpinLOW PA2toRS

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinLOW PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinHIGH PG8toDB4
        habilitarLCD
.endm

.macro startLCD

        setGPIOoutputPin PA2toRS
        setGPIOoutputPin PA18toENABLE
        setGPIOoutputPin PG7toDB7
        setGPIOoutputPin PG6toDB6
        setGPIOoutputPin PG6toDB6
        setGPIOoutputPin PG9toDB5
        setGPIOoutputPin PG8toDB4

        GPIOpinLOW PA2toRS

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinHIGH PG8toDB4
        habilitarLCD
        sleep zeroSecond, fiveMILLIseconds

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinHIGH PG8toDB4
        habilitarLCD
        sleep zeroSecond, micro150seconds

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinHIGH PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinLOW PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        habilitarLCD
        GPIOpinHIGH PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinLOW PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        habilitarLCD

        GPIOpinHIGH PG8toDB4
        habilitarLCD

        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinHIGH PG6toDB6
        GPIOpinHIGH PG9toDB5
        habilitarLCD

        GPIOpinLOW PG6toDB6
        GPIOpinLOW PG9toDB5
        habilitarLCD

        GPIOpinHIGH PG7toDB7
        GPIOpinHIGH PG6toDB6
        GPIOpinHIGH PG9toDB5
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinLOW PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD

        GPIOpinLOW PG7toDB7
        GPIOpinHIGH PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinLOW PG8toDB4
        habilitarLCD
        .ltorg
.endm

.macro prefixNumberLCD
        GPIOpinLOW PG7toDB7
        GPIOpinLOW PG6toDB6
        GPIOpinHIGH PG9toDB5
        GPIOpinHIGH PG8toDB4
        habilitarLCD
.endm

.macro writeLCD number
        GPIOpinHIGH PA2toRS
        prefixNumberLCD

        @ para D4
        MOV R1, #0b00001
        AND R1, \number         @ 0001 & 0011 -> 0001
        LDR R0, =PG8toDB4
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D5
        MOV R1, #0b00010
        AND R1, \number         @ 0010 & 0011 -> 0010
        LSR R1, #1              @ Desloca o bit 1x para direita  -> 0001
        LDR R0, =PG9toDB5
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D6
        MOV R1, #0b00100
        AND R1, \number         @ 0100 & 0101 -> 0100
        LSR R1, #2              @ Desloca o bit 2x para direita  -> 0001
        LDR R0, =PG6toDB6
        LDR R7, [R0, #8]
        BL switchLogicValuePin

        @ para D7
        MOV R1, #0b01000
        AND R1, \number         @ 01000 & 01000 -> 01000
        LSR R1, #3              @ Desloca o bit 3x para direita  -> 00001
        LDR R0, =PG7toDB7
        LDR R7, [R0, #8]
        BL switchLogicValuePin
        habilitarLCD
.endm
@ fim do arquivo
