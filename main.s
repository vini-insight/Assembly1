
@ abrir terminal na pasta do projeto e executar com o comando 'sh run.sh' OU com o comando 'make'. precisa informar senha de usuário sudo.
.include "util.s"
.include "lcd.s"
.global _start
_start:
        GPIOmap fileName, pageSize, baseAddress
        setGPIOinputPin PA7toStartButton
        setGPIOinputPin PA10toPauseButton
        setGPIOinputPin PA20toResetButton
        setGPIOoutputPin PA8toRedLED
        setGPIOoutputPin PA9toBlueLED
        .ltorg @ PARA CORRIGIR O ERRO: "Error: invalid literal constant: pool needs to be closer"
        startLCD
        GPIOpinLOW PA8toRedLED
        GPIOpinLOW PA9toBlueLED
        MOV R10, #9
        b startsIFpressButton
        @sleep oneSecond, zeroMILLIsecond
        @b exit
startsIFpressButton:
        checkButton PA7toStartButton          @ verifica se o botao de PA7toStartButton foi pressionado
        CMP R1, #0
        BEQ while
        b startsIFpressButton
while:
        checkButton PA10toPauseButton          @ verifica se o botao de PA10toPauseButton foi pressionado
        CMP R1, #0
        BEQ pausesIFbuttonISpressed
        checkButton PA20toResetButton          @ verifica se o botao de PA20toResetButton foi pressionado
        CMP R1, #0
        BEQ resetCountIFbuttonISpressed
        clearLCD
        writeLCD R10
        sleep oneSecond, zeroMILLIsecond
        SUB R10, R10, #1
        CMP R10, #-1
        BNE while        
        GPIOpinHIGH PA8toRedLED
        GPIOpinHIGH PA9toBlueLED
        b exit        
pausesIFbuttonISpressed:
        sleep oneSecond, zeroMILLIsecond
        b while
resetCountIFbuttonISpressed:
        MOV R10, #9
        b while
exit:
        sleep oneSecond, zeroMILLIsecond
        GPIOpinLOW PA8toRedLED
        clearLCD
        mov r7, #1
        mov r0, #0
        svc 0
@               As Labels seguintes tem "4 words":
@               VALORES PODEM ESTAR NO SISTEMA HEXADECIMAL (0xF) OU DECIMAIS (15).
@               primeira '.word' é o offset do registrador de função do pino (serve para alterar o modo do pino I/O)
@               segunda '.word' é o offset do pino no registrador de função (lsb, serve para identificar o tríade do pino)
@               terceira '.word' é o offset do pino no registrador de dados (serve para apontar a posição no registrador de dados)
@               quarta '.word' é o offset do registrador de dados do pino (serve para acessar o registrador de dados do pino)
.data
        PA7toStartButton:         @ startButton PA7 (GPIO)
                .word 0x0
                .word 0x1C
                .word 0x7
                .word 0x10
        PA10toPauseButton:        @ pauseButton PA10 (GPIO)
                .word 0x4
                .word 0x8
                .word 0xA
                .word 0x10
        PA20toResetButton:        @ resetButton PA20 (GPIO)
                .word 0x8
                .word 0x10
                .word 0x14
                .word 0x10
        PA8toRedLED:      @ redLED PA8 (GPIO)
                .word 0x4
                .word 0x0
                .word 0x8
                .word 0x10
        PA9toBlueLED:     @ blueLED PA9 (GPIO)
                .word 0x4
                .word 0x4
                .word 0x9
                .word 0x10        
        PA18toENABLE: @ PA18 (GPIO) PA18toENABLE (LCD)
                .word 0x8
                .word 0x8
                .word 0x12
                .word 0x10
        PA2toRS:     @ PA2 (GPIO) PA2toRS (LCD)
                .word 0x0
                .word 0x8
                .word 0x2
                .word 0x10
        PG6toDB6:    @ PG6 (GPIO) PG6toDB6 (LCD)
                .word 0xD8
                .word 0x18
                .word 0x6
                .word 0xE8
        PG7toDB7:    @ PG7 (GPIO) PG7toDB7 (LCD)
                .word 0xD8
                .word 0x1C
                .word 0x7
                .word 0xE8
        PG8toDB4:    @ PG8 (GPIO) PG8toDB4 (LCD)
                .word 0xDC
                .word 0x0
                .word 0x8
                .word 0xE8
        PG9toDB5:    @ PG9 (GPIO) PG9toDB5 (LCD)
                .word 0xDC
                .word 0x4
                .word 0x9
                .word 0xE8
        fileName: .asciz "/dev/mem"             @ Caminho do arquivo para mapeamento da memória virtual
        baseAddress: .word 0x1C20               @ Endereco base GPIO / 4096 (encontrado no datasheet do allwinner h3)
        pageSize: .word 0x1000                  @ tamanho da página virtual
        micro150seconds: .word 150000
        fiveMILLIseconds: .word 5000000
        oneSecond: .word 1
        zeroSecond: .word 0
        oneMILLIsecond: .word 1000000
        zeroMILLIsecond: .word 0
@ fim do arquivo

@ checkP:
@         checkButton PA10toPauseButton          @ verifica se o botao de PA10toPauseButton foi pressionado
@         CMP R1, #0
@         BEQ pausesIFbuttonISpressed
@         b checkR
@ checkR:
@         checkButton PA20toResetButton          @ verifica se o botao de PA20toResetButton foi pressionado
@         CMP R1, #0
@         BEQ resetCountIFbuttonISpressed
@         b while
