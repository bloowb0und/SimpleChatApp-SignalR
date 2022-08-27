using System.ComponentModel.DataAnnotations;

namespace SimpleChatApp_SignalR.Shared.Models;

public class Chat : BaseEntity
{
    [Required]
    public string Title { get; set; }

    [Required]
    public bool IsPrivate { get; set; }

    public ICollection<User> Users { get; set; }
    public ICollection<Message> Messages { get; set; }
}