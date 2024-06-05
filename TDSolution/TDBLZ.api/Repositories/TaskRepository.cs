
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;
using TDBLZ.api.Data;

namespace TDBLZ.api.Repositories
{
    public class TaskRepository : ITaskRepository
    {
        private readonly TodolistDbContext _dbContext;
        public TaskRepository(TodolistDbContext context) 
        {
            _dbContext = context;
        }
        public async Task<Entity.Task> CreateTask(Entity.Task task)
        {
            _dbContext.Tasks.AddAsync(task);
            await _dbContext.SaveChangesAsync();
            return task;
        }

        public async Task<Entity.Task> DeleteTask(Entity.Task task)
        {
            _dbContext.Tasks.Remove(task);
            await _dbContext.SaveChangesAsync();
            return task;
        }

        public async Task<IEnumerable<Entity.Task>> GetAllTasks()
        {
           return await _dbContext.Tasks.ToListAsync();
        }

        public async Task<Entity.Task> GetTaskById(Guid id)
        {
            return await _dbContext.Tasks.FindAsync(id);
        }

        public async Task<Entity.Task> UpdateTask(Entity.Task task)
        {
            _dbContext.Tasks.Update(task);
            await _dbContext.SaveChangesAsync();
            return task;
        }
    }
}
