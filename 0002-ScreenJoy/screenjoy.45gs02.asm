; MEGA65 - Basic joystick capture
;        - Change screen border when joystick 1 fire is pressed
;        - Change screen background when joystick 2 fire is pressed

                .target "45GS02" ; C65/Mega65
                .setting "LaunchCommand" "\\Emulator\\MEGA65\\XEMU\\xmega65.exe  -prg \"{0}\" -besure" ; Xemu Mega65 Debug

                *=$2001
                .byte $11,$20,$0a,$00,$fe,$02,$20,$30,$3a,$9e,$20,$38,$32,$31,$31,$00,$00,$00

				joy1	= $dc01		; joystick 1 (PORTB) - Note that Ports are numbered back to front
				joy2	= $dc00		; joystick 2 (PORTA)
				colbor  = $d020		; border colour
				colbak  = $d021     ; background colour

;-- init --------------------------------
				lda #147
				jsr $ffd2	; clear screen
				lda #11
				sta $d020	; border colour
				lda #0
				sta $d021	; screen colour
				sei

;-- loop --------------------------------

mainloop
				jsr vbwait	; vblank wait
				jsr input	; do input
				jmp mainloop
			
vbwait
				lda $d012	; read current raster line
				cmp #250	; if on raster 250 we are in vblank
				bne vbwait	; keep waiting if not at 250
				rts			; return and process if at 250

;-- input -------------------------------

input
				jsr fire1	; Should reuse the same routine for joy2
				jsr fire2
				rts

fire1
				lda joy1	; 0 = fire
				and #$10
				cmp #0
				beq border	; Jump to border subroutine if equal
				rts

fire2
				lda joy2	; 0 = fire
				and #$10	; Check bit 5
				cmp #0
				beq background	; Jump to background subroutine if equal
				rts

;-- output -------------------------------

border
				inc colbor
				rts

background
				inc colbak
				rts
