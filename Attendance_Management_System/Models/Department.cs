using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace Attendance_Management_System.Models
{
    [Table("Departments")]
    public class Department
    {
        [Key]
        public int DepartmentId { get; set; }

        [Required]
        [StringLength(100)]
        public string DepartmentName { get; set; }
        public bool IsActive { get; set; } = true;
        public virtual ICollection<Student> Students { get; set; }
        //----> One department many students (One to many)
        public Department()
        {
            Students = new HashSet<Student>();
        } 
    }
}