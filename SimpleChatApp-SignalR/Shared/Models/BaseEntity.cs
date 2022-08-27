using System.ComponentModel.DataAnnotations;

namespace SimpleChatApp_SignalR.Shared.Models;

public class BaseEntity
{
    [Key]
    public int Id { get; set; }
}