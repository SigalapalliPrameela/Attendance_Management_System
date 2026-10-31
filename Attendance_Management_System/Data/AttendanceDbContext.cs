using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using Attendance_Management_System.Models;

namespace Attendance_Management_System.Data
{
    public class AttendanceDbContext : DbContext
    {
        public AttendanceDbContext() : base("name=StudentAttendanceConnection")
        { }

        public DbSet<User> Users { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Student> Students { get; set; }
        public DbSet<Attendance> Attendances { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            //User table
            modelBuilder.Entity<User>().HasIndex(u => u.Email).IsUnique();

            modelBuilder.Entity<User>().HasIndex(u => u.UserName).IsUnique();

            //Department Table
            modelBuilder.Entity<Department>().HasIndex(d => d.DepartmentName).IsUnique();

            // Student Table
            modelBuilder.Entity<Student>().HasIndex(s => s.RollNumber).IsUnique();

            // Prevent duplicate attendance for the same student on the same date
            modelBuilder.Entity<Attendance>().HasIndex(a => new
            {
                a.StudentId,
                a.AttendanceDate
            }).IsUnique();

            // User self referencing because a User is approved by another User(Admin)
            modelBuilder.Entity<User>().HasOptional(u => u.ApprovedByUser)
                .WithMany(u => u.ApprovedUsers).HasForeignKey(u => u.ApprovedByUserId).WillCascadeOnDelete(false);

            // Department - Student relation
            modelBuilder.Entity<Student>().HasRequired(s => s.Department).WithMany(d => d.Students).HasForeignKey(s => s.DepartmentId).WillCascadeOnDelete(false);

            //Student - Attendance relation
            modelBuilder.Entity<Attendance>().HasRequired(a => a.Student).WithMany(s => s.AttendanceRecords).HasForeignKey(a => a.StudentId).WillCascadeOnDelete(false);

            //User - Attendance relation
            modelBuilder.Entity<Attendance>().HasRequired(a => a.MarkedByUser).WithMany(u => u.MarkedAttendance).HasForeignKey(a => a.MarkedByUserId).WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .Property(u => u.CreatedAt)
                .HasDatabaseGeneratedOption(
                 System.ComponentModel.DataAnnotations.Schema.DatabaseGeneratedOption.Computed);

            modelBuilder.Entity<Attendance>()
            .Property(a => a.CreatedAt)
            .HasDatabaseGeneratedOption(
            System.ComponentModel.DataAnnotations.Schema.DatabaseGeneratedOption.Computed);

        }
    }
}