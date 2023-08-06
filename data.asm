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
                  db   '        You rocked WORDLE x86!         ',0ah,0dh
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

  words db 'amigo', '$',
        db 'ampla', '$',
        db 'bruto', '$',
        db 'campo', '$',
        db 'certo', '$',
        db 'corpo', '$',
        db 'fazer', '$',
        db 'feliz', '$',
        db 'grito', '$',
        db 'jovem', '$',
        db 'livro', '$',
        db 'lugar', '$',
        db 'rural', '$',
        db 'ufrpe', '$',
        db 'mundo', '$',
        db 'nasal', '$',
        db 'oeste', '$',
        db 'perto', '$',
        db 'abrir', '$',
        db 'bater', '$',
        db 'chefe', '$',
        db 'dente', '$',
        db 'elega', '$',
        db 'fugir', '$',
        db 'girar', '$',
        db 'haste', '$',
        db 'igual', '$',
        db 'jogar', '$',
        db 'lindo', '$',
        db 'mover', '$',
        db 'negro', '$',
        db 'odiar', '$',
        db 'poder', '$',
        db 'risco', '$',
        db 'salto', '$',
        db 'tigre', '$',
        db 'vital', '$',
        db 'zelar', '$',
        db 'doces', '$',
        db 'praia', '$',
        db 'unido', '$',
        db 'nobre', '$',
        db 'fadas', '$',
        db 'zebra', '$',
        db 'magia', '$'
  
  num_words equ ($ - words) / 6

  numTries: db 0
  
  ; 0 -> letra errada
  ; 1 -> letra certa, posição certa
  correct1: db 0
  correct2: db 0
  correct3: db 0
  correct4: db 0
  correct5: db 0
