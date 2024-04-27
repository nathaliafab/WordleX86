;================================================ PRINTS ================================================
%macro printCharAtCoord 4
  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, %1   ; Linha (x)
  mov dl, %2   ; Coluna (y)
  int 10h
  mov al, %3   ; Caractere
  mov bl, %4   ; Cor do char
  call printChar
%endmacro

%macro printText 4
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3  ; String
	mov bx, %4  ; Cor
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
	.loop_print_string:
		lodsb
		test al, al ; verifica se chegou no fim da string
		jz .end_print_string
		call printChar
		jmp .loop_print_string
	.end_print_string:
  ret

;------------------------- PRINTA KEYBOARD EMBAIXO
printColorKeyboard:
  mov di, keyboard_status
  cmp byte [di], 0
  je .setColorNotPressed
  cmp byte [di], 1
  je .setColorIncorrect
  cmp byte [di], 2
  je .setColorMisplaced
  cmp byte [di], 3
  je .setColorCorrect

  .setColorNotPressed:
    mov bx, darkGrayColor
    jmp .loop_print_string
  
  .setColorIncorrect:
    mov bx, lightRedColor
    jmp .loop_print_string
  
  .setColorMisplaced:
    mov bx, yellowColor
    jmp .loop_print_string
  
  .setColorCorrect:
    mov bx, lightGreenColor
  
	.loop_print_string:
		lodsb
		test al, al ; verifica se chegou no fim da string
		jz .end_print_string
		call printChar
		jmp .loop_print_string
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
		test al, al
		jz .end_print
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
		test al, al
		jz .end_print
		jmp .change_color

	.end_print:
  ret

;------------------------- PRINTA KEYBOARD EMBAIXO
printKeyboard:
  mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, 20
	mov dl, 15
	int 10h
	mov si, KEYBOARD_KEYS1
	call printColorKeyboard

  mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, 21
	mov dl, 16
  int 10h
	mov si, KEYBOARD_KEYS2
	call printColorKeyboard

  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, 22
  mov dl, 17
  int 10h
  mov si, KEYBOARD_KEYS3
  call printColorKeyboard

  .end:
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
  drawSquare ax, cx, dx, 15
  add bx, 23
  sub dx, 15    ; restaura o valor de dx
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
  ; Generate a pseudo-random number using the TSC as seed
  rdtsc                ; Read the TSC into EDX:EAX
  add eax, edx         ; Add the high and low parts of TSC
  mov ebx, eax         ; Use the TSC value as the seed for the random number

  ; Generate a random number between 0 and the total number of words
  xor edx, edx         ; Clear EDX to store the remainder
  mov ecx, num_words
  div ecx              ; Divide the seed (EAX) by the word count (ECX)
  mov eax, edx         ; Use the remainder (EDX) as the random number
  ret

;-------------------------- SETA A PALAVRA SECRETA
setSecretWord:
  call randGen

  ; Find the address of the randomly chosen word
  mov esi, words       ; Load the address of the array into esi
  mov ecx, 6
  mul ecx              ; Multiply the random number by 6 (the size of each word)
  add esi, eax         ; esi = words + (random number * 6)

  mov edi, SECRET_WORD
  mov ecx, 6
  cld
  rep movsb ; Copia os caracteres da palavra selecionada para SECRET_WORD
  ret

;================================================ TENATIVAS ================================================
;-------------------------- CALCULA A COORDENADA DO CARACTERE
calcCharCoord:
  cmp byte[numTries], 0
  je .firstTry
  cmp byte[numTries], 1
  je .secondTry
  cmp byte[numTries], 2
  je .thirdTry
  cmp byte[numTries], 3
  je .fourthTry
  cmp byte[numTries], 4
  je .fifthTry
  cmp byte[numTries], 5
  je .sixthTry

  .firstTry:
    mov byte[charCoord], 2
    jmp .end
  
  .secondTry:
    mov byte[charCoord], 5
    jmp .end

  .thirdTry:
    mov byte[charCoord], 8
    jmp .end
  
  .fourthTry:
    mov byte[charCoord], 11
    jmp .end
  
  .fifthTry:
    mov byte[charCoord], 14
    jmp .end

  .sixthTry:
    mov byte[charCoord], 17
  
  .end:
    ret

;-------------------------- JOGADOR TENTA ADIVINHAR A PALAVRA SECRETA
playerTry:
  mov ecx, 5          ; Tamanho da palavra secreta
  mov dl, 14           ; Posição inicial da string da tentativa atual
  mov edi, CURRENT_TRY ; Endereço da string da tentativa atual

  call calcCharCoord

  getChar:
    mov ah, 0x00
    int 16h
    cmp al, 0x08 ;backspace
    je .backspace
    cmp al, 0x61 ;a
    jl getChar
    cmp al, 0x7a ;z
    jg getChar
    stosb
    printCharAtCoord [charCoord], dl, al, whiteColor
    add dl, 3
    loop getChar
    jmp .end

  .backspace:
    cmp dl, 14     ; Se for o primeiro caractere, não faz nada
    je getChar
    sub dl, 3        ; Decrementa o valor de dl para sobrescrever o caractere anterior
    mov al, ' '
    printCharAtCoord [charCoord], dl, al, whiteColor
    inc ecx       ; Incrementa o valor de ecx para não contabilizar o caractere apagado
    dec edi       ; Decrementa o valor de edi para sobrescrever o caractere anterior
    jmp getChar
  
  .end:
    mov ah, 0x00
    int 16h
    cmp al, 0x08 ;backspace
    je .backspace
    cmp al, 0x0d ;enter
    jne .end

    mov al, 0 ; Finaliza a string
    stosb
  ret

;-------------------------- DESENHA QUADRADO VERDE NO LOCAL INDICADO
greenSquare:
  mov ax, lightGreenColor
  mov ah, 0x0c
  drawSquare ax, cx, dx, 15
  add bx, 23
  sub dx, 15    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;-------------------------- DESENHA QUADRADO VERMELHO NO LOCAL INDICADO
redSquare:
  mov ax, lightRedColor
  mov ah, 0x0c
  drawSquare ax, cx, dx, 15
  add bx, 23
  sub dx, 15    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;-------------------------- DESENHA QUADRADO AMARELO NO LOCAL INDICADO
yellowSquare:
  mov ax, yellowColor
  mov ah, 0x0c
  drawSquare ax, cx, dx, 15
  add bx, 23
  sub dx, 15    ; restaura o valor de dx
  mov cx, bx    ; incrementa o valor de cx para o próximo quadrado
  ret

;-------------------------- CHECA SE LETRA ESTÁ NA PALAVRA SECRETA
checkChar:
  ; o caractere a ser checado está em al
  mov edi, SECRET_WORD
  cmp al, byte [edi]
  je .exists1
  jne .doesNotExist1

  .exists1:
    cmp byte [correct1], 1
    je .doesNotExist1
    mov ax, 2
    ret

  .doesNotExist1:
    cmp ax, 2
    je .end
    cmp al, byte [edi + 1]
    je .exists2
    jne .doesNotExist2

  .exists2:
    cmp byte [correct2], 1
    je .doesNotExist2
    mov ax, 2
    ret
  
  .doesNotExist2:
    cmp ax, 2
    je .end
    cmp al, byte [edi + 2]
    je .exists3
    jne .doesNotExist3

  .exists3:
    cmp byte [correct3], 1
    je .doesNotExist3
    mov ax, 2
    ret
  
  .doesNotExist3:
    cmp ax, 2
    je .end
    cmp al, byte [edi + 3]
    je .exists4
    jne .doesNotExist4

  .exists4:
    cmp byte [correct4], 1
    je .doesNotExist4
    mov ax, 2
    ret

  .doesNotExist4:
    cmp ax, 2
    je .end
    cmp al, byte [edi + 4]
    je .exists5
    jne .end

  .exists5:
    cmp byte [correct5], 1
    je .end
    mov ax, 2
    ret

  .end:
    ret

;-------------------------- ATRIBUI LETRAS CERTAS E ERRADAS
setCorrectLetters:
  mov esi, CURRENT_TRY
  mov edi, SECRET_WORD
  
  .char1:
    xor eax, eax
    lodsb            ; Carrega o caractere da tentativa atual em al e incrementa esi
    cmp al, byte [edi]  ; Compara com o caractere da palavra secreta
    je .callRightChar1
    jne .callWrongChar1

    .callRightChar1:
      mov byte [correct1], 1
      jmp .char2

    .callWrongChar1:
      mov byte [correct1], 0

  .char2:
    mov esi, CURRENT_TRY + 1
    mov edi, SECRET_WORD + 1
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar2
    jne .callWrongChar2

    .callRightChar2:
      mov byte [correct2], 1
      jmp .char3

    .callWrongChar2:
      mov byte [correct2], 0

  .char3:
    mov esi, CURRENT_TRY + 2
    mov edi, SECRET_WORD + 2
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar3
    jne .callWrongChar3

    .callRightChar3:
      mov byte [correct3], 1
      jmp .char4
    
    .callWrongChar3:
      mov byte [correct3], 0

  .char4:
    mov esi, CURRENT_TRY + 3
    mov edi, SECRET_WORD + 3
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar4
    jne .callWrongChar4

    .callRightChar4:
      mov byte [correct4], 1
      jmp .char5
    
    .callWrongChar4:
      mov byte [correct4], 0

  .char5:
    mov esi, CURRENT_TRY + 4
    mov edi, SECRET_WORD + 4
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar5
    jne .callWrongChar5

    .callRightChar5:
      mov byte [correct5], 1
      jmp .end
    
    .callWrongChar5:
      mov byte [correct5], 0

  .end:
  ret

;-------------------------- CHECA LETRAS E DESENHA QUADRADOS DE ACORDO
checkWord:
  call setCorrectLetters ; Atribui 1 para as letras certas e 0 para as erradas
  mov esi, CURRENT_TRY
  mov edi, SECRET_WORD
  
  .char1:
    lodsb            ; Carrega o caractere da tentativa atual em al e incrementa esi
    cmp byte [correct1], 1
    je .callRightChar1
    jne .callWrongChar1

    .callRightChar1:
      call greenSquare
      jmp .char2

    .callWrongChar1:
      call checkChar ; já sei que é errado, então só preciso saber se é amarelo ou vermelho
      cmp ax, 2
      je .drawYellowSquare1
      jne .drawRedSquare1

      .drawYellowSquare1:
        call yellowSquare
        jmp .char2

      .drawRedSquare1:
        call redSquare
        jmp .char2

  .char2:
    mov esi, CURRENT_TRY + 1
    lodsb
    cmp byte [correct2], 1
    je .callRightChar2
    jne .callWrongChar2

    .callRightChar2:
      call greenSquare
      jmp .char3
        
    .callWrongChar2:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare2
      jne .drawRedSquare2

      .drawYellowSquare2:
        call yellowSquare
        jmp .char3

      .drawRedSquare2:
        call redSquare
        jmp .char3

  .char3:
    mov esi, CURRENT_TRY + 2
    lodsb
    cmp byte [correct3], 1
    je .callRightChar3
    jne .callWrongChar3

    .callRightChar3:
      call greenSquare
      jmp .char4
        
    .callWrongChar3:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare3
      jne .drawRedSquare3

      .drawYellowSquare3:
        call yellowSquare
        jmp .char4
      
      .drawRedSquare3:
        call redSquare
        jmp .char4

  .char4:
    mov esi, CURRENT_TRY + 3
    lodsb
    cmp byte [correct4], 1
    je .callRightChar4
    jne .callWrongChar4

    .callRightChar4:
      call greenSquare
      jmp .char5

    .callWrongChar4:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare4
      jne .drawRedSquare4

      .drawYellowSquare4:
        call yellowSquare
        jmp .char5
      
      .drawRedSquare4:
        call redSquare
        jmp .char5

  .char5:
    mov esi, CURRENT_TRY + 4
    lodsb
    cmp byte [correct5], 1
    je .callRightChar5
    jne .callWrongChar5

    .callRightChar5:
      call greenSquare
      jmp .end

    .callWrongChar5:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare5
      jne .drawRedSquare5

      .drawYellowSquare5:
        call yellowSquare
        jmp .end
      
      .drawRedSquare5:
        call redSquare
        jmp .end

  .end:
    mov cx, 5
    mov esi, CURRENT_TRY
    mov dl, 14
    .printCurrentTry:
      lodsb
      printCharAtCoord [charCoord], dl, al, whiteColor
      add dl, 3
      loop .printCurrentTry
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
  mov byte [charCoord], 0
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

  cmp byte [numTries], 5
  je .sixthLine

  .firstLine:
    mov cx, 110 ; Posição x inicial da primeira linha
    mov dx, 10  ; Posição y inicial da primeira linha
    call checkWord
    jmp .end

  .secondLine:
    mov cx, 110 ; Posição x inicial da segunda linha
    mov dx, 34  ; Posição y inicial da segunda linha
    call checkWord
    jmp .end

  .thirdLine:
    mov cx, 110 ; Posição x inicial da terceira linha
    mov dx, 58  ; Posição y inicial da terceira linha
    call checkWord
    jmp .end
  
  .fourthLine:
    mov cx, 110 ; Posição x inicial da quarta linha
    mov dx, 82  ; Posição y inicial da quarta linha
    call checkWord
    jmp .end

  .fifthLine:
    mov cx, 110 ; Posição x inicial da quinta linha
    mov dx, 106 ; Posição y inicial da quinta linha
    call checkWord
    jmp .end

  .sixthLine:
    mov cx, 110 ; Posição x inicial da sexta linha
    mov dx, 130 ; Posição y inicial da sexta linha
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