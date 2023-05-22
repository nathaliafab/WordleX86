ORG 0x7E00
jmp 0x0000:start

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

%macro setText 4
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3
	mov bx, %4
	call printf_color
%endmacro

%macro setTitle 3
	mov ah, 02h  ; Setando o cursor
	mov bh, 0    ; Página 0
	mov dh, %1   ; Linha (x)
	mov dl, %2   ; Coluna (y)
	int 10h
	mov si, %3   ; String
	call printf_color_title
%endmacro

%macro simplePrintf 2
	mov si, %1
	mov bx, %2
	call printf_color
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

;========================= GAME =========================
start:
  call clean_regs
	call initVideo
	setTitle 0, 0, GAME_START_STR
  call waitEnter
  call clearScreen
  call initGame
  ;call gameLoop
  ;call endGame
  jmp $

;========================= FUNÇÕES =========================
;------------------------- LIMPA REGISTRADORES
clean_regs:
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

;------------------------- PRINTA STRING COM COR ESPECIFICADA EM BX
printf_color:
	loop_print_string:
		lodsb
		cmp al, '$'
		je end_print_string
		mov ah,0eh
		int 10h
		jmp loop_print_string
	end_print_string:
ret

;------------------------- PRINTA TITULO COM CORES PREDEFINIDAS
printf_color_title:
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
      jmp print_char
    go_lightgreen:
      mov bx, lightGreenColor
      jmp print_char
    go_lightred:
      mov bx, lightRedColor
      jmp print_char
    go_green:
      mov bx, greenColor
      jmp print_char
    go_yellow:
      mov bx, yellowColor
      jmp print_char
    go_red:
      mov bx, redColor
      jmp print_char
    go_lightblue:
      mov bx, lightBlueColor
      jmp print_char
    go_lightcyan:
      mov bx, lightCyanColor
      jmp print_char

	loop_print_title:
		lodsb
		cmp al, '$'
		je end_print_title
		jmp change_color
    print_char:
      mov ah,0eh
      int 10h
      jmp loop_print_title
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

;------------------------- INICIALIZA O JOGO
initGame:
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 50
  drawFiveSquares lightGrayColor, greenColor, lightGrayColor, greenColor, lightGrayColor, 100, 80
  drawFiveSquares lightGrayColor, lightGrayColor, yellowColor, lightGrayColor, lightGrayColor, 100, 110
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 140
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 100, 170

  call gameLoop
  ret

;------------------------- JOGO RODANDO
gameLoop:
  ;tentativa do player ;)
  ;mudar cor dos quadrados de acordo com a tentativa
  ;checar se a tentativa é igual a palavra secreta
  ;se for, mensagem de parabéns
  ;se não for, checar se o player perdeu
  ;se perdeu, mensagem de game over
  ;se não perdeu, faz outra tentativa na próxima linha

  ret

;------------------------- FINALIZA O JOGO
;endGame:

;========================= DADOS =========================
data:
  GAME_START_STR  db '  ',0ah,0dh
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