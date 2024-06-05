using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace TDBLZ.api.Entity
{
    public class Role : IdentityRole<Guid>
    {
        [MaxLength(250)]
        [Required]
        public String Description { get; set; }
    }
}
