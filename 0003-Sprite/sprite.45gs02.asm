; MEGA65 - Basic sprite on screen
;        - Sprite made on Spritemate - https://www.spritemate.com/

                .target "45GS02" ; C65/Mega65
                .setting "LaunchCommand" "\\Emulator\\MEGA65\\XEMU\\xmega65.exe  -prg \"{0}\" -besure" ; Xemu Mega65 Debug

                *=$1601
                ;.byte $11,$20,$0a,$00,$fe,$02,$20,$30,$3a,$9e,$20,$38,$32,$31,$31,$00,$00,$00

                ; C64 mode only! currently overwriting the C65 BASIC ROM with the sprites @ $2000

                spriteloc   = $2000     ; start of sprite locations
                sprite0ptr  = $07f8     ; sprite 0 pointer
                sprite0x    = $d000     ; sprite 0 x
                sprite0y    = $d001     ; sprite 0 y
                spriteflags = $d015     ; turn on sprites by their associated bit (8 bits)
                spritemc    = $d01c     ; sprite Multicolour bits (same arrangement as enable flags)
				colbor      = $d020		; border colour
				colbak      = $d021     ; background colour

.code
;-- init --------------------------------
				lda #147                ; CLR HOME / CHR$(147)
				jsr $ffd2	            ; clear screen

				lda #11
				sta colbor	            ; border colour

				lda #00
				sta colbak	            ; screen colour

                lda #$01
                sta spritemc            ; multicolour bits (same arrangement as sprite enable)

                lda #$06
                sta $d025               ; sprite multicolour 1

                lda #$02
                sta $d026               ; sprite multicolour 2

                lda #$01
                sta $d027               ; sprite 0 colour

                lda #$81                ; cannot use label here :(  #$80 = 2000 sprite0, #$81 = 2040 = sprite1, etc.
                sta sprite0ptr          ; set the sprite

                lda #$01
                sta spriteflags         ; turn on sprite 0

                lda #$a0
                sta sprite0x            ; set sprite 0 x co-ordinate

                lda #$e0
                sta sprite0y            ; set sprite 0 y co-ordinate

				sei                     ; disable interrupts

;-- loop --------------------------------

mainloop
				jsr vbwait	; vblank wait
				jmp mainloop
			
vbwait
				lda $d012	; read current raster line
				cmp #250	; if on raster 250 we are in vblank
				bne vbwait	; keep waiting if not at 250
				rts			; return and process if at 250

.data
.org spriteloc  ; set memory location of sprite data
.align 64       ; align sprites to 64 byte boundary
sprite0
                ; sprite0
                ; big square block
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

sprite1
                ; sprite1
                ; awful looking space ship
                .byte $00,$10,$00,$00,$20,$00,$00,$20
                .byte $00,$00,$a8,$00,$00,$98,$00,$00
                .byte $98,$00,$00,$98,$00,$03,$ab,$00
                .byte $02,$aa,$00,$12,$aa,$10,$22,$66
                .byte $20,$22,$ee,$20,$2a,$66,$a0,$26
                .byte $ee,$60,$ae,$66,$e8,$aa,$aa,$a8
                .byte $aa,$aa,$a8,$3f,$03,$f0,$0c,$00
                .byte $c0,$0c,$00,$c0,$00,$00,$00,$81
