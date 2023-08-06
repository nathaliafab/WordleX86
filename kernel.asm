ORG 0x7E00
jmp 0x0000:main

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

%include "functions.asm"
%include "data.asm"
%include "words.asm"

SECTION .bss
  SECRET_WORD: resb 6 ; Aloca espaço para a palavra secreta
  CURRENT_TRY: resb 6 ; Aloca espaço para a tentativa atual

SECTION .text
  global main

;================================================ GAME ================================================
main:
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
  printGameEnd 0, 0, LOSER_MESSAGE
  printText 3, 17, SECRET_WORD, lightGreenColor
  call waitEnter
  call main
  ret