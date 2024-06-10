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
        [HttpPost]
        public async Task<IActionResult> CreateTask(Entity.Task task)
        {
            if(!ModelState.IsValid) return BadRequest(ModelState);
            var tasks = await _taskRepository.CreateTask(task);
            return CreatedAtAction(nameof(GetByID),new { id = task.ID}, tasks);
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<IActionResult> UpdateTask(Guid id,Entity.Task task)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var taskFromDb  = await _taskRepository.GetTaskById(id);
            if(taskFromDb == null)
            {
                return NotFound($"{id} is not found");
            }
            taskFromDb.Name = task.Name;
            var tasks = await _taskRepository.UpdateTask(taskFromDb);
            return Ok(tasks);
        }


        [HttpGet]
        [Route("{id}")]
        public async Task<IActionResult> GetByID([FromRoute]Guid id)
        {
            var task = await _taskRepository.GetTaskById(id);
            if (task == null) return NotFound($"{id} not Found");
            return Ok(task);
        }
    }
}
