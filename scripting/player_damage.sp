#include <sourcemod>

public Plugin myinfo = {
	name = "PlayerDMG",
	author = "Blue Malgeran",
	description = "Showing your damage to the players.",
	version = "0.1",
	url = "http://BlueMalgeran.tk"
};

public void OnPluginStart() {
	HookEvent("player_hurt", event_player_hurt, EventHookMode_Post);
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
