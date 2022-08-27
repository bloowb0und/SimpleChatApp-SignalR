using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SimpleChatApp_SignalR.Server.EF;
using SimpleChatApp_SignalR.Shared.DTOs;
using SimpleChatApp_SignalR.Shared.Models;

namespace SimpleChatApp_SignalR.Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class UserController : ControllerBase
{
    private readonly ChatContext _chatContext;

    public UserController(ChatContext chatContext)
    {
        _chatContext = chatContext;
    }
    
    [HttpPost("auth")]
    public async Task<ActionResult<User>> AuthorizeUser([FromBody] UserDTO userDto)
    {
        if (string.IsNullOrWhiteSpace(userDto.Username)
            || string.IsNullOrWhiteSpace(userDto.Password))
        {
            return NoContent();
        }
        
        var foundUser =
            await _chatContext.Users
                .FirstOrDefaultAsync(u => u.Username == userDto.Username && u.Password == userDto.Password);

        if (foundUser is null)
        {
            return BadRequest("Wrong username or password");
        }

        return Ok(foundUser);
    }
    
    [HttpPost]
    [Route("create")]
    public async Task<ActionResult<User>> CreateUser([FromBody] UserDTO userDto)
    {
        if (string.IsNullOrWhiteSpace(userDto.Username)
            || string.IsNullOrWhiteSpace(userDto.Password))
        {
            return BadRequest("Empty input data.");
        }

        var newUser = new User()
        {
            Username = userDto.Username,
            Password = userDto.Password
        };

        var userWithSameUsername = await _chatContext.Users.FirstOrDefaultAsync(u => u.Username == newUser.Username);
        if (userWithSameUsername is not null)
        {
            return BadRequest("User with this username already exists.");
        }

        await _chatContext.Users.AddAsync(newUser);
        await _chatContext.SaveChangesAsync();

        return Ok(newUser);
    }
}