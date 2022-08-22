using System.ComponentModel.DataAnnotations;

namespace SimpleChatApp_SignalR.Server.EF.Models;

public class BaseEntity
{
    [Key]
    public int Id { get; set; }
}