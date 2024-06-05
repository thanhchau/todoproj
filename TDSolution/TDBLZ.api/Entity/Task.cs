using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using TDBLZ.api.Enum;

namespace TDBLZ.api.Entity
{
    public class Task
    {
        [Key]
        public Guid ID { get; set; }
        [MaxLength(250)]
        [Required]
        public string  Name { get; set; }
        public Guid? AssigneeID { get; set; }
        [ForeignKey(nameof(AssigneeID))]
        public User Assignee { get; set; }
        public DateTime CreatedDate { get; set; }
        public Status Status { get; set; }

        public Priority Priority { get; set; }

    }
}
