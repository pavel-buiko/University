public class Organization
{
    private int _id;
    public int Id
    {
        get { return _id; }
        private set { _id = value; }
    }

    private string _name;
    public string Name
    {
        get { return _name; }
        protected set { _name = value; }
    }

    private object _shortName;
    public object ShortName
    {
        get { return _shortName; }
        protected set { _shortName = value; }
    }

    private string _address;
    public string Address
    {
        get { return _address; }
        protected set { _address = value; }
    }

    private DateTime _timeStamp;
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

    public Organization(string name, object shortName, string address)
    {
        Name = name;
        ShortName = shortName;
        Address = address;
    }

    public void SetId(int _id)
    {
        Id = _id;
    }

    public void SetName(string name)
    {
        Name = name;
    }

    public void SetShortName(object shortName)
    {
        ShortName = shortName;
    }

    public void SetAddress(string address)
    {
        Address = address;
    }

    public void SetTimeStamp(DateTime timeStamp)
    {
        TimeStamp = timeStamp;
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

public class Faculty : Organization
{
    protected List<Department> departments = new List<Department>();
    public string fac { get; set; }
    public Faculty(string dep)
    {
        this.fac = fac;
    }
    public Faculty()
    {

    }
    public Faculty(Faculty f)
    {

    }
    public Faculty(string name, string shortName, string address)
    {

    }

    public List<Department> Departments
    {
        get { return departments; }
        set { departments = value; }
    }


    public int AddDepartment(Department d)
    {
        departments.Add(d);
        return departments.Count;
    }
    public bool DeleteDepartment(int n)
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
    public bool UpdateDepartment(Department d)
    {
        int index = departments.FindIndex(dep => dep.Dep == d.Dep);
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
    private bool VerDepartment(int n)
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
        base.PrintInfo();
        foreach (var department in Departments)
        {
            Console.WriteLine("Department: " + department.Dep);
        }
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

    public int AddFaculty(Faculty f)
    {
        faculties.Add(f);
        return faculties.Count;
    }
    public bool DeleteFaculty(int n)
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
    private bool VerFaculty(int n)
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
    public List<Faculty> GetFaculties() { 
        return faculties; 
    }
    public void PrintInfo()
    {
        base.PrintInfo();
        foreach (var faculties in faculties)
        {
            Console.WriteLine("Department: " + faculties.fac);
        }
    }
}
public class Department
{
    public string Dep { get; set; }
    public Department(string dep)
    {
        this.Dep = dep;
    }
}
public class Program
{
    private static void Main(string[] args)
    {
        
        Organization organization = new Organization();

        
        organization.SetId(1);
        organization.SetName("XYZ Company");
        organization.SetShortName("XYZ");
        organization.SetAddress("123 Main Street");
        organization.SetTimeStamp(DateTime.Now);

      
        organization.PrintInfo();

       
        Faculty faculty = new Faculty(); ;

       
        faculty.SetId(1);
        faculty.SetName("Computer Science Faculty");
        faculty.SetShortName("CS");
        faculty.SetAddress("456 University Avenue");
        faculty.SetTimeStamp(DateTime.Now);

       
        Department department = new Department("Software Engineering");
        faculty.AddDepartment(department);

        
        faculty.PrintInfo();

       
        University university = new University();

        
        university.SetId(1);
        university.SetName("XYZ University");
        university.SetShortName("XYZ");
        university.SetAddress("789 College Road");
        university.SetTimeStamp(DateTime.Now);

        university.AddFaculty(faculty);

        
        university.PrintInfo();
    }
}
