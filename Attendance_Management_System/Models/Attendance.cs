using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Attendance_Management_System.Models
{
    [Table("Attendance")]
    public class Attendance :IValidatableObject
    {
        [Key]
        public int AttendanceId { get; set; }

        public int StudentId { get; set; }

        [Column(TypeName = "date")]
        public DateTime AttendanceDate { get; set; }

        [Required]
        [StringLength(10)]
        public string AttendanceStatus { get; set; }

        public int MarkedByUserId { get; set; }
        public DateTime CreatedAt { get; set; }

        [ForeignKey("StudentId")]
        public virtual Student Student { get; set; }   // navugation property , referenc type

        [ForeignKey("MarkedByUserId")]
        public virtual User MarkedByUser { get; set; }
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (AttendanceStatus != "Present" &&
                AttendanceStatus != "Absent")
            {
                yield return new ValidationResult(
                    "Attendance status must be either Present or Absent.",
                    new[] { "AttendanceStatus" });
            }
        }
    }
}