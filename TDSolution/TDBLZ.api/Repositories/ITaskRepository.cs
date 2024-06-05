using Task = TDBLZ.api.Entity.Task;
namespace TDBLZ.api.Repositories
{
    public interface ITaskRepository
    {
        Task<IEnumerable<Task>> GetAllTasks();
        
        Task<Task> CreateTask(Task task);

        Task<Task> UpdateTask(Task task);

        Task<Task> DeleteTask(Task task);

        Task<Task> GetTaskById(Guid id);
    }
}
