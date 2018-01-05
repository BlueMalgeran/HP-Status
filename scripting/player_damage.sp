#include <sourcemod>

public Plugin myinfo = {
	name = "HP Status",
	author = "Blue Malgeran",
	description = "Showing your damage to the players.",
	version = "0.1",
	url = "http://BlueMalgeran.tk"
};

public void OnPluginStart() {
	HookEvent("player_activate", event_player_activate, EventHookMode_Post);
	
	HookEvent("player_hurt", event_player_hurt, EventHookMode_Post);
}

public Action event_player_activate(Handle event, const char[] name, bool dontBroadcast) {
	int userid = GetEventInt(event, "userid");
	int client = GetClientOfUserId(userid);
	
	char s_name[64];
	GetClientName(client, s_name, sizeof(s_name));
	
	if ((GetUserFlagBits(client) & ADMFLAG_SLAY) || (GetUserFlagBits(client) & ADMFLAG_ROOT)) {
		PrintToChatAll("The admin: %s is connecting to the server.", s_name);
	} else if (GetUserFlagBits(client) & ADMFLAG_CUSTOM1 ) {
		PrintToChatAll("The VIP: %s is connecting to the server.", s_name);
	} else {
		PrintToChatAll("The player %s is connecting to the server.", s_name);
	}
}

public Action event_player_hurt(Handle event, const char[] name, bool dontBroadcast) {
	int userid = GetEventInt(event, "userid");
	int client = GetClientOfUserId(userid);
	
	if (client > 0 && IsClientConnected(client) && IsClientInGame(client)) {
		int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
		
		if(attacker > 0 && IsClientConnected(client) && IsClientInGame(client)) {
			int i_dmg = GetEventInt(event, "dmg_health");
			PrintHintText(attacker, "Damage: %i", i_dmg);
		}
	}
}
