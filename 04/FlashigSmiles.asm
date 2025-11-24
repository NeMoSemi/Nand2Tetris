//запишем некоторые константы и переменные(для читабельности кода)
(INIT)
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

    //создадим "массив", где будут лежать значения строк для смайла
    @7224
    D = A
    @smilearray
    M = D
    A = A + 1
    M = D
    A = A + 1
    M = D
    A = A + 1
    M = 0
    A = A + 1
    M = 0
    //теперь запишем следующий индекс в переменную, чтобы взять следующее значение строки
    D = A + 1
    @currentindex
    M = D
    //значение  6 строки
    @24582
    D = A
    @currentindex
    A = M
    M = D
    //сместим currentindex в 7 строку
    @currentindex
    M = M + 1
    //значение  7 строки
    @14364
    D = A
    @currentindex
    A = M
    M = D
    //сместим currentindex в 8 строку
    @currentindex
    M = M + 1
    //значение 8 строки
    @4080
    D = A
    @currentindex
    A = M
    M = D
    //в 9 строку поставим 1 как флаг выхода из уикла отрисовки
    @currentindex
    M = M + 1
    A = M
    M = 1

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

    //проверяем нажата ли какая-то из "смещающих" кнопок, если нажата - ставим startindex в соответствующую позицию и отрисовываем смайл
    //left
    @leftoffset
    D = M
    @startindex
    M = D
    @KBD
    D = M
    @keyleft
    D = D - M
    @DRAWSMILE
    D;JEQ

    //up
    @upoffset
    D = M
    @startindex
    M = D
    @KBD
    D = M
    @keyup
    D = D - M
    @DRAWSMILE
    D;JEQ

    //right
    @rightoffset
    D = M
    @startindex
    M = D
    @KBD
    D = M
    @keyright
    D = D - M
    @DRAWSMILE
    D;JEQ

    //down
    @downoffset
    D = M
    @startindex
    M = D
    @KBD
    D = M
    @keydown
    D = D - M
    @DRAWSMILE
    D;JEQ

    @MAINLOOP
    0;JMP

(DRAWSMILE)
    //сбрасываем currentindex на начало массива смайла
    @smilearray
    D = M
    @currentindex
    M = D
    @DRAWLOOP
    0;JMP

(DRAWLOOP)
    //берём текущую строку из массива
    @currentindex
    A = M
    D = M

    //если строка == 1 значит мы достигли кона массива, возвращаемся в MAINLOOP
    @MAINLOOP
    D;JEQ

    //пишем строку в экран по startindex
    @startindex
    A = M
    M = D

    //переходим к следующей строке массива
    @currentindex
    M = M + 1

    //возвращаемся в начало цикла
    @DRAWLOOP
    0;JMP
