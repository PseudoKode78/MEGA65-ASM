; MEGA65 - Rotate the border colour as quickly as possible.
;        - Gives the retro feel of loading from tape.

                .target "45GS02" ; C65/Mega65
                .setting "LaunchCommand" "\\Emulator\\MEGA65\\XEMU\\xmega65.exe  -prg \"{0}\" -besure" ; Xemu Mega65 Debug

                *=$2001             ; Start of memory and code to auto run
                .byte $11,$20,$0a,$00,$fe,$02,$20,$30,$3a,$9e,$20,$38,$32,$31,$31,$00,$00,$00

                border = $d020      ; Border location in memory
mainloop
                inc border          ; Increment
                jmp mainloop        ; Return to the start of the loop
