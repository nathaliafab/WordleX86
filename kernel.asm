ORG 0x7E00
jmp 0x0000:__start

%define blackColor 0
%define blueColor 1
%define greenColor 2
%define cyanColor 3
%define redColor 4
%define magentaColor 5
%define brownColor 6
%define lightGrayColor 7
%define darkGrayColor 8
%define lightBlueColor 9
%define lightGreenColor 10
%define lightCyanColor 11
%define lightRedColor 12
%define lightMagentaColor 13
%define yellowColor 14
%define whiteColor 15

;========================= DADOS =========================
section .data
  GAME_TITLE:     db '  ',0ah,0dh
                  db   ' g                 s          t        ',0ah,0dh
                  db   '           o                         o ',0ah,0dh
                  db   '      >  >  >  WORDLE x86  <  <  <     ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '     d                             a   ',0ah,0dh
                  db   '                e                      ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '  s                s      e          . ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '          (press enter to start)       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '     m              b       l     y    ',0ah,0dh
                  db   '       _____                           ',0ah,0dh
                  db   '      /    /|_ _____________________   ',0ah,0dh
                  db   '     /    // /|                    /|  ',0ah,0dh
                  db   '    (====|/ //          _QP_      / |  ',0ah,0dh
                  db   '     (=====|/          (  ` )    / .|  ',0ah,0dh
                  db   '    (====|/             \__/    / /||  ',0ah,0dh
                  db   '   /___________________________/ / ||  ',0ah,0dh
                  db   '   |  _______________________  ||  ||  ',0ah,0dh
                  db   '   | ||                      | ||      ',0ah,0dh
                  db   '   | ||     by               | ||      ',0ah,0dh
                  db   '   | |         @nathaliafab  | |       ',0ah,0dh
                  db   '$' ; fim da string

  WINNER_MESSAGE: db '  ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '         The secret word was:          ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '    C O N G R A T U L A T I O N S !    ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                _______                ',0ah,0dh
                  db   '               /       \               ',0ah,0dh
                  db   '              |   YOU   |              ',0ah,0dh
                  db   '              |         |              ',0ah,0dh
                  db   '              |   WIN!  |              ',0ah,0dh
                  db   '              |         |              ',0ah,0dh
                  db   '              |_________|              ',0ah,0dh
                  db   '               \       /               ',0ah,0dh
                  db   '                -------                ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '         You rocked WordleX86!         ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '      (press enter to play again)      ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '$' ; end of string

  LOSER_MESSAGE:  db '  ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '         The secret word was:          ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '         B E T T E R   L U C K         ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '          N E X T   T I M E !          ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                _______                ',0ah,0dh
                  db   '               /       \               ',0ah,0dh
                  db   '              |   YOU   |              ',0ah,0dh
                  db   '              |         |              ',0ah,0dh
                  db   '              |  LOSE!  |              ',0ah,0dh
                  db   '              |         |              ',0ah,0dh
                  db   '              |_________|              ',0ah,0dh
                  db   '               \       /               ',0ah,0dh
                  db   '                -------                ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '       Do not worry, it happens!       ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '      (press enter to play again)      ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '$' ; end of string

  word0: db 'apple', '$'
  word1: db 'beach', '$'
  word2: db 'candy', '$'
  word3: db 'daisy', '$'
  word4: db 'eagle', '$'
  ;"fairy", "grape", "honey", "image", "jelly", "kings", "lemon", "magic", "noble", "oasis", "peace", "quilt", "river", "sunny", "teeth", "unity", "vivid", "waste", "xerox", "yacht"

  numTries: db 0
  
  correct1: db 0
  correct2: db 0
  correct3: db 0
  correct4: db 0
  correct5: db 0

section .bss
  SECRET_WORD: resb 6 ; Aloca espaço para a palavra secreta
  CURRENT_TRY: resb 6 ; Aloca espaço para a tentativa atual

section .text
  global __start

;========================= MACROS =========================
%macro printCharAtCoord 3
  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, %1   ; Linha (x)
  mov dl, %2   ; Coluna (y)
  int 10h
  mov al, %3   ; Caractere
  call printChar
%endmacro

%macro printText 4
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3
	mov bx, %4
	call printColorText
%endmacro

%macro printGameTitle 3
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3   ; String
	call printColorTitle
%endmacro

%macro drawSquare 4
  mov ax, %1      ;Cor
  mov ah, 0x0c
  mov cx, %2      ;Coordenada X
  mov dx, %3      ;Coordenada Y
  mov si, %4      ;Tamanho
  mov di, si
  add di, dx      ;di = tamanho + y
  add si, cx      ;si = tamanho + x
  
  call draw_square
%endmacro

draw_square:
  xor bx, bx
  mov bx, cx ; guarda o valor inicial da coordenada x em bx
  
  draw_sq:
    mov cx, bx
  draw_row:
    int 10h
    inc cx
    cmp cx, si
    jne draw_row
    inc dx
    cmp dx, di
    jne draw_sq
  ret

%macro drawFiveSquares 7
  mov ax, %1      ;Cor (args 1-5 são as cores)
  mov ah, 0x0c
  mov cx, %6      ;Coordenada X (arg 6)
  mov dx, %7      ;Coordenada Y (arg 7)
  
  call draw_next_sq
  mov ax, %2      ;Cor (args 1-5 são as cores)
  mov ah, 0x0c
  call draw_next_sq
  mov ax, %3      ;Cor (args 1-5 são as cores)
  mov ah, 0x0c
  call draw_next_sq
  mov ax, %4      ;Cor (args 1-5 são as cores)
  mov ah, 0x0c
  call draw_next_sq
  mov ax, %5      ;Cor (args 1-5 são as cores)
  mov ah, 0x0c
  call draw_next_sq
%endmacro

draw_next_sq:
  drawSquare ax, cx, dx, 20
  add bx, 25
  sub dx, 20    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;========================= FUNÇÕES =========================
;------------------------- LIMPA REGISTRADORES
cleanRegs:
  xor ax, ax    ;limpando ax
  mov bx, ax    ;limpando bx
  mov cx, ax    ;limpando cx
  mov ds, ax    ;limpando ds
  mov es, ax    ;limpando es
  ret

;------------------------- INICIALIZA MODO DE VÍDEO
initVideo:
	mov ah, 00h
	mov al, 13h
	int 10h
  ret

;------------------------- PRINTA CARACTERE EM AL
printChar:
  mov ah, 0eh
  int 10h
  ret

;------------------------- PRINTA STRING COM COR ESPECIFICADA EM BX
printColorText:
	loop_print_string:
		lodsb
		cmp al, '$'
		je end_print_string
		call printChar
		jmp loop_print_string
	end_print_string:
  ret

;------------------------- PRINTA TITULO COM CORES PREDEFINIDAS
printColorTitle:
  change_color:
    cmp al, 0x3d ;=
    je go_lightgreen
    cmp al, 0x2d ;-
    je go_lightblue
    cmp al, 0x3c ;<
    je go_lightblue
    cmp al, 0x3e ;>
    je go_lightblue
    cmp al, 0x7c ;|
    je go_lightgreen
    cmp al, 0x57 ;W
    je go_green
    cmp al, 0x4f ;O
    je go_red
    cmp al, 0x52 ;R
    je go_yellow
    cmp al, 0x44 ;D
    je go_red
    cmp al, 0x4c ;L
    je go_yellow
    cmp al, 0x45 ;E
    je go_green
    cmp al, 0x78 ;x
    je go_red
    cmp al, 0x38 ;8
    je go_green
    cmp al, 0x36 ;6
    je go_red
    cmp al, 0x28 ;(
    je go_magenta
    cmp al, 0x29 ;)
    je go_magenta
    cmp al, 0x2f ;/
    je go_magenta
    cmp al, 0x5f ;_
    je go_magenta
    cmp al, 0x70 ;p
    je go_lightcyan
    cmp al, 0x72 ;r
    je go_lightcyan
    cmp al, 0x65 ;e
    je go_lightcyan
    cmp al, 0x73 ;s
    je go_lightcyan
    cmp al, 0x6e ;n
    je go_lightcyan
    cmp al, 0x74 ;t
    je go_lightcyan
    cmp al, 0x6f ;o
    je go_lightcyan
    cmp al, 0x61 ;a
    je go_lightcyan
    cmp al, 0x40 ;@
    je go_lightgreen
    jmp go_lightred

    go_magenta:
      mov bx, magentaColor
      call printChar
      jmp loop_print_title
    go_lightgreen:
      mov bx, lightGreenColor
      call printChar
      jmp loop_print_title
    go_lightred:
      mov bx, lightRedColor
      call printChar
      jmp loop_print_title
    go_green:
      mov bx, greenColor
      call printChar
      jmp loop_print_title
    go_yellow:
      mov bx, yellowColor
      call printChar
      jmp loop_print_title
    go_red:
      mov bx, redColor
      call printChar
      jmp loop_print_title
    go_lightblue:
      mov bx, lightBlueColor
      call printChar
      jmp loop_print_title
    go_lightcyan:
      mov bx, lightCyanColor
      call printChar
      jmp loop_print_title

	loop_print_title:
		lodsb
		cmp al, '$'
		je end_print_title
		jmp change_color

	end_print_title:
  ret

;------------------------- ESPERA INPUT ENTER DO USUÁRIO
waitEnter:
  mov ah, 0x00
  int 16h
  cmp al, 0x0d  ;Enter
  jne waitEnter
  ret

;------------------------- LIMPA A TELA
clearScreen:
  mov ah, 06h   ;Setando o cursor
  mov al, 0     ;Página 0
  mov bh, 0     ;Cor de fundo
  mov ch, 0     ;Linha inicial
  mov cl, 0     ;Coluna inicial
  mov dh, 24    ;Linha final
  mov dl, 79    ;Coluna final
  int 10h
  ret

;-------------------------- RANDOMIZA A PALAVRA SECRETA
randGen:
  mov ah, 00h  ; interrupts to get system time        
  int 1ah      ; Read system clock counter -> CX:DX now hold number of clock ticks since midnight      
  mov  ax, dx
  xor  dx, dx
  mov  cx, 5    
  div  cx      ; here dx contains the remainder of the division - from 0 to 4
  ret

;-------------------------- SETA A PALAVRA SECRETA (podre mas é o que tá tendo)
setSecretWord:
  call randGen

  cmp dl, 0
  je .setWord0
  cmp dl, 1
  je .setWord1
  cmp dl, 2
  je .setWord2
  cmp dl, 3
  je .setWord3
  cmp dl, 4
  je .setWord4

  .setWord0:
    mov esi, word0
    jmp .endSetWord

  .setWord1:
    mov esi, word1
    jmp .endSetWord

  .setWord2:
    mov esi, word2
    jmp .endSetWord
  
  .setWord3:
    mov esi, word3
    jmp .endSetWord

  .setWord4:
    mov esi, word4
    jmp .endSetWord

  .endSetWord:
    mov edi, SECRET_WORD
    mov ecx, 6
    cld
    rep movsb ; Copia os caracteres da palavra selecionada para SECRET_WORD
  ret

;-------------------------- JOGADOR TENTA ADIVINHAR A PALAVRA SECRETA
playerTry:
  mov ecx, 5          ; Tamanho da palavra secreta
  mov dl, 0           ; Posição inicial da string da tentativa atual
  mov edi, CURRENT_TRY ; Endereço da string da tentativa atual

  getChar:
    mov ah, 0x00
    int 16h
    stosb
    printCharAtCoord [numTries], dl, al
    inc dl
    loop getChar
  
  mov al, '$' ; Finaliza a string
  stosb
  call waitEnter  ; Espera o usuário apertar enter
  ret

;-------------------------- DESENHA QUADRADO VERDE NO LOCAL INDICADO
rightChar:
  mov ax, lightGreenColor
  mov ah, 0x0c
  drawSquare ax, cx, dx, 20
  add bx, 25
  sub dx, 20    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;-------------------------- DESENHA QUADRADO VERMELHO NO LOCAL INDICADO
wrongChar:
  mov ax, lightRedColor
  mov ah, 0x0c
  drawSquare ax, cx, dx, 20
  add bx, 25
  sub dx, 20    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;-------------------------- CHECA LETRAS DA TENATIVA ATUAL COM A PALAVRA SECRETA
checkWord:
  mov esi, CURRENT_TRY
  mov edi, SECRET_WORD
  
  .char0:
    xor eax, eax
    lodsb            ; Carrega o caractere da tentativa atual em al e incrementa esi
    cmp al, byte [edi]  ; Compara com o caractere da palavra secreta
    je .callRightChar1
    jne .callWrongChar1

    .callRightChar1:
      mov byte [correct1], 1
      call rightChar       ; Se for igual, pula para rightChar
      jmp .char1

    .callWrongChar1:
      mov byte [correct1], 0
      call wrongChar       ; Se for diferente, pula para wrongChar
      jmp .char1

  .char1:
    mov esi, CURRENT_TRY + 1
    mov edi, SECRET_WORD + 1
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar2
    jne .callWrongChar2

    .callRightChar2:
      mov byte [correct2], 1
      call rightChar
      jmp .char2
        
    .callWrongChar2:
      mov byte [correct2], 0
      call wrongChar
      jmp .char2

  .char2:
    mov esi, CURRENT_TRY + 2
    mov edi, SECRET_WORD + 2
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar3
    jne .callWrongChar3

    .callRightChar3:
      mov byte [correct3], 1
      call rightChar
      jmp .char3
        
    .callWrongChar3:
      mov byte [correct3], 0
      call wrongChar
      jmp .char3

  .char3:
    mov esi, CURRENT_TRY + 3
    mov edi, SECRET_WORD + 3
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar4
    jne .callWrongChar4

    .callRightChar4:
      mov byte [correct4], 1
      call rightChar
      jmp .char4

    .callWrongChar4:
      mov byte [correct4], 0
      call wrongChar
      jmp .char4

  .char4:
    mov esi, CURRENT_TRY + 4
    mov edi, SECRET_WORD + 4
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar5
    jne .callWrongChar5

    .callRightChar5:
      mov byte [correct5], 1
      call rightChar
      ret

    .callWrongChar5:
      mov byte [correct5], 0
      call wrongChar
      ret

;-------------------------- CHECA SE O JOGADOR GANHOU
checkWin:
  cmp byte [correct1], 1
  je .checkWin1
  jmp .endCheckWin

  .checkWin1:
    cmp byte [correct2], 1
    je .checkWin2
    jmp .endCheckWin
  
  .checkWin2:
    cmp byte [correct3], 1
    je .checkWin3
    jmp .endCheckWin

  .checkWin3:
    cmp byte [correct4], 1
    je .checkWin4
    jmp .endCheckWin

  .checkWin4:
    cmp byte [correct5], 1
    je .playerWin
    jmp .endCheckWin

  .playerWin:
    call clearScreen
    printGameTitle 0, 0, WINNER_MESSAGE
    printText 3, 17, SECRET_WORD, lightGreenColor
    call waitEnter
    call __start

  .endCheckWin:
  ret


;-------------------------- INCREMENTA O NÚMERO DE TENTATIVAS
incTries:
  mov al, [numTries]
  inc al
  mov [numTries], al
  ret

;-------------------------- INICIALIZA O NÚMERO DE TENTATIVAS
initTries:
  mov byte [numTries], 0
  ret

;-------------------------- ATUALIZA A TELA COM A TENTATIVA ATUAL
updateGame:
  cmp byte [numTries], 0
  je .firstLine

  cmp byte [numTries], 1
  je .secondLine

  cmp byte [numTries], 2
  je .thirdLine

  cmp byte [numTries], 3
  je .fourthLine

  cmp byte [numTries], 4
  je .fifthLine

  .firstLine:
    mov cx, 100 ; Posição x inicial da primeira linha
    mov dx, 50  ; Posição y inicial da primeira linha
    call checkWord
    jmp .end

  .secondLine:
    mov cx, 100 ; Posição x inicial da segunda linha
    mov dx, 80  ; Posição y inicial da segunda linha
    call checkWord
    jmp .end

  .thirdLine:
    mov cx, 100 ; Posição x inicial da terceira linha
    mov dx, 110 ; Posição y inicial da terceira linha
    call checkWord
    jmp .end
  
  .fourthLine:
    mov cx, 100 ; Posição x inicial da quarta linha
    mov dx, 140 ; Posição y inicial da quarta linha
    call checkWord
    jmp .end

  .fifthLine:
    mov cx, 100 ; Posição x inicial da quinta linha
    mov dx, 170 ; Posição y inicial da quinta linha
    call checkWord
    jmp .end

  .end:
    ret

;========================= GAME =========================
__start:
  call cleanRegs
  call clearScreen
  call initVideo
  printGameTitle 0, 0, GAME_TITLE
  call waitEnter
  call initGame
  call gameLoop
  call endGame
  jmp $

;------------------------- INICIALIZA O JOGO
initGame:
  call cleanRegs
  call clearScreen
  call initTries
  call setSecretWord
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 50
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 80
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 110
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 140
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 170
  ret

;------------------------- JOGO RODANDO
gameLoop:
  call playerTry
  call updateGame
  call checkWin

  call incTries
  mov cl, [numTries]
  cmp cl, 5
  jge .endGameLoop
  jmp gameLoop

  .endGameLoop:
  ret

;------------------------- FINALIZA O JOGO
endGame:
  call cleanRegs
  call clearScreen
  printGameTitle 0, 0, LOSER_MESSAGE
  printText 3, 17, SECRET_WORD, lightGreenColor
  call waitEnter
  call __start
  ret