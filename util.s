
switchLogicValuePin:
        LDR R2, [R0, #12]       @ offset do registrador de dados do pino
        LDR R3, [R8, R2]        @ conteudo do registrador de dados do pino
        MOV R4, #1              @ mascara de bit
        LSL R4, R7              @ desloca o bit para a posicao do pino no registrador de dados
        CMP R1, #1              @ compara se o valor passado em R1
        BEQ pinHIGH             @ caso R1 seja igual a 1
        BLT pinLOW              @ caso R1 nao seja menor que 1 (0)

pinHIGH:
        ORR R3, R4              @ insere o bit anteriormente deslocado no registrador de dados
        STR R3, [R8, R2]        @ armazena o novo valor do registrador de dados na memoria
        BX LR

pinLOW:
        BIC R3, R4              @ limpando o bit anterirmente deslocado no registrador de dados
        STR R3, [R8, R2]        @ armazenando o novo valor do registrador de dados na memoria
        BX LR

.macro sleep seconds nanoSeconds
        mov r7, #162                    @ define r7 como código da chamada do sistema (syscall nanosleep)
        ldr r0, =\seconds               @ define r0 para tempo de espera em segundos
        ldr r1, =\nanoSeconds          @ define r1 para tempo de espera em nano segundos
        svc 0                           @ efetua chamada de sistema (syscall)
.endm

.macro GPIOmap fileName pageSize baseAddress    @ macro de mapeamento GPIO
        LDR R0, =\fileName                      @ obtém nome de arquivo de mapeamento de memória virtual
        MOV R1, #2                              @ define R1 como somente leitura
        MOV R7, #5                              @ define R7 com código de abertura de arquivo
        SWI 0                                   @ efetua chamada de sistema
        MOV R4, R0                              @ salva descritor do arquivo
        MOV R0, #0                              @ define em nulo o endereço virtual, fazendo com que o linux escolha automaticamente
        LDR R1, =\pageSize                      @ define comprimento de paginação de arquivo
        MOV R2, #3                              @ define proteção de escrita
        MOV R3, #1                              @ define indicativo de que a memória é compartilhada
        LDR R5, =\baseAddress                   @ carrega o endereço do offset
        LDR R5, [R5]                            @ carrega o offset
        MOV R7, #192                            @ define R7 com código de mapeamento de memória
        SVC 0                                   @ efetua chamada de sistema
        ADD R8, R0, #0x800                      @ define a adição do offset exato para acesso aos pinos
.endm

.macro setGPIOinputPin pin      @ define o pino da GPIO como modo de entrada
        LDR R0, =\pin           @ carrega o endereco de memoria de ~pin~
        LDR R1, [R0, #0]        @ offset do registrador de funcao do pino
        LDR R2, [R0, #4]        @ offset do pino no registrador de funcao (LSB)
        LDR R5, [R8, R1]        @ conteudo do registrador de dados do pino
        MOV R0, #0b111          @ mascara para limpar 3 bits
        LSL R0, R2              @ desloca @111 para posicao do pino no registrador de funcao
        BIC R5, R0              @ limpa os 3 bits da posicao
        STR R5, [R8, R1]        @ armazena o novo valor do registrador de funcao na memoria
.endm

.macro setGPIOoutputPin pin     @ faz backup dos valores contidos nos registradores r7 e r0        
        ldr r0, =\pin
        ldr r1, [r0, #0]        @ offset do registrador de funcao do pino
        ldr r2, [r0, #4]        @ offset do pino no registrador de funcao (LSB)
        ldr r5, [r8, r1]        @ conteudo do registrador de dados do pino
        mov r0, #0b111          @ mascara para limpar 3 bits
        lsl r0, r2              @ deslocamento em r0 com r2 vezes
        bic r5, r0              @ limpa os 3 bits da posição
        mov r0, #1              @ move 1 para r0
        lsl r0, r2              @ deslocamento em r0 com r2 vezes
        orr r5, r0              @ adiciona o valor 1 na posicao anteriomente deslocado
        str r5, [r8, r1]        @ armazena o novo valor do registrador de funcao na memoria
.endm

.macro GPIOpinLOW pin
        ldr r0, =\pin
        ldr r2, [r0, #8]        @ offset do pino no registrador de dados
        ldr r1, [r0, #12]       @ offset do registrador de dados do pino
        ldr r5, [r8, r1]        @ endereco base + registrador de dados
        mov r4, #1              @ move 1 para r4
        lsl r4, r2              @ desloca para r4 r4 r2 vezes
        bic r3, r5, r4          @ insere 1 na posicao anteriomente deslocada
        str r3, [r8, r1]        @ armazena o novo valor do registrador de dados na memoria
.endm

.macro GPIOpinHIGH pin
        ldr r0, =\pin
        ldr r2, [r0, #8]        @ offset do pino no registrador de dados
        ldr r1, [r0, #12]       @ offset do registrador de dados do pino
        ldr r5, [r8, r1]        @ endereco base + registrador de dados
        mov r4, #1              @ move 1 para r4
        lsl r4, r2              @ desloca para r4 r4 r2 vezes
        orr r3, r5, r4          @ insere 1 na posicao anteriomente deslocada
        str r3, [r8, r1]        @ armazena o novo valor do registrador de dados na memoria
.endm

.macro checkButton pin          @ checa o valor lógico do botão no pino conectado a ele e armazena este valor lógico em um registrador
        LDR R0, =\pin
        LDR R2, [R0, #8]        @ offset do pino no registrador de dados
        LDR R1, [R0, #12]       @ offset do registrador de dados do pino
        LDR R3, [R8, R1]        @ endereco base + registrador de dados
        MOV R4, #1              @ move 1 para R4
        LSL R4, R2              @ desloca o que tem em R4 para R4, R2 vezes
        AND R3, R4              @ leitura do bit
        LSR R1, R3, R2          @ deslocamento do bit para o LSB
.endm
@ fim do arquivo

