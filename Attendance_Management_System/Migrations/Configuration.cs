namespace Attendance_Management_System.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Attendance_Management_System.Models;
    internal sealed class Configuration : DbMigrationsConfiguration<Attendance_Management_System.Data.AttendanceDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Attendance_Management_System.Data.AttendanceDbContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method

            //  to avoid creating duplicate seed data.

            // adding departments if they are existing before , it will prevent o create duplicae data again and again when running
            if(!context.Departments.Any(d=>d.DepartmentName=="CSE"))
            {
                context.Departments.Add(new Department
                {
                    DepartmentName = "CSE",
                    IsActive = true
                });

            }

            if (!context.Departments.Any(d => d.DepartmentName == "ECE"))
            {
                context.Departments.Add(new Department
                {
                    DepartmentName = "ECE",
                    IsActive = true
                });

            }

            if (!context.Departments.Any(d => d.DepartmentName == "MECH"))
            {
                context.Departments.Add(new Models.Department
                {
                    DepartmentName = "MECH",
                    IsActive = true
                });

            }

            if (!context.Departments.Any(d => d.DepartmentName == "IT"))
            {
                context.Departments.Add(new Models.Department
                {
                    DepartmentName = "IT",
                    IsActive = true
                });

            }

            context.SaveChanges(); // first saving upto here , again we will save in last , after students inserting

            // Now we will get these departments into variables
            var cse = context.Departments.FirstOrDefault(d => d.DepartmentName == "CSE");

            var ece = context.Departments.FirstOrDefault(d => d.DepartmentName == "ECE");

            var mech = context.Departments.FirstOrDefault(d => d.DepartmentName == "MECH");

            var it = context.Departments.FirstOrDefault(d => d.DepartmentName == "IT");

            // Adding students only if they atre not exists same like departments

            if(cse != null && !context.Students.Any(s=>s.RollNumber == "CS2026001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "CS2026001",
                    StudentName = "Arjun",
                    DepartmentId=cse.DepartmentId,
                    YearOfStudy =1,
                    IsActive = true
                });

            }

            if (cse != null && !context.Students.Any(s => s.RollNumber == "CS2026002"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "CS2026002",
                    StudentName = "Priya",
                    DepartmentId = cse.DepartmentId,
                    YearOfStudy = 1,
                    IsActive = true
                });

            }

            if (ece != null && !context.Students.Any(s => s.RollNumber == "EC2026001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "EC2026001",
                    StudentName = "Sneha",
                    DepartmentId = ece.DepartmentId,
                    YearOfStudy = 1,
                    IsActive = true
                });

            }

            if (cse != null && !context.Students.Any(s => s.RollNumber == "CS2025001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "CS2025001",
                    StudentName = "Ravan",
                    DepartmentId = cse.DepartmentId,
                    YearOfStudy = 2,
                    IsActive = true
                });

            }

            if (it != null && !context.Students.Any(s => s.RollNumber == "IT2025001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "IT2025001",
                    StudentName = "Hema",
                    DepartmentId = it.DepartmentId,
                    YearOfStudy = 2,
                    IsActive = true
                });

            }

            if (mech != null && !context.Students.Any(s => s.RollNumber == "ME2024001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "ME2024001",
                    StudentName = "Siri",
                    DepartmentId = mech.DepartmentId,
                    YearOfStudy = 3,
                    IsActive = true
                });

            }

            if (mech != null && !context.Students.Any(s => s.RollNumber == "ME2023001"))
            {
                context.Students.Add(new Student
                {
                    RollNumber = "ME2023001",
                    StudentName = "Mallika",
                    DepartmentId = mech.DepartmentId,
                    YearOfStudy = 4,
                    IsActive = true
                });

            }

            context.SaveChanges();  // finally savin all newly added students

        }
    }
}
