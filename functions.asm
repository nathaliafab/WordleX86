;================================================ PRINTS ================================================
%macro putcharAtCoord 4
  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, %1   ; Linha (x)
  mov dl, %2   ; Coluna (y)
  int 10h
  mov al, %3   ; Caractere
  mov bl, %4   ; Cor do char
  call putchar
%endmacro

%macro printString 4
  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, %1   ; Linha (x)
  mov dl, %2   ; Coluna (y)
  int 10h
  mov si, %3  ; String
  mov bx, %4  ; Cor
  call print_string
%endmacro

%macro printTitle 3
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3   ; String
	call print_title
%endmacro

%macro printEnd 3
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3   ; String
	call print_end
%endmacro

;------------------------- PRINTA CARACTERE EM AL
putchar:
  mov ah, 0eh
  int 10h
  ret

;------------------------- PRINTA STRING COM COR ESPECIFICADA EM BX
print_string:
	.loop_ps:
		lodsb
		test al, al ; verifica se chegou no fim da string
		jz .end
		call putchar
		jmp .loop_ps
	.end:
  ret

;------------------------- PRINTA TÍTULO COM CORES PREDEFINIDAS
print_title:
  .change_color:
    cmp al, 0x3d ;=
    je .set_lightgreen
    cmp al, 0x2d ;-
    je .set_lightblue
    cmp al, 0x3c ;<
    je .set_lightblue
    cmp al, 0x3e ;>
    je .set_lightblue
    cmp al, 0x7c ;|
    je .set_lightgreen
    cmp al, 0x57 ;W
    je .set_green
    cmp al, 0x4f ;O
    je .set_red
    cmp al, 0x52 ;R
    je .set_yellow
    cmp al, 0x44 ;D
    je .set_red
    cmp al, 0x4c ;L
    je .set_yellow
    cmp al, 0x45 ;E
    je .set_green
    cmp al, 0x78 ;x
    je .set_red
    cmp al, 0x38 ;8
    je .set_green
    cmp al, 0x36 ;6
    je .set_red
    cmp al, 0x28 ;(
    je .set_magenta
    cmp al, 0x29 ;)
    je .set_magenta
    cmp al, 0x2f ;/
    je .set_magenta
    cmp al, 0x5f ;_
    je .set_magenta
    cmp al, 0x70 ;p
    je .set_lightcyan
    cmp al, 0x72 ;r
    je .set_lightcyan
    cmp al, 0x65 ;e
    je .set_lightcyan
    cmp al, 0x73 ;s
    je .set_lightcyan
    cmp al, 0x6e ;n
    je .set_lightcyan
    cmp al, 0x74 ;t
    je .set_lightcyan
    cmp al, 0x6f ;o
    je .set_lightcyan
    cmp al, 0x61 ;a
    je .set_lightcyan
    cmp al, 0x40 ;@
    je .set_lightgreen
    jmp .set_lightred

    .set_magenta:
      mov bx, magentaColor
      call putchar
      jmp .loop_print_msg
    .set_lightgreen:
      mov bx, lightGreenColor
      call putchar
      jmp .loop_print_msg
    .set_lightred:
      mov bx, lightRedColor
      call putchar
      jmp .loop_print_msg
    .set_green:
      mov bx, greenColor
      call putchar
      jmp .loop_print_msg
    .set_yellow:
      mov bx, yellowColor
      call putchar
      jmp .loop_print_msg
    .set_red:
      mov bx, redColor
      call putchar
      jmp .loop_print_msg
    .set_lightblue:
      mov bx, lightBlueColor
      call putchar
      jmp .loop_print_msg
    .set_lightcyan:
      mov bx, lightCyanColor
      call putchar
      jmp .loop_print_msg

	.loop_print_msg:
		lodsb
		test al, al
		jz .end_print
		jmp .change_color

	.end_print:
  ret

;------------------------- PRINTA WIN/LOSE COM CORES PREDEFINIDAS
print_end:
  .change_color:
    ;;========================= WORDLE x86
    cmp al, 0x57 ;W
    je .set_green
    cmp al, 0x4f ;O
    je .set_red
    cmp al, 0x52 ;R
    je .set_yellow
    cmp al, 0x44 ;D
    je .set_red
    cmp al, 0x4c ;L
    je .set_yellow
    cmp al, 0x45 ;E
    je .set_green
    cmp al, 0x78 ;x
    je .set_red
    cmp al, 0x38 ;8
    je .set_green
    cmp al, 0x36 ;6
    je .set_red
    ;;========================= PARÊNTESES E AFINS
    cmp al, 0x28 ;(
    je .set_magenta
    cmp al, 0x29 ;)
    je .set_magenta
    cmp al, 0x2f ;/
    je .set_magenta
    cmp al, 0x5f ;_
    je .set_magenta
    cmp al, 0x3d ;=
    je .set_lightgreen
    cmp al, 0x2d ;-
    je .set_lightblue
    cmp al, 0x3c ;<
    je .set_lightblue
    cmp al, 0x3e ;>
    je .set_lightblue
    cmp al, 0x7c ;|
    je .set_lightgreen
    cmp al, 0x40 ;@
    je .set_lightgreen
    ;;========================= press enter to play again
    cmp al, 0x70 ;p
    je .set_lightcyan
    cmp al, 0x72 ;r
    je .set_lightcyan
    cmp al, 0x65 ;e
    je .set_lightcyan
    cmp al, 0x73 ;s
    je .set_lightcyan
    cmp al, 0x6e ;n
    je .set_lightcyan
    cmp al, 0x74 ;t
    je .set_lightcyan
    cmp al, 0x6f ;o
    je .set_lightcyan
    cmp al, 0x61 ;a
    je .set_lightcyan
    ;;========================= CONGRATULATIONS
    cmp al, 0x43 ;C
    je .set_lightblue
    cmp al, 0x47 ;G
    je .set_lightblue
    cmp al, 0x41 ;A
    je .set_lightblue
    cmp al, 0x54 ;T
    je .set_lightblue
    cmp al, 0x55 ;U
    je .set_lightblue
    cmp al, 0x49 ;I
    je .set_lightblue
    cmp al, 0x4e ;N
    je .set_lightblue
    cmp al, 0x53 ;S
    je .set_lightblue
    ;;========================= YOU WIN
    cmp al, 0x59 ;Y
    je .set_lightcyan

    jmp .set_cyan

    .set_magenta:
      mov bx, magentaColor
      call putchar
      jmp .loop_print_msg
    .set_lightgreen:
      mov bx, lightGreenColor
      call putchar
      jmp .loop_print_msg
    .set_cyan:
      mov bx, cyanColor
      call putchar
      jmp .loop_print_msg
    .set_green:
      mov bx, greenColor
      call putchar
      jmp .loop_print_msg
    .set_yellow:
      mov bx, yellowColor
      call putchar
      jmp .loop_print_msg
    .set_red:
      mov bx, redColor
      call putchar
      jmp .loop_print_msg
    .set_lightblue:
      mov bx, lightBlueColor
      call putchar
      jmp .loop_print_msg
    .set_lightcyan:
      mov bx, lightCyanColor
      call putchar
      jmp .loop_print_msg

	.loop_print_msg:
		lodsb
		test al, al
		jz .end_print
		jmp .change_color

	.end_print:
  ret

;------------------------- PRINTA KEYBOARD EMBAIXO DA TELA COM CORES PREDEFINIDAS
print_kr:
  .loop_ps:
    cmp byte[di], 0
    je .set_n_pressed
    cmp byte[di], 1
    je .set_incorrect
    cmp byte[di], 2
    je .set_misplaced
    cmp byte[di], 3
    je .set_correct

    .set_n_pressed:
      mov bx, darkGrayColor
      jmp .print_key
    
    .set_incorrect:
      mov bx, lightRedColor
      jmp .print_key
    
    .set_misplaced:
      mov bx, yellowColor
      jmp .print_key
    
    .set_correct:
      mov bx, lightGreenColor
    
    .print_key:
      lodsb
      call putchar
      inc di
      loop .loop_ps
  ret

printKeyboard:
  mov di, KEYBOARD_STATUS
  
  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, 20
  mov dl, 15
  int 10h
  mov si, KEYBOARD_KEYS1
  mov cx, 10
  call print_kr

  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, 21
  mov dl, 16
  int 10h
  mov si, KEYBOARD_KEYS2
  mov cx, 9
  call print_kr

  mov ah, 02h  ; Setando o cursor
  mov bh, 0    ; Página 0
  mov dh, 22
  mov dl, 17
  int 10h
  mov si, KEYBOARD_KEYS3
  mov cx, 7
  call print_kr

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

;------------------------- RESETA DADOS DA MEMÓRIA PARA NOVO JOGO
resetGameData:
  push di
  push cx
  push ax

  ; 1. Limpa o array de status do teclado (enche de 0)
  mov di, KEYBOARD_STATUS
  mov cx, 26            ; 26 letras no alfabeto
  xor al, al            ; al = 0
  rep stosb             ; repete 'mov [di], al' cx vezes

  ; 2. Limpa as flags de acerto (para não começar ganhando)
  mov byte [CORRECT_1], 0
  mov byte [CORRECT_2], 0
  mov byte [CORRECT_3], 0
  mov byte [CORRECT_4], 0
  mov byte [CORRECT_5], 0

  ; 3. Limpa a palavra secreta antiga
  mov di, SECRET_WORD
  mov cx, 6
  xor al, al
  rep stosb

  pop ax
  pop cx
  pop di
  ret

;================================================ PALAVRA SECRETA ================================================
;-------------------------- RANDOMIZA A PALAVRA SECRETA
randGen:
  rdtsc               ; Lê o contador de tempo do processador em EDX:EAX
  xor edx, edx        ; Limpa EDX para preparar para a divisão (EDX:EAX / ECX)
  mov ecx, NUM_WORDS  ; ECX = Número total de palavras
  div ecx              ; Divide EDX:EAX por ECX. O resto fica em EDX
  mov eax, edx         ; O resto da divisão é nosso número aleatório
  ret

;-------------------------- SETA A PALAVRA SECRETA
setSecretWord:
  call randGen

  mov cx, 6
  mul cx             ; Multiplica AX por 6. Resultado (offset) fica em AX.
                     ; (Cada palavra tem 5 letras + 1 null terminator = 6 bytes)

  mov si, WORDS      ; Carrega o endereço base da lista de palavras em SI
  add si, ax         ; Soma o offset calculado (Index * 6)
                     ; Agora SI aponta exatamente para a palavra sorteada

  mov di, SECRET_WORD ; DI aponta para onde vamos copiar a palavra
  
  mov cx, 6           ; Vamos copiar 6 bytes
  cld                 ; Garante que a cópia vá para frente
  rep movsb           ; Copia byte a byte de [SI] para [DI]
  ret

;================================================ TENATIVAS ================================================
;-------------------------- CALCULA A COORDENADA DO CARACTERE
calcCharCoord:
  cmp byte[NUM_TRIES], 0
  je .firstTry
  cmp byte[NUM_TRIES], 1
  je .secondTry
  cmp byte[NUM_TRIES], 2
  je .thirdTry
  cmp byte[NUM_TRIES], 3
  je .fourthTry
  cmp byte[NUM_TRIES], 4
  je .fifthTry
  cmp byte[NUM_TRIES], 5
  je .sixthTry

  .firstTry:
    mov byte[CHAR_COORD], 2
    jmp .end
  
  .secondTry:
    mov byte[CHAR_COORD], 5
    jmp .end

  .thirdTry:
    mov byte[CHAR_COORD], 8
    jmp .end
  
  .fourthTry:
    mov byte[CHAR_COORD], 11
    jmp .end
  
  .fifthTry:
    mov byte[CHAR_COORD], 14
    jmp .end

  .sixthTry:
    mov byte[CHAR_COORD], 17
  
  .end:
    ret

;-------------------------- JOGADOR TENTA ADIVINHAR A PALAVRA SECRETA
playerTry:
  mov ecx, 5          ; Tamanho da palavra secreta
  mov dl, 14           ; Posição inicial da string da tentativa atual
  mov edi, CURRENT_TRY ; Endereço da string da tentativa atual

  call calcCharCoord

  getchar:
    mov ah, 0x00
    int 16h
    cmp al, 0x08 ;backspace
    je .backspace
    cmp al, 0x61 ;a
    jl getchar
    cmp al, 0x7a ;z
    jg getchar
    stosb
    putcharAtCoord [CHAR_COORD], dl, al, whiteColor
    add dl, 3
    loop getchar
    jmp .end

  .backspace:
    cmp dl, 14     ; Se for o primeiro caractere, não faz nada
    je getchar
    sub dl, 3        ; Decrementa o valor de dl para sobrescrever o caractere anterior
    mov al, ' '
    putcharAtCoord [CHAR_COORD], dl, al, whiteColor
    inc ecx       ; Incrementa o valor de ecx para não contabilizar o caractere apagado
    dec edi       ; Decrementa o valor de edi para sobrescrever o caractere anterior
    jmp getchar
  
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

;-------------------------- ATUALIZA STATUS DO TECLADO
; Input: AL = caractere, BL = novo status
updateKeyStatus:
  push ax
  push bx
  push cx
  push dx     ; <--- Salva Y
  push di
  push si
  
  ; Vamos usar o segmento DS padrão, mas forçamos a direção forward
  cld 

  mov dl, al  ; Salva a letra alvo em DL

  ; --- Varre Linha 1 (QWERTY) ---
  mov si, KEYBOARD_KEYS1
  mov di, KEYBOARD_STATUS 
  .scan1:
    lodsb           
    cmp al, 0       
    je .check_row2
    cmp al, dl      
    je .found
    inc di          
    jmp .scan1

    ; --- Varre Linha 2 (ASDFG) ---
  .check_row2:
    mov si, KEYBOARD_KEYS2
  .scan2:
    lodsb
    cmp al, 0
    je .check_row3
    cmp al, dl
    je .found
    inc di
    jmp .scan2

    ; --- Varre Linha 3 (ZXCV) ---
  .check_row3:
    mov si, KEYBOARD_KEYS3
  .scan3:
    lodsb
    cmp al, 0
    je .not_found 
    cmp al, dl
    je .found
    inc di
    jmp .scan3

  .found:
    mov al, [di]  ; Pega status atual
    
    cmp al, 3              ; Se já é verde...
    je .not_found          ; Sai
    
    cmp bl, 3              ; Novo é verde?
    je .force_update       ; Atualiza
    
    cmp al, 2              ; Se já é amarelo...
    je .not_found          ; Sai

  .force_update:
    mov [di], bl

  .not_found:
    pop si
    pop di
    pop dx     ; <--- Restaura Y
    pop cx
    pop bx
    pop ax
    ret

;-------------------------- DESENHA QUADRADOS
greenSquare:
  push ax
  mov bl, 3
  call updateKeyStatus
  pop ax
  mov ax, lightGreenColor
  mov ah, 0x0c
  call draw_next_sq
  ret

redSquare:
  push ax
  mov bl, 1
  call updateKeyStatus
  pop ax
  mov ax, lightRedColor
  mov ah, 0x0c
  call draw_next_sq
  ret

yellowSquare:
  push ax
  mov bl, 2
  call updateKeyStatus
  pop ax
  mov ax, yellowColor
  mov ah, 0x0c
  call draw_next_sq
  ret

;-------------------------- CHECA SE LETRA ESTÁ NA PALAVRA SECRETA
checkChar:
  ; o caractere a ser checado está em al
  mov edi, SECRET_WORD
  cmp al, byte [edi]
  je .exists1
  jne .doesNotExist1

  .exists1:
    cmp byte [CORRECT_1], 1
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
    cmp byte [CORRECT_2], 1
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
    cmp byte [CORRECT_3], 1
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
    cmp byte [CORRECT_4], 1
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
    cmp byte [CORRECT_5], 1
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
      mov byte [CORRECT_1], 1
      jmp .char2

    .callWrongChar1:
      mov byte [CORRECT_1], 0

  .char2:
    mov esi, CURRENT_TRY + 1
    mov edi, SECRET_WORD + 1
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar2
    jne .callWrongChar2

    .callRightChar2:
      mov byte [CORRECT_2], 1
      jmp .char3

    .callWrongChar2:
      mov byte [CORRECT_2], 0

  .char3:
    mov esi, CURRENT_TRY + 2
    mov edi, SECRET_WORD + 2
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar3
    jne .callWrongChar3

    .callRightChar3:
      mov byte [CORRECT_3], 1
      jmp .char4
    
    .callWrongChar3:
      mov byte [CORRECT_3], 0

  .char4:
    mov esi, CURRENT_TRY + 3
    mov edi, SECRET_WORD + 3
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar4
    jne .callWrongChar4

    .callRightChar4:
      mov byte [CORRECT_4], 1
      jmp .char5
    
    .callWrongChar4:
      mov byte [CORRECT_4], 0

  .char5:
    mov esi, CURRENT_TRY + 4
    mov edi, SECRET_WORD + 4
    xor eax, eax
    lodsb
    cmp al, byte [edi]
    je .callRightChar5
    jne .callWrongChar5

    .callRightChar5:
      mov byte [CORRECT_5], 1
      jmp .end
    
    .callWrongChar5:
      mov byte [CORRECT_5], 0

  .end:
    ret

;-------------------------- CHECA LETRAS E DESENHA QUADRADOS DE ACORDO
checkWord:
  call setCorrectLetters 
  mov esi, CURRENT_TRY
  mov edi, SECRET_WORD
  
  ; --- CHAR 1 ---
  .char1:
    lodsb                       ; Carrega o caractere da tentativa atual em al e incrementa esi
    cmp byte [CORRECT_1], 1
    je .callRightChar1
    jne .callWrongChar1

    .callRightChar1:
      mov al, [CURRENT_TRY]     ; Recarrega letra certa
      call greenSquare
      jmp .char2

    .callWrongChar1:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare1
      jne .drawRedSquare1

      .drawYellowSquare1:
        mov al, [CURRENT_TRY]   
        call yellowSquare
        jmp .char2

      .drawRedSquare1:
        mov al, [CURRENT_TRY]   
        call redSquare
        jmp .char2

  ; --- CHAR 2 ---
  .char2:
    mov esi, CURRENT_TRY + 1
    lodsb
    cmp byte [CORRECT_2], 1
    je .callRightChar2
    jne .callWrongChar2

    .callRightChar2:
      mov al, [CURRENT_TRY + 1] 
      call greenSquare
      jmp .char3
        
    .callWrongChar2:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare2
      jne .drawRedSquare2

      .drawYellowSquare2:
        mov al, [CURRENT_TRY + 1] 
        call yellowSquare
        jmp .char3

      .drawRedSquare2:
        mov al, [CURRENT_TRY + 1] 
        call redSquare
        jmp .char3

  ; --- CHAR 3 ---
  .char3:
    mov esi, CURRENT_TRY + 2
    lodsb
    cmp byte [CORRECT_3], 1
    je .callRightChar3
    jne .callWrongChar3

    .callRightChar3:
      mov al, [CURRENT_TRY + 2] 
      call greenSquare
      jmp .char4
        
    .callWrongChar3:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare3
      jne .drawRedSquare3

      .drawYellowSquare3:
        mov al, [CURRENT_TRY + 2] 
        call yellowSquare
        jmp .char4
      
      .drawRedSquare3:
        mov al, [CURRENT_TRY + 2] 
        call redSquare
        jmp .char4

  ; --- CHAR 4 ---
  .char4:
    mov esi, CURRENT_TRY + 3
    lodsb
    cmp byte [CORRECT_4], 1
    je .callRightChar4
    jne .callWrongChar4

    .callRightChar4:
      mov al, [CURRENT_TRY + 3] 
      call greenSquare
      jmp .char5

    .callWrongChar4:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare4
      jne .drawRedSquare4

      .drawYellowSquare4:
        mov al, [CURRENT_TRY + 3] 
        call yellowSquare
        jmp .char5
      
      .drawRedSquare4:
        mov al, [CURRENT_TRY + 3] 
        call redSquare
        jmp .char5

  ; --- CHAR 5 ---
  .char5:
    mov esi, CURRENT_TRY + 4
    lodsb
    cmp byte [CORRECT_5], 1
    je .callRightChar5
    jne .callWrongChar5

    .callRightChar5:
      mov al, [CURRENT_TRY + 4] 
      call greenSquare
      jmp .end

    .callWrongChar5:
      call checkChar
      cmp ax, 2
      je .drawYellowSquare5
      jne .drawRedSquare5

      .drawYellowSquare5:
        mov al, [CURRENT_TRY + 4] 
        call yellowSquare
        jmp .end
      
      .drawRedSquare5:
        mov al, [CURRENT_TRY + 4] 
        call redSquare
        jmp .end

  .end:
    mov cx, 5
    mov esi, CURRENT_TRY
    mov dl, 14
    .printCurrentTry:
      lodsb
      putcharAtCoord [CHAR_COORD], dl, al, whiteColor
      add dl, 3
      loop .printCurrentTry
    ret

;-------------------------- INCREMENTA O NÚMERO DE TENTATIVAS
incTries:
  mov al, [NUM_TRIES]
  inc al
  mov [NUM_TRIES], al
  ret

;-------------------------- INICIALIZA O NÚMERO DE TENTATIVAS
initTries:
  mov byte [NUM_TRIES], 0
  mov byte [CHAR_COORD], 0
  ret

;-------------------------- ATUALIZA A TELA COM A TENTATIVA ATUAL
updateGame:
  cmp byte [NUM_TRIES], 0
  je .firstLine

  cmp byte [NUM_TRIES], 1
  je .secondLine

  cmp byte [NUM_TRIES], 2
  je .thirdLine

  cmp byte [NUM_TRIES], 3
  je .fourthLine

  cmp byte [NUM_TRIES], 4
  je .fifthLine

  cmp byte [NUM_TRIES], 5
  je .sixthLine

  .firstLine:
    mov cx, ROW_X
    mov dx, ROW_Y_1
    call checkWord
    jmp .end

  .secondLine:
    mov cx, ROW_X
    mov dx, ROW_Y_2
    call checkWord
    jmp .end

  .thirdLine:
    mov cx, ROW_X
    mov dx, ROW_Y_3
    call checkWord
    jmp .end
  
  .fourthLine:
    mov cx, ROW_X
    mov dx, ROW_Y_4
    call checkWord
    jmp .end

  .fifthLine:
    mov cx, ROW_X
    mov dx, ROW_Y_5
    call checkWord
    jmp .end

  .sixthLine:
    mov cx, ROW_X
    mov dx, ROW_Y_6
    call checkWord
    jmp .end

  .end:
    call printKeyboard
    ret

;================================================ CHECA SE GANHOU ================================================
;-------------------------- CHECA SE O JOGADOR GANHOU
checkWin:
  cmp byte [CORRECT_1], 1
  je .checkWin1
  jmp .endCheckWin

  .checkWin1:
    cmp byte [CORRECT_2], 1
    je .checkWin2
    jmp .endCheckWin
  
  .checkWin2:
    cmp byte [CORRECT_3], 1
    je .checkWin3
    jmp .endCheckWin

  .checkWin3:
    cmp byte [CORRECT_4], 1
    je .checkWin4
    jmp .endCheckWin

  .checkWin4:
    cmp byte [CORRECT_5], 1
    je .playerWin
    jmp .endCheckWin

  .playerWin:
    call clearScreen
    printEnd 0, 0, WINNER_MESSAGE
    printString 3, 17, SECRET_WORD, lightGreenColor
    call waitEnter
    jmp main

  .endCheckWin:
  ret