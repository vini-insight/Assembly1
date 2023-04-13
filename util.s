.macro gpio_map file_name page_length andress_base
        LDR R0, =\file_name
        MOV R1, #2
        MOV R7, #5
        SWI 0
        MOV R4, R0
        MOV R0, #0
        LDR R1, =\page_length
        MOV R2, #3
        MOV R3, #1
        LDR R5, =\andress_base
        LDR R5, [R5]
        MOV R7, #192
        SVC 0
        ADD R8, R0, #0x800
.endm

.macro sleep_by seconds nano_seconds
        mov r7, #162            @define r7 como código de espera espera
        ldr r0, =\seconds       @define r0 para tempo de espera em segundos
        ldr r1, =\nano_seconds
        svc 0                   @efetua chamada de sistema
.endm

.macro gpio_pin_out pin
        @ faz backup dos valores contidos nos registradores r7 e r0
        ldr r0, =\pin
        ldr r1, [r0, #0]        @ offset do registrador de funcao do pino
        ldr r2, [r0, #4]        @ offset do pino no registrador de funcao (LSB)
        ldr r5, [r8, r1]        @ conteudo do registrador de dados do pino
        mov r0, #0b111          @ mascara para limpar 3 bits
        lsl r0, r2              @ deslocamento em r0 com r2 vezes
        bic r5, r0              @ limpa os 3 bits da posição
        mov r0, #1              @ move 1 para r0
        lsl r0, r2              @ deslocamento em r0 com r2 vezes
        orr r5, r0              @ adiciona o valor 1 na posicao anteriomente deslocad
        str r5, [r8, r1]        @ armazena o novo valor do registrador de funcao na memoria
.endm

.macro gpio_pin_high pin
        ldr r0, =\pin
        ldr r2, [r0, #8]        @ offset do pino no registrador de dados
        ldr r1, [r0, #12]       @ offset do registrador de dados do pino
        ldr r5, [r8, r1]        @ endereco base + registrador de dados
        mov r4, #1              @ move 1 para r4
        lsl r4, r2              @ desloca para r4 r4 r2 vezes
        orr r3, r5, r4          @ insere 1 na posicao anteriomente deslocada
        str r3, [r8, r1]        @ armazena o novo valor do registrador de dados na memoria
.endm

.macro gpio_pin_low pin
        ldr r0, =\pin
        ldr r2, [r0, #8]        @ offset do pino no registrador de dados
        ldr r1, [r0, #12]       @ offset do registrador de dados do pino
        ldr r5, [r8, r1]        @ endereco base + registrador de dados
        mov r4, #1              @ move 1 para r4
        lsl r4, r2              @ desloca para r4 r4 r2 vezes
        bic r3, r5, r4          @ insere 1 na posicao anteriomente deslocada
        str r3, [r8, r1]        @ armazena o novo valor do registrador de dados na memoria
.endm

/*
======================================================
  "Pega" o estado de ~pin~

  Devolve em R1 o estado do pino
======================================================
*/
.macro GPIOPinState pin
        LDR R0, =\pin
        LDR R2, [R0, #8] @ offset do pino no registrador de dados
        LDR R1, [R0, #12] @ offset do registrador de dados do pino
        LDR R3, [R8, R1] @ endereco base + registrador de dados
        MOV R4, #1 @ move 1 para R4
        LSL R4, R2 @ desloca o que tem em R4 para R4, R2 vezes
        AND R3, R4 @ leitura do bit
        LSR R1, R3, R2 @ deslocamento do bit para o LSB
.endm

.macro GPIOPinIn pin
        LDR R0, =\pin   @ carrega o endereco de memoria de ~pin~
        LDR R1, [R0, #0]        @ offset do registrador de funcao do pino
        LDR R2, [R0, #4]        @ offset do pino no registrador de funcao (LSB)
        LDR R5, [R8, R1]  @ conteudo do registrador de dados do pino
        MOV R0, #0b111   @ mascara para limpar 3 bits
        LSL R0, R2    @ desloca @111 para posicao do pino no registrador de funcao
        BIC R5, R0    @ limpa os 3 bits da posicao
        STR R5, [R8, R1] @ armazena o novo valor do registrador de funcao na memoria
.endm

gpio_pin_turn:
        LDR R2, [R0, #12] @ offset do registrador de dados do pino
        LDR R3, [R8, R2] @ conteudo do registrador de dados do pino
        MOV R4, #1 @ mascara de bit
        LSL R4, R7      @ desloca o bit para a posicao do pino no registrador de dados
        CMP R1, #1 @ compara se o valor passado em R1
        BEQ pin_high @ caso R1 seja igual a 1
        BLT pin_low @ caso R1 nao seja menor que 1 (0)

pin_high:
        ORR R3, R4 @ insere o bit anteriormente deslocado no registrador de dados
        STR R3, [R8, R2] @ armazena o novo valor do registrador de dados na memoria
        BX LR

pin_low:
        BIC R3, R4 @ limpando o bit anterirmente deslocado no registrador de dados
        STR R3, [R8, R2] @ armazenando o novo valor do registrador de dados na memoria
        BX LR
