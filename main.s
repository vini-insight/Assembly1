.include "util.s"
.include "lcd.s"

.global _start

_start:
        gpio_map file_name, page_length, andress_base
        start_lcd
        GPIOPinIn b1
        GPIOPinIn b2
        gpio_pin_out PA8
        gpio_pin_high PA8
        MOV R10, #9
        @ b loop
        b pressButton

pressButton:
        GPIOPinState b1
        CMP R1, #0  @ verifica se o botao de reset foi pressionado
        BEQ loop
        b pressButton

loop:
        GPIOPinState b2
	CMP R1, #0
	BEQ pausar
        clear_lcd
        write_lcd R10
        sleep_by one_second, zero_mili_second
        SUB R10, R10, #1
        CMP R10, #-1
        BNE loop
        gpio_pin_low PA8
        b exit

exit:
        mov r7, #1
        mov r0, #0
        svc 0

@ LED VERMELHO
.data
        @PA18 - Enable
        ENABLE:
                .word 0x8
                .word 0x8
                .word 0x12
                .word 0x10
        @PA2 - RS
        RS:
                .word 0x0
                .word 0x8
                .word 0x2
                .word 0x10
        @PG7 - DB7
        DB7:
                .word 0xD8
                .word 0x1C
                .word 0x7
                .word 0xE8

        @PG6 - DB6
        DB6:
                .word 0xD8
                .word 0x18
                .word 0x6
                .word 0xE8

        @PG9 - DB5
        DB5:
                .word 0xDC
                .word 0x4
                .word 0x9
                .word 0xE8

        @PG8 - DB4
        DB4:
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
        @PA10 - Reset
        b1:
                .word 0x4
                .word 0x8
                .word 0xA
                .word 0x10

        @PA20 - Play/Pause
        b2:
                .word 0x8
                .word 0x10
                .word 0x14
                .word 0x10



        file_name: .asciz "/dev/mem" @ Caminho do arquivo para mapeamento da memória virtual
        andress_base: .word 0x1C20 @ Endereco base PIO / 4096
        page_length: .word 0x1000
        zero_second: .word 0
        mili_1_seconds: .word 1000000
        mili_5_seconds: .word 5000000
        micro_150_seconds: .word 150000
        one_second: .word 1
        zero_mili_second: .word 0
