;================================================ PRINTS ================================================
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

%macro printGameEnd 3
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3   ; String
	call printColorEnd
%endmacro

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
		je .end_print_string
		call printChar
		jmp loop_print_string
	.end_print_string:
  ret

;------------------------- PRINTA TÍTULO COM CORES PREDEFINIDAS
printColorTitle:
  .change_color:
    cmp al, 0x3d ;=
    je .go_lightgreen
    cmp al, 0x2d ;-
    je .go_lightblue
    cmp al, 0x3c ;<
    je .go_lightblue
    cmp al, 0x3e ;>
    je .go_lightblue
    cmp al, 0x7c ;|
    je .go_lightgreen
    cmp al, 0x57 ;W
    je .go_green
    cmp al, 0x4f ;O
    je .go_red
    cmp al, 0x52 ;R
    je .go_yellow
    cmp al, 0x44 ;D
    je .go_red
    cmp al, 0x4c ;L
    je .go_yellow
    cmp al, 0x45 ;E
    je .go_green
    cmp al, 0x78 ;x
    je .go_red
    cmp al, 0x38 ;8
    je .go_green
    cmp al, 0x36 ;6
    je .go_red
    cmp al, 0x28 ;(
    je .go_magenta
    cmp al, 0x29 ;)
    je .go_magenta
    cmp al, 0x2f ;/
    je .go_magenta
    cmp al, 0x5f ;_
    je .go_magenta
    cmp al, 0x70 ;p
    je .go_lightcyan
    cmp al, 0x72 ;r
    je .go_lightcyan
    cmp al, 0x65 ;e
    je .go_lightcyan
    cmp al, 0x73 ;s
    je .go_lightcyan
    cmp al, 0x6e ;n
    je .go_lightcyan
    cmp al, 0x74 ;t
    je .go_lightcyan
    cmp al, 0x6f ;o
    je .go_lightcyan
    cmp al, 0x61 ;a
    je .go_lightcyan
    cmp al, 0x40 ;@
    je .go_lightgreen
    jmp .go_lightred

    .go_magenta:
      mov bx, magentaColor
      call printChar
      jmp .loop_print_msg
    .go_lightgreen:
      mov bx, lightGreenColor
      call printChar
      jmp .loop_print_msg
    .go_lightred:
      mov bx, lightRedColor
      call printChar
      jmp .loop_print_msg
    .go_green:
      mov bx, greenColor
      call printChar
      jmp .loop_print_msg
    .go_yellow:
      mov bx, yellowColor
      call printChar
      jmp .loop_print_msg
    .go_red:
      mov bx, redColor
      call printChar
      jmp .loop_print_msg
    .go_lightblue:
      mov bx, lightBlueColor
      call printChar
      jmp .loop_print_msg
    .go_lightcyan:
      mov bx, lightCyanColor
      call printChar
      jmp .loop_print_msg

	.loop_print_msg:
		lodsb
		cmp al, '$'
		je .end_print
		jmp .change_color

	.end_print:
  ret

;------------------------- PRINTA WIN/LOSE COM CORES PREDEFINIDAS
printColorEnd:
  .change_color:
    ;;========================= WORDLE x86
    cmp al, 0x57 ;W
    je .go_green
    cmp al, 0x4f ;O
    je .go_red
    cmp al, 0x52 ;R
    je .go_yellow
    cmp al, 0x44 ;D
    je .go_red
    cmp al, 0x4c ;L
    je .go_yellow
    cmp al, 0x45 ;E
    je .go_green
    cmp al, 0x78 ;x
    je .go_red
    cmp al, 0x38 ;8
    je .go_green
    cmp al, 0x36 ;6
    je .go_red
    ;;========================= PARÊNTESES E AFINS
    cmp al, 0x28 ;(
    je .go_magenta
    cmp al, 0x29 ;)
    je .go_magenta
    cmp al, 0x2f ;/
    je .go_magenta
    cmp al, 0x5f ;_
    je .go_magenta
    cmp al, 0x3d ;=
    je .go_lightgreen
    cmp al, 0x2d ;-
    je .go_lightblue
    cmp al, 0x3c ;<
    je .go_lightblue
    cmp al, 0x3e ;>
    je .go_lightblue
    cmp al, 0x7c ;|
    je .go_lightgreen
    cmp al, 0x40 ;@
    je .go_lightgreen
    ;;========================= press enter to play again
    cmp al, 0x70 ;p
    je .go_lightcyan
    cmp al, 0x72 ;r
    je .go_lightcyan
    cmp al, 0x65 ;e
    je .go_lightcyan
    cmp al, 0x73 ;s
    je .go_lightcyan
    cmp al, 0x6e ;n
    je .go_lightcyan
    cmp al, 0x74 ;t
    je .go_lightcyan
    cmp al, 0x6f ;o
    je .go_lightcyan
    cmp al, 0x61 ;a
    je .go_lightcyan
    ;;========================= CONGRATULATIONS
    cmp al, 0x43 ;C
    je .go_lightblue
    cmp al, 0x47 ;G
    je .go_lightblue
    cmp al, 0x41 ;A
    je .go_lightblue
    cmp al, 0x54 ;T
    je .go_lightblue
    cmp al, 0x55 ;U
    je .go_lightblue
    cmp al, 0x49 ;I
    je .go_lightblue
    cmp al, 0x4e ;N
    je .go_lightblue
    cmp al, 0x53 ;S
    je .go_lightblue
    ;;========================= YOU WIN
    cmp al, 0x59 ;Y
    je .go_lightcyan

    jmp .go_cyan

    .go_magenta:
      mov bx, magentaColor
      call printChar
      jmp .loop_print_msg
    .go_lightgreen:
      mov bx, lightGreenColor
      call printChar
      jmp .loop_print_msg
    .go_cyan:
      mov bx, cyanColor
      call printChar
      jmp .loop_print_msg
    .go_green:
      mov bx, greenColor
      call printChar
      jmp .loop_print_msg
    .go_yellow:
      mov bx, yellowColor
      call printChar
      jmp .loop_print_msg
    .go_red:
      mov bx, redColor
      call printChar
      jmp .loop_print_msg
    .go_lightblue:
      mov bx, lightBlueColor
      call printChar
      jmp .loop_print_msg
    .go_lightcyan:
      mov bx, lightCyanColor
      call printChar
      jmp .loop_print_msg

	.loop_print_msg:
		lodsb
		cmp al, '$'
		je .end_print
		jmp .change_color

	.end_print:
  ret

;================================================ QUADRADOS ================================================
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

;================================================ FUNÇÕES DE USO GERAL ================================================
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

;================================================ PALAVRA SECRETA ================================================
;-------------------------- RANDOMIZA A PALAVRA SECRETA
randGen:
  mov ah, 00h  ; interrupts to get system time        
  int 1ah      ; Read system clock counter -> CX:DX now hold number of clock ticks since midnight      
  mov  ax, dx
  xor  dx, dx
  mov  cx, 6
  div  cx      ; here dx contains the remainder of the division - from 0 to 5
  ret

;-------------------------- SETA A PALAVRA SECRETA
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
  cmp dl, 5
  je .setWord5

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

  .setWord5:
    mov esi, word5
    jmp .endSetWord

  .endSetWord:
    mov edi, SECRET_WORD
    mov ecx, 6
    cld
    rep movsb ; Copia os caracteres da palavra selecionada para SECRET_WORD
  ret

;================================================ TENATIVAS ================================================
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

;================================================ CHECA SE GANHOU ================================================
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
    printGameEnd 0, 0, WINNER_MESSAGE
    printText 3, 17, SECRET_WORD, lightGreenColor
    call waitEnter
    call main

  .endCheckWin:
  ret