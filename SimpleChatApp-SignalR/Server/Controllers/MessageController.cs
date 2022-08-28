using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SimpleChatApp_SignalR.Server.EF;
using SimpleChatApp_SignalR.Shared.DTOs;
using SimpleChatApp_SignalR.Shared.Models;

namespace SimpleChatApp_SignalR.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessageController : ControllerBase
    {
        private readonly ChatContext _chatContext;

        public MessageController(ChatContext chatContext)
        {
            _chatContext = chatContext;
        }

        [HttpPut]
        public async Task<ActionResult> EditMessage([FromBody] MessageDTO messageDto)
        {
            if (messageDto is null
                || messageDto.DateLastEdited == default)
            {
                return BadRequest();
            }
            
            var foundMessage = await _chatContext.Messages.FirstOrDefaultAsync(m => m.Id == messageDto.Id);

            if (foundMessage is null)
            {
                return BadRequest();
            }
            
            foundMessage.Value = messageDto.Value;
            foundMessage.DateLastEdited = messageDto.DateLastEdited;
            _chatContext.Messages.Update(foundMessage);
            await _chatContext.SaveChangesAsync();
            
            return Ok();
        }
        
        [HttpDelete("{messageId}/{isVisibleToSender}")]
        public async Task<ActionResult> DeleteMessage(int messageId, bool isVisibleToSender)
        {
            if (messageId <= 0)
            {
                return BadRequest();
            }
            
            var foundMessage = await _chatContext.Messages.FirstOrDefaultAsync(m => m.Id == messageId);

            if (foundMessage is null)
            {
                return BadRequest();
            }

            if (!isVisibleToSender)
            {
                foundMessage.VisibleToSender = false;
                _chatContext.Messages.Update(foundMessage);
            }
            else
            {
                _chatContext.Messages.Remove(foundMessage);
            }
            
            await _chatContext.SaveChangesAsync();
            
            return Ok();
        }
    }
}