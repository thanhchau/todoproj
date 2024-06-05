using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace TDBLZ.api.Entity
{
    public class User : IdentityUser<Guid>
    {
        [MaxLength(250)]
        [Required]
        public string FirstName { get; set; }
        [MaxLength(250)]
        [Required]
        public String LastName { get; set; }
    }
}
