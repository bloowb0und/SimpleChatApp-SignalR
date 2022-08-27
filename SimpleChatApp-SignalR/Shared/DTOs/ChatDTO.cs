namespace SimpleChatApp_SignalR.Shared.DTOs;

public class ChatDTO
{
    public int Id { get; set; }
    public string Title { get; set; }
    public bool IsPrivate { get; set; }
    public IEnumerable<int> UsersIds { get; set; }
    public IEnumerable<int> MessagesIds { get; set; }
}