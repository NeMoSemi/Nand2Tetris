namespace Assembler
{
    public class Parser
    {
        public string[] RemoveWhitespacesAndComments(string[] asmLines)
        {
            var withoutComments = new List<string>();
            foreach (var line in asmLines)
            {
                var trimmedLine = line.Split("//")[0].Trim();
                if (!string.IsNullOrEmpty(trimmedLine))
                {
                    withoutComments.Add(trimmedLine.Replace(" ", ""));
                }
            }
            return withoutComments.ToArray();
        }
    }
}
