using System.Text;

public interface IStaff
{
    List<JobVacancy> getJobVacancies();
    List<Employee> getEmployees();
    List<JobTitle> getJobTitles();
    int addJobTitles(JobTitle t);
    string printJobVacancies();
    bool delJobTitle(int n);
    int openJobVacancy(JobVacancy v);
    bool closeJobVacancy(int v);
    Employee recruit(JobVacancy v, Person p);
    void dismiss(int n, Reason r);
}

public class Organization : IStaff
{
    private int _id;
    public int Id
    {
        get { return _id; }
        private set { _id = value; }
    }
    protected string _name;

    public string Name
    {
        get { return _name; }
        protected set { _name = value; }
    }
    protected object _shortName;

    public object ShortName
    {
        get { return _shortName; }
        protected set { _shortName = value; }
    }
    protected string _address;

    public string Address
    {
        get { return _address; }
        protected set { _address = value; }
    }
    protected DateTime _timeStamp;

    public DateTime TimeStamp
    {
        get { return _timeStamp; }
        protected set { _timeStamp = value; }
    }
    public List<JobVacancy> vacancies = new List<JobVacancy>();

    public Organization()
    {

    }
    public Organization(Organization org)
    {

    }
    public Organization(string name, object shortName, string address)
    {
        Name = name;
        ShortName = shortName;
        Address = address;
    }
    public void printinfo()
    {
        Console.WriteLine("Id: " + Id);
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
        Console.WriteLine("TimeStamp: " + TimeStamp);
    }

    public void SetTimeStamp(DateTime _timeStamp)
    { TimeStamp = _timeStamp; }

    public void SetId(int _id)
    {
        Id = _id;
    }

    public List<JobVacancy> getJobVacancies()
    {
        return vacancies;
    }

    public List<Employee> getEmployees()
    {
        throw new NotImplementedException();
    }

    public List<JobTitle> getJobTitles()
    {
        throw new NotImplementedException();
    }

    public int addJobTitles(JobTitle t)
    {
        int amount = 0;
        ++amount;
        return amount;
    }

  

    public bool delJobTitle(int n)
    {
        if (n >= 0)
        {
            return true; 
        }
        else
        {
            return false; 
        }
    }

    public int openJobVacancy(JobVacancy v)
    {
        return 0;
    }

    public bool closeJobVacancy(int v)
    {
        return true;
    }
    public string printJobVacancies()
    {
        StringBuilder sb = new StringBuilder();
        foreach (JobVacancy vacancy in vacancies)
        {
            sb.AppendLine("Вакансия: " + vacancy.vac);
        }
        return sb.ToString();
    }


    public Employee recruit(JobVacancy v, Person p)
    {
        Employee employee = new Employee();
        return employee;
    }

    public void dismiss(int n, Reason r)
    {
        throw new NotImplementedException();
    }
}
public class Faculty : Organization, IStaff
{
    protected List<Department> departments = new List<Department>();
    public Faculty()
    {

    }
    public Faculty(Faculty f)
    {

    }
    public Faculty(string name, string shortName, string address)
    {

    }
    public int addDeparment(Department d)
    {
        departments.Add(d);
        return departments.Count;
    }
    public bool delDepartment(int n)
    {
        if (n >= 0 && n < departments.Count)
        {
            departments.RemoveAt(n);
            return true;
        }
        else
        {
            return false;
        }
    }
    public bool updDepartment(Department d)
    {
        int index = departments.FindIndex(dep => dep.dep == d.dep);
        if (index != -1)
        {
            departments[index] = d;
            return true;
        }
        else
        {
            return false;
        }
    }
    private bool verDepartment(int n)
    {
        if (n >= 0 && n < departments.Count)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public List<Department> getDepartments()
    {
        return departments;
    }
    public void printinfo()
    {
        Console.WriteLine("Id: " + Id);
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
        Console.WriteLine("TimeStamp: " + TimeStamp);
        Console.WriteLine("Переопределенный метод из Faculty");
    }

    public List<JobVacancy> getJobVacancies()
    {
        return vacancies;
    }

    public int addJobTitles(JobTitle t)
    {
        int amount = 0;
        ++amount;
        return amount;
    }
    public bool delJobTitle(int n)
    {
        if (n >= 0)
        {
            return true; // Должность успешно удалена
        }
        else
        {
            return false; // Некорректный индекс должности
        }
    }
    public int openJobVacancy(JobVacancy v)
    {
        return 0;
    }
    public bool closeJobVacancy(int v)
    {
        return true;
    }
    public Employee recruit(JobVacancy v, Person p)
    {
        Employee employee = new Employee();
        return employee;
    }
    public void dismiss(int n, Reason r)
    {
        throw new NotImplementedException();
    }
}
public class Department
{
    public string dep { get; set; }
    public Department(string dep)
    {
        this.dep = dep;
    }
}
public class University : Organization
{
    protected List<Faculty> faculties = new List<Faculty>();
    public University()
    {

    }
    public University(University uni)
    {

    }
    public University(string name, string shortName, string address)
    {

    }
    public int addFaculty(Faculty f)
    {
        faculties.Add(f);
        return faculties.Count;
    }
    public bool delFaculty(int n)
    {
        if (n >= 0 && n < faculties.Count)
        {
            faculties.RemoveAt(n);
            return true; // Департамент успешно удален
        }
        else
        {
            return false; // Некорректный индекс департамента
        }
    }
    private bool verFaculty(int n)
    {
        if (n >= 0 && n < faculties.Count)
        {
            return true; // Департамент с указанным номером существует
        }
        else
        {
            return false; // Департамент с указанным номером не существует
        }
    }
    public List<Faculty> getFaculties() { 
        return faculties; 
    }

    public void printinfo()
    {
        Console.WriteLine("Id: " + Id);
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
        Console.WriteLine("TimeStamp: " + TimeStamp);
    }
    public List<JobVacancy> vacancies = new List<JobVacancy>();
    public List<JobVacancy> getJobVacancies()
    {
        return vacancies;
    }
    public int addJobTitles(JobTitle t)
    {
        int amount = 0;
        ++amount;
        return amount;
    }
    public bool delJobTitle(int n)
    {
        if (n >= 0)
        {
            return true; // Должность успешно удалена
        }
        else
        {
            return false; // Некорректный индекс должности
        }
    }
    public int openJobVacancy(JobVacancy v)
    {
        return 0;
    }
    public bool closeJobVacancy(int v)
    {
        return true;
    }
    public Employee recruit(JobVacancy v, Person p)
    {
        Employee employee = new Employee();
        return employee;
    }
    public void dismiss(int n, Reason r)
    {

    }
}

public class JobVacancy
{
    public string vac { get; set; }
    public JobVacancy(string vac)
    {
        this.vac = vac;
    }
}
public class JobTitle
{
    public string title { get; set; }
}
public class Employee
{
    public string name { get; set; }
}
public class Person
{

}
public class Reason
{

}

public class Program
{
    private static void Main(string[] args)
    {
        University university = new University("Университет", "Специальность", "Адрес");
        university.SetId(1);
        university.SetTimeStamp(DateTime.Now);
        university.printinfo();


        
        Faculty faculty = new Faculty("Факультет информационных технологий", "ФИТ", "Свердлова 13а");
        university.addFaculty(faculty);

        
        Department department = new Department("Предмет1");

        
        faculty.addDeparment(department);

        
        JobVacancy jobVacancy1 = new JobVacancy("Доцент");
        JobVacancy jobVacancy2 = new JobVacancy("Старший преподаватель");

        
        faculty.openJobVacancy(jobVacancy1);
        faculty.openJobVacancy(jobVacancy2);

        
        List<JobVacancy> vacancies = university.getJobVacancies();
        foreach (JobVacancy vacancy in vacancies)
        {
            Console.WriteLine("Вакансия: " + vacancy.vac);
        }
        faculty.printinfo();

        university.printinfo();


        Console.ReadLine();
    }
}