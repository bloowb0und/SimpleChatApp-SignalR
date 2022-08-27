namespace SimpleChatApp_SignalR.Shared.DTOs;

public class UserDTO
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public IEnumerable<int> ChatsIds { get; set; }
}