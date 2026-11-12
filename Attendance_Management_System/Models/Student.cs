using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Attendance_Management_System.Models
{
    [Table("Students")]
    public class Student
    {
        [Key]
        public int StudentId { get; set; }

        [Required]
        [StringLength(30)]
        public string RollNumber { get; set; }

        [Required]
        [StringLength(100)]
        public string StudentName { get; set; }

        public int DepartmentId { get; set; }

        [Range(1,4)]
        public int YearOfStudy { get; set; }

        public bool IsActive { get; set; } = true;

        [ForeignKey("DepartmentId")]
        public virtual Department Department { get; set; }    // navigain property reference navigation 
        
        public virtual ICollection<Attendance> AttendanceRecords { get; set; }   // navigation property collection navigation (one to many)

        public Student()
        {
            AttendanceRecords = new HashSet<Attendance>();
        }
    }
}