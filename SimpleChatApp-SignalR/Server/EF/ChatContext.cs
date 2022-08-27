using Microsoft.EntityFrameworkCore;
using SimpleChatApp_SignalR.Shared.Models;

namespace SimpleChatApp_SignalR.Server.EF;

public class ChatContext : DbContext
{
    public ChatContext(DbContextOptions options) : base(options) { }

    public DbSet<User> Users { get; set; }
    public DbSet<Chat> Chats { get; set; }
    public DbSet<Message> Messages { get; set; }
}