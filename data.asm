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

  words db 'amigo', 0,
        db 'ampla', 0,
        db 'bruto', 0,
        db 'campo', 0,
        db 'certo', 0,
        db 'corpo', 0,
        db 'fazer', 0,
        db 'feliz', 0,
        db 'grito', 0,
        db 'jovem', 0,
        db 'livro', 0,
        db 'lugar', 0,
        db 'rural', 0,
        db 'ufrpe', 0,
        db 'mundo', 0,
        db 'nasal', 0,
        db 'oeste', 0,
        db 'perto', 0,
        db 'abrir', 0,
        db 'bater', 0,
        db 'chefe', 0,
        db 'dente', 0,
        db 'elega', 0,
        db 'fugir', 0,
        db 'girar', 0,
        db 'haste', 0,
        db 'igual', 0,
        db 'jogar', 0,
        db 'lindo', 0,
        db 'mover', 0,
        db 'negro', 0,
        db 'odiar', 0,
        db 'poder', 0,
        db 'risco', 0,
        db 'salto', 0,
        db 'tigre', 0,
        db 'vital', 0,
        db 'zelar', 0,
        db 'doces', 0,
        db 'praia', 0,
        db 'unido', 0,
        db 'nobre', 0,
        db 'fadas', 0,
        db 'zebra', 0,
        db 'magia', 0
  
  num_words equ ($ - words) / 6

  numTries: db 0
  
  ; 0 -> letra errada
  ; 1 -> letra certa, posição certa
  correct1: db 0
  correct2: db 0
  correct3: db 0
  correct4: db 0
  correct5: db 0
