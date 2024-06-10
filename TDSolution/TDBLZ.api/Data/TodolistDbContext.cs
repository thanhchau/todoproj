using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using TDBLZ.api.Entity;
using Task = TDBLZ.api.Entity.Task;

namespace TDBLZ.api.Data
{
    public class TodolistDbContext : IdentityDbContext<User, Role, Guid>
    {
        public TodolistDbContext(DbContextOptions<TodolistDbContext> options) : base(options)
        {

        }  
        public DbSet<Task> Tasks { get; set; }
    }
}
