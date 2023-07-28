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

  word0: db 'apple', '$'
  word1: db 'beach', '$'
  word2: db 'candy', '$'
  word3: db 'daisy', '$'
  word4: db 'eagle', '$'
  word5: db 'rural', '$'
  ;"fairy", "grape", "honey", "image", "jelly", "kings", "lemon", "magic", "noble", "oasis", "peace", "quilt", "river", "sunny", "teeth", "unity", "vivid", "waste", "xerox", "yacht"

  numTries: db 0
  
  correct1: db 0
  correct2: db 0
  correct3: db 0
  correct4: db 0
  correct5: db 0
