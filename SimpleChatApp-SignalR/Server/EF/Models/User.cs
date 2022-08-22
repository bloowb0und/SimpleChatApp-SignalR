using System.ComponentModel.DataAnnotations;

namespace SimpleChatApp_SignalR.Server.EF.Models;

public class User : BaseEntity
{
    [Required, MaxLength(50)]
    public string Username { get; set; }
    
    [Required]
    public string Password { get; set; }

    public ICollection<Chat> Chats { get; set; }
}