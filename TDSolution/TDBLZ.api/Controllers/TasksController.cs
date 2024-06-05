using Microsoft.AspNetCore.Mvc;
using TDBLZ.api.Repositories;

namespace TDBLZ.api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TasksController : ControllerBase
    {
        private readonly ITaskRepository _taskRepository;
        public TasksController(ITaskRepository taskRepository) 
        {
            _taskRepository = taskRepository;
        }
        

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var tasks = await _taskRepository.GetAllTasks();
            return Ok(tasks);
        }
    }
}
