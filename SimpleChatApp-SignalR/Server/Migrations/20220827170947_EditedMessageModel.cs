using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SimpleChatApp_SignalR.Server.Migrations
{
    public partial class EditedMessageModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "RepliedUserId",
                table: "Messages",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "VisibleToSender",
                table: "Messages",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateIndex(
                name: "IX_Messages_RepliedUserId",
                table: "Messages",
                column: "RepliedUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_Users_RepliedUserId",
                table: "Messages",
                column: "RepliedUserId",
                principalTable: "Users",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Messages_Users_RepliedUserId",
                table: "Messages");

            migrationBuilder.DropIndex(
                name: "IX_Messages_RepliedUserId",
                table: "Messages");

            migrationBuilder.DropColumn(
                name: "RepliedUserId",
                table: "Messages");

            migrationBuilder.DropColumn(
                name: "VisibleToSender",
                table: "Messages");
        }
    }
}
