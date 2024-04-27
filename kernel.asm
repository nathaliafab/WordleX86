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
  call printKeyboard
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 10
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 34
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 58
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 82
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 106
  drawFiveSquares lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, lightGrayColor, 110, 130
  ret

;------------------------- JOGO RODANDO
gameLoop:
  call playerTry
  call updateGame
  call checkWin

  call incTries
  mov cl, [numTries]
  cmp cl, 6
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