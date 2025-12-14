using System;
using System.Collections.Generic;
using System.Linq;
using static System.Net.Mime.MediaTypeNames;

namespace Assembler
{ 
    public class HackTranslator
    {
        private static readonly Dictionary<string, string> JumpInstructions = new()
        {
            { "", "000" },
            { "JGT", "001" },
            { "JEQ", "010" },
            { "JGE", "011" },
            { "JLT", "100" },
            { "JNE", "101" },
            { "JLE", "110" },
            { "JMP", "111" }
        };

        private static readonly Dictionary<string, string> CompInstructions = new()
        {
            { "0", "0101010" },
            { "1", "0111111" },
            { "-1", "0111010" },
            { "D", "0001100" },
            { "A", "0110000" },
            { "!D", "0001101" },
            { "!A", "0110001" },
            { "-D", "0001111" },
            { "-A", "0110011" },
            { "D+1", "0011111" },
            { "A+1", "0110111" },
            { "D-1", "0001110" },
            { "A-1", "0110010" },
            { "D+A", "0000010" },
            { "D-A", "0010011" },
            { "A-D", "0000111" },
            { "D&A", "0000000" },
            { "D|A", "0010101" },
            { "M", "1110000" },
            { "!M", "1110001" },
            { "-M", "1110011" },
            { "M+1", "1110111" },
            { "M-1", "1110010" },
            { "D+M", "1000010" },
            { "D-M", "1010011" },
            { "M-D", "1000111" },
            { "D&M", "1000000" },
            { "D|M", "1010101" }
        };

        private static readonly Dictionary<string, string> DestInstructions = new()
        {
            { "", "000" },
            { "M", "001" },
            { "D", "010" },
            { "MD", "011" },
            { "A", "100" },
            { "AM", "101" },
            { "AD", "110" },
            { "AMD", "111" }
        };
        private int NextVariable = 16;
        /// <summary>
        /// Транслирует инструкции ассемблерного кода (без меток) в бинарное представление.
        /// </summary>
        /// <param name="instructions">Ассемблерный код без меток</param>
        /// <param name="symbolTable">Таблица символов</param>
        /// <returns>Строки инструкций в бинарном формате</returns>
        /// <exception cref="FormatException">Ошибка трансляции</exception>
        public string[] TranslateAsmToHack(string[] instructions, Dictionary<string, int> symbolTable)
        {
            //смотрим наличие @ в начале строки и вызываем метод для соответствующего типа команды
            var commandList = new List<string>();
            for (var i = 0; i < instructions.Length; i++)
            {
                var instruction = instructions[i];
                if (instruction[0] == '@')
                    commandList.Add(AInstructionToCode(instruction, symbolTable));
                else commandList.Add(CInstructionToCode(instruction));
            }
            return commandList.ToArray();
        }

        /// <summary>
        /// Транслирует одну A-инструкцию ассемблерного кода в бинарное представление
        /// </summary>
        /// <param name="aInstruction">Ассемблерная A-инструкция, например, @42 или @SCREEN</param>
        /// <param name="symbolTable">Таблица символов</param>
        /// <returns>Строка, содержащее нули и единицы — бинарное представление ассемблерной инструкции, например, "0000000000000101"</returns>
        public string AInstructionToCode(string aInstruction, Dictionary<string, int> symbolTable)
        {
            var register = aInstruction[1..];
            //сначала проверяем встречали ли мы такую метку раньше, если встречали, то возвращаем её бинарное представление
            //если мы не встречали такую метку, то проверяем, является ли значение команды числом, если является, то возвращаем его бинарное представление
            //иначе перед нами строка вида @ТЕКСТ, т.е. переменная. Тогда возвращаем бинарное представление номера строки, на которой мы находимся, а также добавляем переменную в dict
            if (symbolTable.TryGetValue(register, out var lineNumber))
                return Convert.ToString(lineNumber, 2).PadLeft(16, '0');
            if (int.TryParse(register, out var number))
                return Convert.ToString(number, 2).PadLeft(16, '0');
            symbolTable[register] = NextVariable++;
            return Convert.ToString(symbolTable[register], 2).PadLeft(16, '0');
        }

        /// <summary>
        /// Транслирует одну C-инструкцию ассемблерного кода в бинарное представление
        /// </summary>
        /// <param name="cInstruction">Ассемблерная C-инструкция, например, A=D+M</param>
        /// <returns>Строка, содержащее нули и единицы — бинарное представление ассемблерной инструкции, например, "1111000010100000"</returns>
        public string CInstructionToCode(string cInstruction)
        {
            var comp = "";
            var dest = "";
            var jump = "";

            if (cInstruction.Contains('='))
            {
                var parts = cInstruction.Split('=');
                dest = parts[0];
                cInstruction = parts[1];
            }

            if (cInstruction.Contains(';'))
            {
                var parts = cInstruction.Split(';');
                comp = parts[0];
                jump = parts[1];
            }
            else
                comp = cInstruction;

            return "111" + CompInstructions[comp] + DestInstructions[dest] + JumpInstructions[jump];
        }
    }
}
