

namespace Assembler
{
    public class SymbolAnalyzer
    {
        private Dictionary<string, int> GetBaseMarks()
        {
            //задаём базовые метки
            var baseMarks = new Dictionary<string, int>();
            baseMarks["SCREEN"] = 16384;
            baseMarks["KBD"] = 24576;
            baseMarks["SP"] = 0;
            baseMarks["LCL"] = 1;
            baseMarks["ARG"] = 2;
            baseMarks["THIS"] = 3;
            baseMarks["THAT"] = 4;
            for (int i = 0; i < 16; i++)
                baseMarks[$"R{i}"] = i;
            return baseMarks;
        }

        public Dictionary<string, int> CreateSymbolsTable(string[] instructionsWithLabels,
            out string[] instructionsWithoutLabels)
        {
            //получаем базовые метки
            var marksDict = GetBaseMarks();
            //создаём список, в котоом будут лежать только инструкции
            var instructionsList = new List<string>();
            var lineNumber = 0;
            
            //бежим по строкам программы и проверяем: если начинается и заканчивается на () - метка, иначе - команда
            for (var i = 0; i < instructionsWithLabels.Length; i++)
            {
                var line = instructionsWithLabels[i];
                if (line.StartsWith("("))
                {
                    var label = line.Substring(1, line.Length - 2);
                    marksDict[label] = lineNumber;
                }
                else 
                {
                    instructionsList.Add(line);
                    lineNumber++;
                };
            }
            //возвращаем массив команд и словарь с метками
            instructionsWithoutLabels = instructionsList.ToArray();
            return marksDict;
        }
    }
}
