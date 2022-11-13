using Microsoft.AspNetCore.SignalR;

namespace WebFlutterSignalR.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessageToEveryone(string userName, string message)
        {
            await Clients.All.SendAsync("MessageForEveryone", userName, message);
        }

        public async Task JoinGroup(string groupName)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
        }

        public async Task RemoveFromGroup(string groupName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, groupName);
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message)
        {
           await Clients.Group(groupName).SendAsync("SendMessageToGroup",  $"{userName}", $"{message}");
        }
    }
}
