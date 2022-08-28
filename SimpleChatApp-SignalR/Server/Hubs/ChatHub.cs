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
        var chat = await _chatContext.Chats.FirstOrDefaultAsync(c => c.Id == message.ChatId);
        var user = await _chatContext.Users.FirstOrDefaultAsync(u => u.Id == message.UserId);
        User? repliedUser = null;
        if (message.RepliedUserId is not null)
        {
            repliedUser = await _chatContext.Users.FirstOrDefaultAsync(u => u.Id == message.RepliedUserId);
        }

        if (chat is null || user is null)
        {
            return;
        }

        var createdMsg = new Message()
        {
            Value = message.Value,
            DateCreated = message.DateCreated,
            DateLastEdited = message.DateLastEdited,
            Chat = chat,
            User = user,
            RepliedUser = repliedUser,
            VisibleToSender = message.VisibleToSender
        };
        await _chatContext.Messages.AddAsync(createdMsg);
        await _chatContext.SaveChangesAsync();

        message.Id = createdMsg.Id;
        await Clients.All.SendAsync("ReceiveMessage", message);
    }

    public async Task EditMessage(MessageDTO message)
    {
        await Clients.All.SendAsync("ReceiveEditedMessage", message);
    }
    
    public async Task DeleteMessage(MessageDTO message)
    {
        await Clients.All.SendAsync("ReceiveDeletedMessage", message);
    }
    
    public async Task CreateChat(ChatDTO chat)
    {
        await Clients.All.SendAsync("ReceiveCreatedChat", chat);
    }
}