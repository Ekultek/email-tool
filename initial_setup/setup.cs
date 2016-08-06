using System;
using System.Diagnostics;

//The initial setup process of the program. Run setup.exe from initial_setup directory to setup the program.
namespace Installer
{
    class RunInstaller
    {
        static void installRuby(string setUp)
        {
            using (Process exeProcess = Process.Start(setUp))
            {
                exeProcess.WaitForExit();
            }
        } 

        static void EditVar(string varToAdd)
        {
            string envValue = "True";

            if (Environment.GetEnvironmentVariable(varToAdd) == null)
                Environment.SetEnvironmentVariable(varToAdd, envValue);
        }

        static void Main(string[] args)
        {
            Console.Write("Copy and paste the path to this file: ");
            var filePath = Console.ReadLine();

            var userName = Environment.UserName;
            var setUp = @"\rubyinstaller-2.3.0.exe";
            var startProcess = filePath + setUp;
            var varPath = @"C:\Ruby23\bin";

            Console.WriteLine(startProcess);
            try
            {
                installRuby(startProcess.ToString());
                EditVar(varPath);

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("Verify that the executables where installed by typing 'irb' in a command prompt, if something happens you're good, read the readme.md, if nothing happens get into contact with Thomas Perkins (TJ).");
            }
            
            catch (Exception e)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("You need admin rights to install this. Check out the 'How to get admin rights text file'");
                Console.WriteLine(e.ToString());
            }
            Console.ReadLine();
            
        }
    }
}
