.macro start_lcd

        gpio_pin_out RS
        gpio_pin_out ENABLE
        gpio_pin_out DB7
        gpio_pin_out DB6
        gpio_pin_out DB6
        gpio_pin_out DB5
        gpio_pin_out DB4

        gpio_pin_low RS

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_high DB4
        enable_lcd
        sleep_by zero_second, mili_5_seconds

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_high DB4
        enable_lcd
        sleep_by zero_second, micro_150_seconds

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_high DB4
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_low DB4
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_low DB4
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_low DB5
        gpio_pin_low DB4
        enable_lcd

        enable_lcd
        gpio_pin_high DB7
        gpio_pin_low DB6
        gpio_pin_low DB5
        gpio_pin_low DB4
        enable_lcd

        gpio_pin_low DB7
        enable_lcd

        gpio_pin_high DB4
        enable_lcd

        gpio_pin_low DB4
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_high DB6
        gpio_pin_high DB5
        enable_lcd

        gpio_pin_low DB6
        gpio_pin_low DB5
        enable_lcd

        gpio_pin_high DB7
        gpio_pin_high DB6
        gpio_pin_high DB5
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_low DB5
        gpio_pin_low DB4
        enable_lcd

        gpio_pin_low DB7
        gpio_pin_high DB6
        gpio_pin_high DB5
        gpio_pin_low DB4
        enable_lcd
        .ltorg
.endm

.macro prefix_number_lcd
        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_high DB5
        gpio_pin_high DB4
        enable_lcd
.endm

.macro write_lcd number
        gpio_pin_high RS
        prefix_number_lcd

        @ D4
        MOV R1, #0b00001
        AND R1, \number          @0001 & 0011 -> 0001
        LDR R0, =DB4
        LDR R7, [R0, #8]
        BL gpio_pin_turn

        @ D5
        MOV R1, #0b00010
        AND R1, \number          @ 0010 & 0011 -> 0010
        LSR R1, #1              @ Desloca o bit 1x para direita  -> 0001
        LDR R0, =DB5
        LDR R7, [R0, #8]
        BL gpio_pin_turn

        @ D6
        MOV R1, #0b00100
        AND R1, \number          @ 0100 & 0101 -> 0100
        LSR R1, #2              @ Desloca o bit 2x para direita  -> 0001
        LDR R0, =DB6
        LDR R7, [R0, #8]
        BL gpio_pin_turn

        @ D7
        MOV R1, #0b01000
        AND R1, \number          @ 01000 & 01000 -> 01000
        LSR R1, #3              @ Desloca o bit 3x para direita  -> 00001
        LDR R0, =DB7
        LDR R7, [R0, #8]
        BL gpio_pin_turn
        enable_lcd
.endm

.macro clear_lcd

        gpio_pin_low RS

        gpio_pin_low DB7
        gpio_pin_low DB6
        gpio_pin_low DB5
        gpio_pin_low DB4
        enable_lcd

        gpio_pin_high DB4
        enable_lcd
.endm

.macro enable_lcd
        gpio_pin_low ENABLE
        sleep_by zero_second mili_1_seconds
        gpio_pin_high ENABLE
        sleep_by zero_second mili_1_seconds
        gpio_pin_low ENABLE
.endm
