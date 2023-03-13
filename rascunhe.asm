%macro drawSquare 4
    mov ah, 0xch
    mov al, %1      ;Cor
    mov bh, 0       ;Página 0
    mov cx, %2      ;Coordenada X
    mov dx, %3      ;Coordenada Y
    mov si, %4      ;Tamanho
    mov di, si
    add di, dx      ;di = tamanho + y
    add si, cx      ;si = tamanho + x

    call draw_square
%endmacro

draw_square:
    draw_row:
        int 10h
        inc cx
        cmp cx, si
        jne draw_row    ;Desenha a linha até que x = tamanho + x
        jmp draw_col
    
    draw_col:
        inc dx
        cmp dx, di    ;Desenha a coluna até que y = tamanho + y
        jne draw_col
    ret

tentativa_vazia:
    drawSquare lightgray, 0, 0, 0
    drawSquare lightgray, 0, 0, 0
    drawSquare lightgray, 0, 0, 0
    drawSquare lightgray, 0, 0, 0
    drawSquare lightgray, 0, 0, 0
    ret

%macro letraCerta 2
    mov ax, %1  ;número da letra
    mov bx, %2  ;tentativa
    ;ajeitar ax e bx na tela
    drawSquare greenColor, ax, bx, 0
%endmacro
