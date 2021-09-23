local GameList = game:HttpGet("https://raw.githubusercontent.com/wallop560/wallopshub/main/game%20list.lua")
 
local HttpService = game:GetService("HttpService")
function GetGame()
    local GameList = HttpService:JSONDecode(GameList)
    if GameList[tostring(game.PlaceId)] then
        return GameList[tostring(game.PlaceId)]
    else
        return false
    end
end
 
local GameInfo = GetGame()
local Script
local GameName
if GameInfo then
Scriptf = game:HttpGet(GameInfo.ScriptLink)
GameName = GameInfo.GameName
 
print(GameName)   

loadstring(Scriptf)()
elseif GameInfo == false then
    print("Game Not Supported") -- what you want it to do when it does not support the game
end
