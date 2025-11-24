// Программа рисует смайл в разных позициях экрана в зависимости от нажатой клавиши-стрелки
// Логика программы:
// 1. Инициализировать константы и начальные значения
// 2. В главном цикле проверять изменение состояния клавиатуры
// 3. При изменении клавиши очищать экран
// 4. Проверять какая клавиша нажата и рисовать смайл в соответствующей позиции

// Инициализация констант для клавиш
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

// Инициализация переменных
@lastkey
M = 0
@i
M = 0

// Вычисление позиций для рисования смайла
// LEFT: 160px от левого края, 124px от верха
@SCREEN
D = A
@3978
D = D + A
@leftoffset
M = D

// UP: 256px от левого края, 82px от верха  
@SCREEN
D = A
@2640
D = D + A
@upoffset
M = D

// RIGHT: 336px от левого края, 124px от верха
@SCREEN
D = A
@3989
D = D + A
@rightoffset
M = D

// DOWN: 256px от левого края, 165px от верха
@SCREEN
D = A
@5296
D = D + A
@downoffset
M = D

// Главный цикл программы
(MAINLOOP)
    // Проверяем изменилась ли клавиша
    @lastkey
    D = M
    @KBD
    D = D - M
    @CLEARSCREEN
    D;JNE        // Если клавиша изменилась - очищаем экран
    @CHECKCURRENTBUTTON
    0;JMP        // Иначе проверяем текущую клавишу

// Проверка нажатой клавиши
(CHECKCURRENTBUTTON)
    @KBD
    D = M
    
    // Проверка LEFT
    @keyleft
    D = D - M
    @LEFTPRESSED
    D;JEQ

    // Проверка UP  
    @KBD
    D = M
    @keyup
    D = D - M
    @UPPRESSED
    D;JEQ

    // Проверка RIGHT
    @KBD
    D = M
    @keyright
    D = D - M
    @RIGHTPRESSED
    D;JEQ

    // Проверка DOWN
    @KBD
    D = M
    @keydown
    D = D - M
    @DOWNPRESSED
    D;JEQ

    // Если нажата другая клавиша - возврат в главный цикл
    @MAINLOOP
    0;JMP

// Обработчики нажатий клавиш
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

// Отрисовка смайла
(DRAWSMILE)
    // Строка 1
    @7224
    D = A
    @startindex
    A = M
    M = D

    // Переход к строке 2
    @32
    D = A
    @startindex
    M = M + D

    // Строка 2
    @7224
    D = A
    @startindex
    A = M
    M = D

    // Переход к строке 3
    @32
    D = A
    @startindex
    M = M + D

    // Строка 3
    @7224
    D = A
    @startindex
    A = M
    M = D

    // Пропуск строк 4-5, переход к строке 6
    @32
    D = A
    @startindex
    M = M + D
    M = M + D
    M = M + D

    // Строка 6
    @24582
    D = A
    @startindex
    A = M
    M = D

    // Переход к строке 7
    @32
    D = A
    @startindex
    M = M + D

    // Строка 7
    @14364
    D = A
    @startindex
    A = M
    M = D

    // Переход к строке 8
    @32
    D = A
    @startindex
    M = M + D

    // Строка 8
    @4080
    D = A
    @startindex
    A = M
    M = D

    // Возврат в главный цикл
    @MAINLOOP
    0;JMP

// Очистка экрана
(CLEARSCREEN)
    // Сохраняем текущую клавишу
    @KBD
    D = M
    @lastkey
    M = D

    // Сбрасываем счетчик
    @i
    M = 0

(CLEARLOOP)
    // Проверяем достигли ли конца экрана
    @i
    D = M
    @8192
    D = D - A
    @CHECKCURRENTBUTTON
    D;JEQ

    // Очищаем текущий пиксель
    @i
    D = M
    @SCREEN
    A = A + D
    M = 0

    // Увеличиваем счетчик
    @i
    M = M + 1

    @CLEARLOOP
    0;JMP