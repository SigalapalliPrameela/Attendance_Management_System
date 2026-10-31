namespace Attendance_Management_System.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Attendance",
                c => new
                    {
                        AttendanceId = c.Int(nullable: false, identity: true),
                        StudentId = c.Int(nullable: false),
                        AttendanceDate = c.DateTime(nullable: false, storeType: "date"),
                        AttendanceStatus = c.String(nullable: false, maxLength: 10),
                        MarkedByUserId = c.Int(nullable: false),
                        CreatedAt = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.AttendanceId)
                .ForeignKey("dbo.Users", t => t.MarkedByUserId)
                .ForeignKey("dbo.Students", t => t.StudentId)
                .Index(t => new { t.StudentId, t.AttendanceDate }, unique: true)
                .Index(t => t.MarkedByUserId);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        UserId = c.Int(nullable: false, identity: true),
                        FullName = c.String(nullable: false, maxLength: 100),
                        Email = c.String(nullable: false, maxLength: 256),
                        UserName = c.String(nullable: false, maxLength: 50),
                        PinHash = c.String(nullable: false, maxLength: 500),
                        Role = c.String(nullable: false, maxLength: 20),
                        ApprovalStatus = c.String(nullable: false, maxLength: 20),
                        ApprovedByUserId = c.Int(),
                        ApprovedAt = c.DateTime(),
                        CreatedAt = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.UserId)
                .ForeignKey("dbo.Users", t => t.ApprovedByUserId)
                .Index(t => t.Email, unique: true)
                .Index(t => t.UserName, unique: true)
                .Index(t => t.ApprovedByUserId);
            
            CreateTable(
                "dbo.Students",
                c => new
                    {
                        StudentId = c.Int(nullable: false, identity: true),
                        RollNumber = c.String(nullable: false, maxLength: 30),
                        StudentName = c.String(nullable: false, maxLength: 100),
                        DepartmentId = c.Int(nullable: false),
                        YearOfStudy = c.Int(nullable: false),
                        IsActive = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.StudentId)
                .ForeignKey("dbo.Departments", t => t.DepartmentId)
                .Index(t => t.RollNumber, unique: true)
                .Index(t => t.DepartmentId);
            
            CreateTable(
                "dbo.Departments",
                c => new
                    {
                        DepartmentId = c.Int(nullable: false, identity: true),
                        DepartmentName = c.String(nullable: false, maxLength: 100),
                        IsActive = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.DepartmentId)
                .Index(t => t.DepartmentName, unique: true);


            // Database-level validation constraints

                        Sql(@"
                ALTER TABLE dbo.Users
                ADD CONSTRAINT CK_Users_Role
                CHECK (Role IN ('Admin', 'Teacher'));
            ");

                        Sql(@"
                ALTER TABLE dbo.Users
                ADD CONSTRAINT CK_Users_ApprovalStatus
                CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected'));
            ");

                        Sql(@"
                ALTER TABLE dbo.Students
                ADD CONSTRAINT CK_Students_YearOfStudy
                CHECK (YearOfStudy BETWEEN 1 AND 4);
            ");

                        Sql(@"
                ALTER TABLE dbo.Attendance
                ADD CONSTRAINT CK_Attendance_Status
                CHECK (AttendanceStatus IN ('Present', 'Absent'));
            ");
        }
        
        public override void Down()
        {
            Sql("ALTER TABLE dbo.Attendance DROP CONSTRAINT CK_Attendance_Status;");
            Sql("ALTER TABLE dbo.Students DROP CONSTRAINT CK_Students_YearOfStudy;");
            Sql("ALTER TABLE dbo.Users DROP CONSTRAINT CK_Users_ApprovalStatus;");
            Sql("ALTER TABLE dbo.Users DROP CONSTRAINT CK_Users_Role;");
            DropForeignKey("dbo.Attendance", "StudentId", "dbo.Students");
            DropForeignKey("dbo.Students", "DepartmentId", "dbo.Departments");
            DropForeignKey("dbo.Attendance", "MarkedByUserId", "dbo.Users");
            DropForeignKey("dbo.Users", "ApprovedByUserId", "dbo.Users");
            DropIndex("dbo.Departments", new[] { "DepartmentName" });
            DropIndex("dbo.Students", new[] { "DepartmentId" });
            DropIndex("dbo.Students", new[] { "RollNumber" });
            DropIndex("dbo.Users", new[] { "ApprovedByUserId" });
            DropIndex("dbo.Users", new[] { "UserName" });
            DropIndex("dbo.Users", new[] { "Email" });
            DropIndex("dbo.Attendance", new[] { "MarkedByUserId" });
            DropIndex("dbo.Attendance", new[] { "StudentId", "AttendanceDate" });
            DropTable("dbo.Departments");
            DropTable("dbo.Students");
            DropTable("dbo.Users");
            DropTable("dbo.Attendance");
        }
    }
}
