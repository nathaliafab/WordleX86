;================================================ DADOS ================================================
SECTION .data
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
                  db   0 ; fim da string

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
                  db   '        You rocked WORDLE x86!         ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   '      (press enter to play again)      ',0ah,0dh
                  db   '                                       ',0ah,0dh
                  db   0 ; end of string

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
                  db   0 ; end of string

  KEYBOARD_KEYS1: db 'qwertyuiop',0
  KEYBOARD_KEYS2: db 'asdfghjkl',0
  KEYBOARD_KEYS3: db 'zxcvbnm',0

  ;0: não pressionada
  ;1: pressionada e vermelho (incorreta)
  ;2: pressionada e amarelo (correta, posição errada)
  ;3: pressionada e verde (correta, posição correta)
  KEYBOARD_STATUS: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

  ROW_X equ 110
  ROW_Y_1 equ 10
  ROW_Y_2 equ 34
  ROW_Y_3 equ 58
  ROW_Y_4 equ 82
  ROW_Y_5 equ 106
  ROW_Y_6 equ 130
  
  NUM_TRIES: db 0
  CHAR_COORD: db 0
  
  ; 0 -> letra errada
  ; 1 -> letra certa, posição certa
  CORRECT_1: db 0
  CORRECT_2: db 0
  CORRECT_3: db 0
  CORRECT_4: db 0
  CORRECT_5: db 0
