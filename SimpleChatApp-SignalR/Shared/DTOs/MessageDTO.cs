namespace SimpleChatApp_SignalR.Shared.DTOs;

public class MessageDTO
{
    public int Id { get; set; }
    public bool VisibleToSender { get; set; }
    public int UserId { get; set; }
    public string SenderUsername { get; set; }
    public int ChatId { get; set; }
    public string Value { get; set; }
    public DateTime DateCreated { get; set; }
    public DateTime? DateLastEdited { get; set; }
    public int? RepliedUserId { get; set; }
    public string? RepliedUserUsername { get; set; }
}