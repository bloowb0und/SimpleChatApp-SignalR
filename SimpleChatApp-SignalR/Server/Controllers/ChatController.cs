using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SimpleChatApp_SignalR.Server.EF;
using SimpleChatApp_SignalR.Shared.DTOs;
using SimpleChatApp_SignalR.Shared.Models;

namespace SimpleChatApp_SignalR.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatController : ControllerBase
    {
        private readonly ChatContext _chatContext;

        public ChatController(ChatContext chatContext)
        {
            _chatContext = chatContext;
        }

        [HttpGet("allchats/{username}")]
        public async Task<ActionResult<IEnumerable<ChatDTO>>> GetAllChatsForUser(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                return BadRequest("Incoming data is empty.");
            }

            var foundUser = await _chatContext.Users
                .Include(u => u.Chats)
                .Include(u => u.Chats)
                .FirstOrDefaultAsync(u => u.Username == username);

            if (foundUser is null)
            {
                return BadRequest("User was not found.");
            }
            
            var response = _chatContext.Chats
                .Include(c => c.Users)
                .Include(c => c.Messages)
                .Where(c => c.Users.Any(u => u.Id == foundUser.Id))
                .Select(c => new ChatDTO()
                {
                    Id = c.Id,
                    Title = c.Title,
                    IsPrivate = c.IsPrivate,
                    MessagesIds = c.Messages.Select(m => m.Id),
                    UsersIds = c.Users.Select(u => u.Id)
                });
            
            return Ok(response);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Chat>> GetChatById(int id)
        {
            if (id <= 0)
            {
                return BadRequest("Incoming data has wrong format.");
            }

            var foundChat = await _chatContext.Chats.FirstOrDefaultAsync(c => c.Id == id);
            
            if (foundChat is null)
            {
                return BadRequest("Chat was not found.");
            }
            
            return foundChat;
        }
        
        [HttpGet("messages/{chatId}/{amountOfMessages}")]
        public async Task<ActionResult<IEnumerable<MessageDTO>>> GetMessagesFromChat(int chatId, int amountOfMessages)
        {
            if (chatId <= 0 
                || amountOfMessages <= 0)
            {
                return BadRequest("Incoming data has wrong format.");
            }

            var foundChat = await _chatContext.Chats
                .Include(c => c.Messages)
                .Include(c => c.Users)
                .FirstOrDefaultAsync(c => c.Id == chatId);
            
            if (foundChat is null)
            {
                return BadRequest("Chat was not found.");
            }
            
            var firstNMessages = foundChat.Messages
                .OrderByDescending(m => m.Id)
                .Take(amountOfMessages + 1);

            return Ok(firstNMessages.Select(c => new MessageDTO()
            {
                Id = c.Id,
                Value = c.Value,
                DateCreated = c.DateCreated,
                DateLastEdited = c.DateLastEdited,
                ChatId = c.Chat.Id,
                UserId = c.User.Id,
                SenderUsername = c.User.Username,
                RepliedUserId = c.RepliedUser?.Id,
                RepliedUserUsername = c.RepliedUser?.Username,
                VisibleToSender = c.VisibleToSender
            }));
        }
    }
}
