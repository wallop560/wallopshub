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
local start2 = UDim2.new(0.5,0,6,0)
local start = UDim2.new(1, 0,2.5, 0)
local stop = UDim2.new(5,0,6,0)
local T = .25
local T2 = 1
local function Tween(obj, tinfo, goal)
	game:GetService("TweenService"):Create(obj, tinfo, goal):Play()
end
-- Instances:
 
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local welcome = Instance.new("TextLabel")
local namehere = Instance.new("TextLabel")
local wallophub = Instance.new("TextLabel")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.DisplayOrder = 2
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(-1, 0,-2.5, 0)
Frame.Rotation = 34.000
Frame.Size = start2
Frame.ZIndex = 10
 
wallophub.Name = "wallophub"
wallophub.Parent = ScreenGui
wallophub.AnchorPoint = Vector2.new(0.5, 0.5)
wallophub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
wallophub.BackgroundTransparency = 1.000
wallophub.Position = UDim2.new(0.5, 0, 0.5, 0)
wallophub.Size = UDim2.new(0, 100, 0, 25)
wallophub.ZIndex = 11
wallophub.Font = Enum.Font.SourceSans
wallophub.Text = "Loading..."
wallophub.TextColor3 = Color3.fromRGB(175, 175, 175)
wallophub.TextSize = 30.000
wallophub.TextStrokeColor3 = Color3.fromRGB(175, 175, 175)
wallophub.TextTransparency = 1.000
 
-- Scripts:
 
 
 
spawn(function()
Frame:TweenSize(stop,Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,T)
	wait(.5)
Tween(wallophub,TweenInfo.new(T2,Enum.EasingStyle.Linear),{TextTransparency = 0})
	wait(10)
Tween(wallophub,TweenInfo.new(T2,Enum.EasingStyle.Linear),{TextTransparency = 1})
	wait(T2 - .5)
 
Frame:TweenPosition(start,Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,T)
	wait(T)
end)
wait(3)
loadstring(Scriptf)()
elseif GameInfo == false then
    print("Game Not Supported") -- what you want it to do when it does not support the game
end
