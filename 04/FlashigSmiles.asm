//запишем некоторые константы(для читабельности кода)
(CONST)
    //номера клавиш и соответствующие им направления
    @130
    D = A
    @keyleft
    M = D

    @131
    D = A
    @keyup
    M = D

    @132
    D = A
    @keyright
    M = D

    @133
    D = A
    @keydown
    M = D

    //храним значение предыдущей нажатой клавиши
    @lastkey
    M = -1

    //начальный регистр, в который нужно сместиться при нажатии определённой клавиши, а также само смещение
    @startindex
    M = 0

    @SCREEN
    D = A
    @3978
    D = D + A
    @leftoffset
    M = D

    @SCREEN
    D = A
    @2640
    D = D + A
    @upoffset
    M = D

    @SCREEN
    D = A
    @3989
    D = D + A
    @rightoffset
    M = D

    @SCREEN
    D = A
    @5296
    D = D + A
    @downoffset
    M = D


//главный цикл программы
(MAINLOOP)
    @KBD
    D = M
    @lastkey
    D = D - M
    @CLEARSCREEN
    D;JNE           
    //если клавиша не изменилась, то остаёмся в mainloop
    @MAINLOOP
    0;JMP

//очистка экрана
(CLEARSCREEN)
    //сбрасываем индекс перед очисткой и вызывыаем (CLEARLOOP)
    @i
    M = 0
    @CLEARLOOP
    0;JMP           

(CLEARLOOP)
    @i
    D = M
    @8192
    D = D - A
    //если очистили всё(i == 8192), переходим к обработке клавиш
    @KEYPROCESSING
    D;JEQ           

    @i
    D = M
    @SCREEN
    A = D + A
    M = 0           

    //увеличиваем i
    @i
    M = M + 1
    @CLEARLOOP
    0;JMP

//обработка клавиш
(KEYPROCESSING)
    //сохраняем послденюю нажатую клавишу
    @KBD
    D = M
    @lastkey
    M = D
    //если клавиша не нажата - возвращаемся в mainloop
    @MAINLOOP
    D;JEQ                         

    //проверяем нажата ли какая-то из "смещающих" кнопок
    //left
    @KBD
    D = M
    @keyleft
    D = D - M
    @LEFTPRESSED
    D;JEQ

    //up
    @KBD
    D = M
    @keyup
    D = D - M
    @UPPRESSED
    D;JEQ

    //right
    @KBD
    D = M
    @keyright
    D = D - M
    @RIGHTPRESSED
    D;JEQ

    //down
    @KBD
    D = M
    @keydown
    D = D - M
    @DOWNPRESSED
    D;JEQ

    @MAINLOOP
    0;JMP


(LEFTPRESSED)
    @leftoffset
    D = M
    @startindex
    M = D
    @DRAWSMILE
    0;JMP

(UPPRESSED)
    @upoffset
    D = M
    @startindex
    M = D
    @DRAWSMILE
    0;JMP

(RIGHTPRESSED)
    @rightoffset
    D = M
    @startindex
    M = D
    @DRAWSMILE
    0;JMP

(DOWNPRESSED)
    @downoffset
    D = M
    @startindex
    M = D
    @DRAWSMILE
    0;JMP

(DRAWSMILE)
    //изменяем 1 строку
    @7224
    D = A
    @startindex
    A = M
    M = D

    @startindex
    D = M
    @32
    D = D + A
    @startindex
    M = D

    //2 строка
    @7224
    D = A
    @startindex
    A = M
    M = D

    @startindex
    D = M
    @32
    D = D + A
    @startindex
    M = D

    //3 строка
    @7224
    D = A
    @startindex
    A = M
    M = D

    @startindex
    D = M
    @96        //2 строки пропускаются
    D = D + A
    @startindex
    M = D

    //6 строка
    @24582
    D = A
    @startindex
    A = M
    M = D

    @startindex
    D = M
    @32
    D = D + A
    @startindex
    M = D

    //7 строка
    @14364
    D = A
    @startindex
    A = M
    M = D

    @startindex
    D = M
    @32
    D = D + A
    @startindex
    M = D

    //8 строка
    @4080
    D = A
    @startindex
    A = M
    M = D

    @MAINLOOP
    0;JMP
