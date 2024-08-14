using ConsoleApp1;



class Program
{
    static void Main(string[] args)
    {
        // Создание объекта с помощью конструктора по умолчанию
        C1 obj1 = new C1();
        Console.WriteLine();

        // Создание объекта с использованием конструктора с параметрами
        C1 obj2 = new C1(50);
        Console.WriteLine();

        // Создание копии объекта с использованием копирующего конструктора
        C1 obj3 = new C1(obj2);
        Console.WriteLine();

        // Использование свойств и методов объекта
        obj1.Property = 10;
        Console.WriteLine("Значение свойства obj1.Property: " + obj1.Property);

        obj1.SetField(5);
        Console.WriteLine("Значение поля fValue в obj1: " + obj1.MyPublicMethod(5));

        //---------------------------------------С2

        C2 obj4 = new C2();
        obj4.Name = "C2";
        Console.WriteLine("Имя: " + obj4.Name); // Выведет значение по умолчанию для Name
        obj4.sayHi(); // Выведет сообщение "Класс C2 и его метод sayHi вызван"

        // Использование индексатора
        obj4[0] = "Item 1";
        Console.WriteLine("Элемент по индексу 0: " + obj4[0]); // Выведет "Item 1"

        // Продемонстрируем работу события Change
        obj4.Change += (sender, e) => Console.WriteLine("Событие Change произошло");
        obj4.RaiseChange(); // Выведет сообщение "Событие Change произошло"
        
        // Использование констант
        Console.WriteLine("publicVar: " + C2.publicVar);
       Console.WriteLine("privateVar: " + obj4.getPrivateVariable());
       Console.WriteLine("protectedVar: " + obj4.getProtectedVariable); 

        // Использование свойств
        obj4.Property = 5;
        Console.WriteLine("Property: " + obj4.Property); // Выведет 1 (так как в сеттере неправильно установлено значение)

        // Создание объекта класса C2 с использованием конструктора с параметрами
        C2 obj5 = new C2(42);
        Console.WriteLine("Значение: " + obj5.Value); // Выведет 42

        c3 person = new c3 {Name = "C3"};
        person.Print();
        person = new c4 { Name = "C4" }; //неявное
        if (person is c4) // Проверяем, является ли объект типа c4
        {
            c4 newPerson = (c4)person; // Явное приведение типа
            newPerson.sayHi();
        }
        person.Print();
        
    }
}
