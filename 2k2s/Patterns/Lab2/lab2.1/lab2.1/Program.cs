public interface IStaff
{
    List<JobVacancy> getJobVacancies();

    List<Employee> getEmployees();

    List<JobTitle> getJobTitles();
    int addJobTitles(JobTitle t);

    string printJobVacancies();

    bool delJobTitle(int n);

    void openJobVacancy(JobVacancy v);

    bool closeJobVacancy(int v);

    Employee recruit(JobVacancy v, Person p);

    bool dismiss(int n, Reason r);
}

public class Organization
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

    public Organization()
    {

    }

    public Organization(Organization org)
    {

    }

    public Organization( string name, string shortName, string address)
    {
        Name = name;
        ShortName = shortName;
        Address = address;
    }

    public void PrintInfo()
    {
        Console.WriteLine("Id: " + Id);
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
        Console.WriteLine("TimeStamp: " + TimeStamp);
    }
}

public class Faculty
{
    protected List<Department> departments = new List<Department>();
    protected List<JobVacancy> vacancies = new List<JobVacancy>();
    public string fac { get; set; }
    public Faculty(string dep)
    {
        this.fac = fac;
    }
    public string Name;
    public string ShortName;
    public string Address;
    public Faculty()
    {
    }

    public Faculty(Faculty f)
    {
    }

    public Faculty(string name, string shortName, string address)
    {
        Name = name;
        ShortName = shortName;
        Address = address;
    }

    public int addDepartment(Department d)
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

    public void PrintInfo()
    {
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
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

    public Employee recruit(JobVacancy v, Person p)
    {
        Employee employee = new Employee();
        return employee;
    }

    public void dismiss(int n, Reason r)
    {

    }
}

public class University
{
    protected List<JobVacancy> vacancies = new List<JobVacancy>();
    protected List<Faculty> faculties = new List<Faculty>();
    public string Name;
    public string ShortName;
    public string Address;

    public University()
    {
    }

    public University(University uni)
    {
    }

    public University(string name, string shortName, string address)
    {
        Name = name;
        ShortName = shortName;
        Address = address;
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
            return true; 
        }
        else
        {
            return false; 
        }
    }

    public bool updFaculty(Faculty f)
    {
        int index = faculties.FindIndex(fac => fac.fac == f.fac);
        if (index != -1)
        {
            faculties[index] = f;
            return true;
        }
        else
        {
            return false;
        }
    }

    private bool verFaculty(int n)
    {
        if (n >= 0 && n < faculties.Count)
        {
            return true; 
        }
        else
        {
            return false; 
        }
    }

    public List<Faculty> GetFaculties()
    {
        return faculties;
    }

    public void PrintInfo()
    {
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("ShortName: " + ShortName);
        Console.WriteLine("Address: " + Address);
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

    public Employee recruit(JobVacancy v, Person p)
    {
        Employee employee = new Employee();
        return employee;
    }

    public void dismiss(int n, Reason r)
    {
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
        Organization org = new Organization(1, "My Organization", "Org", "123 Main St", DateTime.Now);
        org.PrintInfo();
    }
}
