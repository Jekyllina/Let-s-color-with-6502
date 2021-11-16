.org $8000  

init:
    LDY #$0E
    LDX #$42     
    TYA
    STA $0200,X

gameloop:
    joyloop:    
        LDA $4000  
        CMP #$20  
        BEQ changecolor   
        CMP #$08
        BEQ right
        CMP #$04
        BEQ left
        CMP #$01
        BEQ up
        CMP #$02
        BEQ down        
        BNE joyloop

;JSR gameloop

right:
    INX
    TYA
    STA $0200,X
    JSR joyloop

left:
    DEX
    TYA
    STA $0200,X
    JSR joyloop

up:
    TXA    
    SBC #$10
    TAX
    TYA
    STA $0200,X
    JSR joyloop

down:
    TXA
    CLC
    ADC #$10
    TAX
    TYA
    STA $0200,X
    JSR joyloop

changecolor:
    INY    
    CPY #$10
    BEQ resetY
    BNE joyloop

resetY:
    LDY #$01
    JSR joyloop

interrupt:     
    RTI  

nonmaskable: 
    RTI

.goto $FFFA
.dw nonmaskable
.dw init
.dw interrupt
