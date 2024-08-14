namespace ConsoleApp1
{

    interface IOne
    {
        public string Name { get; set; }
        public void sayHi();

        event EventHandler? Change;

        public object this[int index] { get; set; }
    }




    class C1 
    {
        public const int publicVar = 100;
        private const int privateVar = 10;
        protected const int protectedVar = 20;

        public int getPrivateVariable() {
            return privateVar;
        }
        public int ProtectedVariable {  get; set; }

        int fValue = 1;
        int biggerValue = 2;
        int biggestValue = 3;

        public int Property
        {
            get
            {
                return fValue;
            }
            set
            {
                value = fValue;
            }
        }

        private int anotherProperty
        {
            get
            {
                return biggerValue;
            }
            set
            {
                biggerValue = value;
            }
        }

        protected int anyProperty
        {
            get
            {
                return biggestValue;
            }
            set
            {
                biggestValue = value;
            }
        }


        public C1()
        {
            Console.WriteLine("Работа конструктора по умолчанию");
        }


        public int Value { get; set; }

        // Копирующий конструктор
        public C1(C1 other)
        {
            Console.WriteLine("Копирующий конструктор");
            this.Value = other.Value; // Инициализация нового объекта значениями из другого объекта
        }

        //конструктор с параметрами
        public C1(int Value)
        {
            Console.WriteLine($"Конструктор с параметрами получил значение {Value}");
            this.Value = Value;
        }


        public void SetField(int val)
        {
            fValue = val;
        }

        protected int getField()
        {
            return fValue;
        }

        private bool checkField(int val)
        {
            return val == fValue ? true : false;
        }
        public bool MyPublicMethod(int val)
        {
            int valueToCheck = val;
            return checkField(valueToCheck);

        }
    }


    class C2 : IOne
    {
        public object[] items = new object[10];
        public object this[int index]
        {
            get
            {
                return items[index];
            }
            set
            {
                items[index] = value;
            }
        }


        public string name;
       public string Name
        {
            get
            { return name; }
            set
            {
                name = value;
            }
        }

        public void sayHi()
        {
            Console.WriteLine("Класс C2 и его метод sayHi вызван");
        }

        public event EventHandler? Change;

        public void RaiseChange()
        {
            Change?.Invoke(this, EventArgs.Empty);
        }

        public const int publicVar = 100;
        private const int privateVar = 10;
        protected const int protectedVar = 20;

        public int getPrivateVariable()
        {
            return privateVar;
        }

        public int getProtectedVariable()
        {
            return protectedVar;
        }

        int fValue = 1;
        int biggerValue = 2;
        int biggestValue = 3;

        public int Property
        {
            get
            {
                return fValue;
            }
            set
            {
                value = fValue;
            }
        }

        private int anotherProperty
        {
            get
            {
                return biggerValue;
            }
            set
            {
                biggerValue = value;
            }
        }

        protected int anyProperty
        {
            get
            {
                return biggestValue;
            }
            set
            {
                biggestValue = value;
            }
        }


        public C2()
        {
            Console.WriteLine("Работа конструктора по умолчанию");
        }


        public int Value { get; set; }

        // Копирующий конструктор
        public C2(C2 other)
        {
            Console.WriteLine("Копирующий конструктор");
            this.Value = other.Value; // Инициализация нового объекта значениями из другого объекта
        }

        //конструктор с параметрами
        public C2(int Value)
        {
            Console.WriteLine($"Конструктор с параметрами получил значение {Value}");
            this.Value = Value;
        }


        public void SetField(int val)
        {
            fValue = val;
        }

        protected int getField()
        {
            return fValue;
        }

        private bool checkField(int val)
        {
            return val == fValue ? true : false;
        }
        public bool MyPublicMethod(int val)
        {
            int valueToCheck = val;
            return checkField(valueToCheck);

        }

    }



    class c3 {
        private string name;

        protected int value;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public void Print()
        {
            Console.WriteLine(Name);
        }
    }


    class c4 : c3
    {
        public c4()
        {
            value = 4;
            Console.WriteLine( value);
        }

        public void sayHi()
        {
            Console.WriteLine($"Моё имя: {Name}");
        }
    }
}