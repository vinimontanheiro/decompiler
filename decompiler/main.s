using System;
using System.IO;

namespace Decompiler
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            string filename = args[0];

            using (var fileStream = new FileStream(filename, FileMode.Open))
            {
                byte[] buffer = new byte[4];

                do
                {
                    int read = fileStream.Read(buffer, 0, buffer.Length);

                    if (read == 0)
                    {
                        break;
                    }
                    uint code = Convert.ToUInt32(buffer);
                    var instruction = new Instruction(code);
                    Console.WriteLine(code);

                } while (true);
            }

        }
    }
}

public class Instruction
{
    uint _code;

    public Instruction(uint code)
    {
        _code = code;
    }

    private uint OpCode
    {
       get{
           return _code >> 26;
       }
    }

    private uint ShAmount
    {
        get
        {
            return (_code << 21) >> 27;
        }
    }

    private uint funct
    {
        get
        {
            return (_code << 26) >> 26;
        }
    }


    private uint RegD
    {
        get
        {
            return (_code << 6) >> 27;
        }
    }

    private uint RegS
    {
        get
        {
            return (_code << 6) >> 27;
        }
    }

    private uint RegT
    {
        get
        {
            return (_code << 11) >> 27;
        }
    }

    private uint RegSource
    {
        get
        {
            return (_code << 6) >> 27;
        }
    }

    private string ReadInstruction()
    {
        if(OpCode == 0)
        {
            return ReadInstructionTypeR();
        }

        throw new NotImplementedException();

    }

    private string ReadInstructionTypeR()
    {
        return string.Format("{0},{1},{2},{3}",FunctAsString(),RegAsString(RegD),RegAsString(RegS),RegAsString(RegT));
    }

    private string FunctAsString()
    {
        string result = null;

        switch(funct)
        {
            case 64:
                result = "ADD";
                break;

            case 72:
                result = "AND";
                break;

            default:
                throw new NotImplementedException();
         }
        return result;
 
    }

    private string RegAsString(uint regId)
    {
        string result = null;

        switch (regId)
        {
            case 0:
                result = "$zero";
                break;

            default:
                throw new NotImplementedException();

        }
        return result;


    }

};
