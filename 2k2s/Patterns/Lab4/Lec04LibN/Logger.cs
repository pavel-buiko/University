using System;
using System.IO;

namespace Lec04LibN
{
    public partial class Logger : ILogger
    {
        private static Logger logger;
        private static int recordNumber = 1; 
        private string startType;

        private string LogFileName = string.Format(
            @"{0}/LOG{1}.txt",
            Directory.GetCurrentDirectory(), DateTime.Now.ToString("yyyyMMdd-HH-mm-ss")
        );

        private Logger()
        {
            File.AppendAllText(LogFileName, string.Format(
                "{0:d6}-{1}-INIT\n",
                recordNumber, DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss")
            ));

            recordNumber++;
        }


        public static ILogger create()
        {
            if (logger is null)
            {
                logger = new Logger();
                return logger;
            }

            return logger;
        }

        public void log(string message = "")
        {
            File.AppendAllText(LogFileName, string.Format(
                "{0:d6}-{1}-INFO {2} {3}\n",
                recordNumber, DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"), startType, message
            ));

            recordNumber++;
        }


        public void stop()
        {
            startType = startType.Substring(0, startType.Length - 2);

            File.AppendAllText(LogFileName, string.Format(
                "{0:d6}-{1}-STOP {2}\n",
                recordNumber, DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"), startType
            ));

            recordNumber++;
        }

        public void start(string title)
        {
            startType += title + ":";

            File.AppendAllText(LogFileName, string.Format(
                "{0:d6}-{1}-STRT {2}\n",
                recordNumber, DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"), startType
            ));

            recordNumber++;
        }
    }
}
