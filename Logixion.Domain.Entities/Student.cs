using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Logixion.Domain.Entities
{
    public class Student
    {
        [Key]
        public virtual int StudentId { get; set; }
        [MaxLength(35)]
        public virtual string FirstName { get; set; }
    }
}
