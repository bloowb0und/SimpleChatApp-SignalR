using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using SimpleChatApp_SignalR.Server.EF;
using SimpleChatApp_SignalR.Shared.DTOs;
using SimpleChatApp_SignalR.Shared.Models;

namespace SimpleChatApp_SignalR.Server.Hubs;

public class ChatHub : Hub
{
    private readonly ChatContext _chatContext;

    public ChatHub(ChatContext chatContext)
    {
        _chatContext = chatContext;
    }
    
    public async Task SendMessage(MessageDTO message)
    {
        await Clients.All.SendAsync("ReceiveMessage", message);

        var chat = await _chatContext.Chats.FirstOrDefaultAsync(c => c.Id == message.ChatId);
        var user = await _chatContext.Users.FirstOrDefaultAsync(u => u.Id == message.UserId);

        if (chat is null || user is null)
        {
            return;
        }
        
        await _chatContext.Messages.AddAsync(new Message()
        {
            Value = message.Value,
            DateCreated = message.DateCreated,
            DateLastEdited = message.DateLastEdited,
            Chat = chat,
            User = user
        });
        
        await _chatContext.SaveChangesAsync();
    }
}