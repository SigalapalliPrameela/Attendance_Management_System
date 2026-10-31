using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Attendance_Management_System.Models
{
    [Table("Users")]
    public class User : IValidatableObject
    {
        [Key]
        public int UserId { get; set; }

        [Required]
        [StringLength(100)]
        public string FullName { get; set; }


        [Required]
        [StringLength(256)]
        public string Email { get; set; }

        [Required]
        [StringLength(50)]
        public string UserName { get; set; }

        [Required]
        [StringLength(500)]
        public string PinHash { get; set; }

        [Required]
        [StringLength(20)]
        public string Role { get; set; } = "Teacher";

        [Required]
        [StringLength(20)]
        public string ApprovalStatus { get; set; } = "Pending";

        public int? ApprovedByUserId { get; set; }

        public DateTime? ApprovedAt { get; set; }

        public DateTime CreatedAt { get; set; }

        [ForeignKey("ApprovedByUserId")]
        public virtual User ApprovedByUser { get; set; }

        public virtual ICollection<User> ApprovedUsers { get; set; }

        public virtual ICollection<Attendance> MarkedAttendance { get; set; } // this is to know the teacher marked attendance for which students

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (Role != "Admin" && Role != "Teacher")
            {
                yield return new ValidationResult(
                    "Role must be either Admin or Teacher.",
                    new[] { "Role" });
            }

            if (ApprovalStatus != "Pending" &&
                ApprovalStatus != "Approved" &&
                ApprovalStatus != "Rejected")
            {
                yield return new ValidationResult(
                    "Approval status must be Pending, Approved, or Rejected.",
                    new[] { "ApprovalStatus" });
            }
        }
        public User() 
        {
            //  here we created a constructor to get ready the collections when a user object is created
            ApprovedUsers = new HashSet<User>();
            MarkedAttendance = new HashSet<Attendance>();
        }

    }
}