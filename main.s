
@ abrir terminal na pasta do projeto e executar com o comando 'sh run.sh' OU com o comando 'make'. precisa informar senha de usuário sudo.
.include "util.s"
.include "lcd.s"
.global _start
_start:
        GPIOmap fileName, pageSize, baseAddress
        startLCD
        setGPIOinputPin b1
        setGPIOinputPin b2
        setGPIOoutputPin PA8
        GPIOpinHIGH PA8
        MOV R10, #9
        b startsIFpressButton
startsIFpressButton:
        checkButton b1          @ verifica se o botao de startButton foi pressionado
        CMP R1, #0
        BEQ while
        b startsIFpressButton
while:
        checkButton b2          @ verifica se o botao de pauseButton foi pressionado
        CMP R1, #0
        BEQ pausesIFbuttonISpressed
        clearLCD
        writeLCD R10
        sleep_by one_second, zero_mili_second
        SUB R10, R10, #1
        CMP R10, #-1
        BNE while
        GPIOpinLOW PA8
        b exit
pausesIFbuttonISpressed:
        sleep_by one_second, zero_mili_second
        b while
exit:
        mov r7, #1
        mov r0, #0
        svc 0
@               As Labels seguintes tem "4 words":
@               primeira '.word' é o offset do registrador de função do pino (serve para alterar o modo do pino I/O)
@               segunda '.word' é o offset do pino no registrador de função (lsb, serve para identificar o tríade do pino)
@               terceira '.word' é o offset do pino no registrador de dados (serve para apontar a posição no registrador de dados)
@               quarta '.word' é o offset do registrador de dados do pino (serve para acessar o registrador de dados do pino)
.data
        
        ENABLE: @PA18 - ENABLE
                .word 0x8
                .word 0x8
                .word 0x12
                .word 0x10
        RS:     @PA2 - RS
                .word 0x0
                .word 0x8
                .word 0x2
                .word 0x10
        DB7:    @PG7 - DB7
                .word 0xD8
                .word 0x1C
                .word 0x7
                .word 0xE8
        DB6:    @PG6 - DB6
                .word 0xD8
                .word 0x18
                .word 0x6
                .word 0xE8
        DB5:    @PG9 - DB5
                .word 0xDC
                .word 0x4
                .word 0x9
                .word 0xE8
        DB4:    @PG8 - DB4
                .word 0xDC
                .word 0x0
                .word 0x8
                .word 0xE8
        PA9:
                .word 4
                .word 4
                .word 9
                .word 0x10
        PA8:
                .word 4
                .word 0
                .word 8
                .word 0x10
        b1:     @PA10 startButton
                .word 0x4
                .word 0x8
                .word 0xA
                .word 0x10
        b2:     @PA20 pauseButton
                .word 0x8
                .word 0x10
                .word 0x14
                .word 0x10
        b3:     @PA7: resetButton
                .word 0x0
                .word 0x1F
                .word 0x7
                .word 0x10
        fileName: .asciz "/dev/mem"             @ Caminho do arquivo para mapeamento da memória virtual
        baseAddress: .word 0x1C20               @ Endereco base GPIO / 4096 (encontrado no datasheet do allwinner h3)
        pageSize: .word 0x1000                  @ tamanho da página virtual
        zero_second: .word 0
        mili_1_seconds: .word 1000000
        mili_5_seconds: .word 5000000
        micro_150_seconds: .word 150000
        one_second: .word 1
        zero_mili_second: .word 0
@ fim do arquivo
