library = {}
library.ToggleBind = Enum.KeyCode.T
library.TabsBind = Enum.KeyCode.F
function Tween(obj, tinfo, goal)
   game:GetService("TweenService"):Create(obj, tinfo, goal):Play()
end

local yes = false
local OldM = game.Players.LocalPlayer.CameraMaxZoomDistance
local OldMin = game.Players.LocalPlayer.CameraMinZoomDistance
local TweenService = game:GetService("TweenService")
local defaults
do
   local dragger = {}
   do
      local mouse = game:GetService("Players").LocalPlayer:GetMouse()
      local inputService = game:GetService("UserInputService")
      local heartbeat = game:GetService("RunService").Heartbeat
      function newfdrag(frame, hold)
         if not hold then hold = frame end
         local dragging
         local dragInput
         local dragStart
         local startPos

         local function update(input)
            local delta = input.Position - dragStart
            Tween(frame, TweenInfo.new(.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)})
         end

         hold.InputBegan:Connect(function(input)
         if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
            end)
         end
         end)

         frame.InputChanged:Connect(function(input)
         if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
         end
         end)

         game:service("UserInputService").InputChanged:Connect(function(input)
         if input == dragInput and dragging then
            update(input)
         end
         end)
      end

      game:GetService("UserInputService").InputBegan:connect(
      function(key, gpe)
         if (not gpe) then
            if key.KeyCode == library.ToggleBind then
               library.toggled = not library.toggled
               yes = not library.toggled
               local CC = workspace.CurrentCamera
               local Char = game.Players.LocalPlayer.Character
               if Char:FindFirstChild("Head") then
                  local Zoom = (CC.CFrame.Position - Char.Head.Position).magnitude
                  if not yes then
                     game.Players.LocalPlayer.CameraMaxZoomDistance = OldM
                     game.Players.LocalPlayer.CameraMinZoomDistance = OldMin
                  elseif yes then
                     OldM = game.Players.LocalPlayer.CameraMaxZoomDistance
                     OldMin = game.Players.LocalPlayer.CameraMinZoomDistance
                     game.Players.LocalPlayer.CameraMaxZoomDistance = Zoom
                     game.Players.LocalPlayer.CameraMinZoomDistance = Zoom
                     yes = not yes
                  end
               end
            end
         end
      end
      )
   end
   local function Ripple(thing)
      local TweenService = game:GetService("TweenService")
      local mouse = game.Players.LocalPlayer:GetMouse()
      local x = mouse.X
      local y = mouse.Y
      local Circle = Instance.new("ImageLabel")

      Circle.Name = "Circle"

      Circle.BackgroundColor3 = Color3.new(1, 1, 1)
      Circle.BackgroundTransparency = 1
      Circle.ZIndex = 10
      Circle.Image = "rbxassetid://266543268"
      Circle.ImageColor3 = Color3.new(0, 0, 0)
      Circle.ImageTransparency = 0.5
      Circle.SliceScale = 1
      Circle.Position = UDim2.new(0, x - thing.AbsolutePosition.X, 0, y - thing.AbsolutePosition.Y)

      Circle.Parent = thing
      local was = thing.ClipsDescendants
      thing.ClipsDescendants = true
      TweenService:Create(
      Circle,
      TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
      {Size = UDim2.new(0, 200, 0, 200)}
      ):Play()
      TweenService:Create(
      Circle,
      TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
      {Position = Circle.Position - UDim2.new(0, 100, 0, 100)}
      ):Play()
      TweenService:Create(
      Circle,
      TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
      {ImageTransparency = 1}
      ):Play()
      spawn(function()
      wait(1)
      thing.ClipsDescendants = was
      Circle:Destroy()
   end
   )
end

function library:Window(Name)
   if not Name then
      Name = ""
   elseif Name then
      Name = tostring(Name)
   end

   --    //INSTANCES\\

   local lt2gui = Instance.new("ScreenGui")
   local TopBar = Instance.new("ImageLabel")
   local TopBar2 = Instance.new("Frame")
   local Body = Instance.new("ImageLabel")
   local BodyShading = Instance.new("ImageLabel")
   local TextLabel = Instance.new("TextLabel")
   local Screens = Instance.new("Frame")

   --   //PROPERTIES\\

   lt2gui.Name = game:GetService("HttpService"):GenerateGUID(false)
   lt2gui.ResetOnSpawn = false

   if game:GetService("RunService"):IsStudio() then
      lt2gui.Parent = game.Players.LocalPlayer.PlayerGui
   else
      lt2gui.Parent = game.CoreGui
   end

   TopBar.Name = "TopBar"
   TopBar.Parent = lt2gui
   TopBar.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
   TopBar.BackgroundTransparency = 1
   TopBar.Position = UDim2.new(0, 152, 0, 100)
   TopBar.Size = UDim2.new(0, 507, 0, 30)
   TopBar.ZIndex = 2
   TopBar.Image = "rbxassetid://3570695787"
   TopBar.ImageColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314)
   TopBar.ScaleType = Enum.ScaleType.Slice
   TopBar.SliceCenter = Rect.new(100, 100, 100, 100)
   TopBar.SliceScale = 0.05

   TopBar2.Name = "TopBar2"
   TopBar2.Parent = TopBar
   TopBar2.BackgroundColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314)
   TopBar2.BorderSizePixel = 0
   TopBar2.Position = UDim2.new(0, 0, 0.699999988, 0)
   TopBar2.Size = UDim2.new(0, 507, 0, 9)
   TopBar2.ZIndex = 3

   Body.Name = "Body"
   Body.Parent = TopBar2
   Body.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
   Body.BackgroundTransparency = 1
   Body.ClipsDescendants = true
   Body.Size = UDim2.new(0, 507, 0, 249)
   Body.Image = "rbxassetid://4641149554"
   Body.ImageColor3 = Color3.new(0.117647, 0.117647, 0.117647)
   Body.ScaleType = Enum.ScaleType.Slice
   Body.SliceCenter = Rect.new(100, 100, 100, 100)
   Body.SliceScale = 1

   BodyShading.Name = "BodyShading"
   BodyShading.Parent = TopBar2
   BodyShading.BackgroundColor3 = Color3.new(0, 0, 0)
   BodyShading.BackgroundTransparency = 1
   BodyShading.ClipsDescendants = true
   BodyShading.Position = UDim2.new(0, -15, 0, -36)
   BodyShading.Size = UDim2.new(0, 537, 0, 300)
   BodyShading.ZIndex = 4
   BodyShading.Image = "rbxassetid://5028857084"
   BodyShading.ImageColor3 = Color3.new(0, 0, 0)
   BodyShading.ScaleType = Enum.ScaleType.Slice
   BodyShading.SliceCenter = Rect.new(24, 24, 276, 276)
   BodyShading.SliceScale = 1

   TextLabel.Parent = TopBar
   TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
   TextLabel.BackgroundTransparency = 1
   TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
   TextLabel.Size = UDim2.new(0, 198, 0, 23)
   TextLabel.ZIndex = 3
   TextLabel.Font = Enum.Font.SourceSansBold
   TextLabel.Text = "╼ " .. Name .. " ╾"
   TextLabel.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
   TextLabel.TextSize = 25
   TextLabel.TextStrokeColor3 = Color3.new(1, 1, 1)

   Screens.Name = "Screens"
   Screens.Parent = Body
   Screens.BackgroundColor3 = Color3.new(1, 1, 1)
   Screens.BackgroundTransparency = 1
   Screens.Position = UDim2.new(0.0197238661, 0, 0.0682730898, 0)
   Screens.Size = UDim2.new(0.980276108, 0, 0.907630503, 0)
   Screens.ZIndex = 2

   newfdrag(TopBar)



   local UIS = game:GetService("UserInputService")
   local TS = game:GetService("TweenService")

   local toggle = true
   local orig = TopBar.Position
   local isfocus
   UIS.InputBegan:Connect(
   function(key)
      if key.KeyCode == library.ToggleBind then
         local focusedTextbox = UIS:GetFocusedTextBox()
         if focusedTextbox then
            isfocus = true
         else
            isfocus = false
         end
         if not isfocus then
            toggle = not toggle
            if toggle == false then
               orig = TopBar.Position
               TS:Create(
               TopBar,
               TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {Position = UDim2.new(0, -507, 0, TopBar.Position.Y.Offset)}
               ):Play()
            elseif toggle == true then
               TS:Create(
               TopBar,
               TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {Position = orig}
               ):Play()
            end
         end
      end
   end
   )
   local Tabs = {}
   counter = 0
   function Tabs:Tab(Name)
      if not Name then
         Name = ""
      elseif Name then
         Name = tostring(Name)
      end
      counter = counter + 1
      local Tab = Instance.new("ScrollingFrame")
      local Grid = Instance.new("UIGridLayout")
      local Order = Instance.new("NumberValue")
      local Title1 = Instance.new("Frame")
      local TitleTxt = Instance.new("TextLabel")
      local Title2 = Instance.new("Frame")

      Tab.Name = Name
      Tab.Parent = Screens
      Tab.Active = true
      Tab.BackgroundColor3 = Color3.new(1, 1, 1)
      Tab.BackgroundTransparency = 1
      Tab.BorderSizePixel = 0
      Tab.Size = UDim2.new(1, 0, 1, 0)
      Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
      Tab.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
      Tab.ScrollBarThickness = 0
      Tab.ScrollingEnabled = false
      if counter == 1 then
         Tab.Visible = true
      else
         Tab.Visible = false
      end
      Grid.Name = "Grid"
      Grid.Parent = Tab
      Grid.SortOrder = Enum.SortOrder.LayoutOrder
      Grid.CellPadding = UDim2.new(0, 70, 0, 5)
      Grid.CellSize = UDim2.new(0, 200, 0, 25)

      Order.Parent = Tab
      Order.Name = "Order"
      Order.Value = counter
      Title1.Parent = Tab
      Title1.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
      Title1.BackgroundTransparency = 1
      Title1.BorderSizePixel = 0
      Title1.Size = UDim2.new(0, 100, 0, 100)

      TitleTxt.Name = "Frame"
      TitleTxt.Parent = Title1
      TitleTxt.BackgroundColor3 = Color3.new(1, 1, 1)
      TitleTxt.BackgroundTransparency = 1
      TitleTxt.BorderSizePixel = 0
      TitleTxt.Size = UDim2.new(2.5, -13, 0.479999989, 10)
      TitleTxt.Text = "╼ " .. Name .. " ╾"
      TitleTxt.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
      TitleTxt.TextSize = 15

      Title2.Parent = Tab
      Title2.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
      Title2.BackgroundTransparency = 1
      Title2.BorderSizePixel = 0
      Title2.Size = UDim2.new(0, 100, 0, 100)
      local Stuff = {}
      function Stuff:Button(Text, callback)
         Text = Text or ""
         callback = callback or function() end

         local Button = Instance.new("Frame")
         local ButtonBack = Instance.new("ImageLabel")
         local ButtonBack2 = Instance.new("ImageLabel")
         local ButtonText = Instance.new("TextButton")

         Button.Name = "Button"
         Button.Parent = Tab
         Button.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
         Button.BackgroundTransparency = 1
         Button.BorderSizePixel = 0
         Button.Size = UDim2.new(0, 100, 0, 100)

         ButtonBack.Name = "ButtonBack"
         ButtonBack.Parent = Button
         ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack.BackgroundTransparency = 1
         ButtonBack.Size = UDim2.new(1, 0, 1, 0)
         ButtonBack.Image = "rbxassetid://3570695787"
         ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
         ButtonBack.ScaleType = Enum.ScaleType.Slice
         ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack.SliceScale = 0.05

         ButtonBack2.Name = "ButtonBack2"
         ButtonBack2.Parent = Button
         ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack2.BackgroundTransparency = 1
         ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
         ButtonBack2.Size = UDim2.new(1, -6, 1, -6)
         ButtonBack2.Image = "rbxassetid://3570695787"
         ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
         ButtonBack2.ScaleType = Enum.ScaleType.Slice
         ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack2.SliceScale = 0.05

         ButtonText.Name = "ButtonText"
         ButtonText.Parent = Button
         ButtonText.Active = false
         ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
         ButtonText.BackgroundTransparency = 1
         ButtonText.Selectable = false
         ButtonText.Size = UDim2.new(1, 0, 1, 0)
         ButtonText.Font = Enum.Font.SourceSansBold
         ButtonText.LineHeight = 1.1000000238419
         ButtonText.Text = Text
         ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         ButtonText.TextSize = 17

         local TS = game:GetService("TweenService")

         local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
         local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

         local ButtonDark1 = Color3.fromRGB(20, 20, 20)
         local ButtonDark2 = Color3.fromRGB(25, 25, 25)

         local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
         local ButtonPessed2 = Color3.fromRGB(55, 55, 55)

         Button.MouseEnter:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )

         Button.MouseLeave:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm2}
            ):Play()
         end
         )

         ButtonText.MouseButton1Click:Connect(
         function()
            Ripple(ButtonBack)
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed2}
            ):Play()
            spawn(function()
            callback()
            end)
            wait()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )
      end

      function Stuff:Box(Name, Type, callback)
         Name = Name or ""
         Type = Type or "String"
         callback = callback or function() end
         local Button = Instance.new("Frame")
         local ButtonBack = Instance.new("ImageLabel")
         local ButtonBack2 = Instance.new("ImageLabel")
         local ButtonText = Instance.new("TextBox")

         Button.Name = "Button"
         Button.Parent = Tab
         Button.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
         Button.BackgroundTransparency = 1
         Button.BorderSizePixel = 0
         Button.Size = UDim2.new(0, 100, 0, 100)

         ButtonBack.Name = "ButtonBack"
         ButtonBack.Parent = Button
         ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack.BackgroundTransparency = 1
         ButtonBack.Size = UDim2.new(1, 0, 1, 0)
         ButtonBack.Image = "rbxassetid://3570695787"
         ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
         ButtonBack.ScaleType = Enum.ScaleType.Slice
         ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack.SliceScale = 0.05

         ButtonBack2.Name = "ButtonBack2"
         ButtonBack2.Parent = Button
         ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack2.BackgroundTransparency = 1
         ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
         ButtonBack2.Size = UDim2.new(1, -6, 1, -6)
         ButtonBack2.Image = "rbxassetid://3570695787"
         ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
         ButtonBack2.ScaleType = Enum.ScaleType.Slice
         ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack2.SliceScale = 0.05

         ButtonText.Name = "ButtonText"
         ButtonText.Parent = Button
         ButtonText.Active = false
         ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
         ButtonText.BackgroundTransparency = 1
         ButtonText.Selectable = false
         ButtonText.Size = UDim2.new(1, 0, 1, 0)
         ButtonText.Font = Enum.Font.SourceSansBold
         ButtonText.LineHeight = 1.1000000238419
         ButtonText.Text = ""
         ButtonText.PlaceholderText = Name
         ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         ButtonText.TextSize = 17
         ButtonText.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)

         local TS = game:GetService("TweenService")

         local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
         local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

         local ButtonDark1 = Color3.fromRGB(20, 20, 20)
         local ButtonDark2 = Color3.fromRGB(25, 25, 25)

         local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
         local ButtonPessed2 = Color3.fromRGB(55, 55, 55)
         if Type == "Number" then
            ButtonText:GetPropertyChangedSignal("Text"):Connect(
            function()
               ButtonText.Text = ButtonText.Text:gsub("%D+", "")
            end
            )
         end
         Button.MouseEnter:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )

         Button.MouseLeave:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm2}
            ):Play()
         end
         )

         ButtonText.Focused:Connect(
         function()
            Ripple(ButtonBack)
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed2}
            ):Play()
            wait()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )
         ButtonText.FocusLost:Connect(
         function()
            spawn(function()
            callback(ButtonText.Text)
            end)
         end
         )
      end
      function Stuff:Bind(Name, Default, callback)
         Name = Name or ""
         Default = Default or Enum.KeyCode.G
         callback = callback or function()end
         local Toggle = Instance.new("Frame")
         local ButtonBack = Instance.new("ImageLabel")
         local ButtonBack2 = Instance.new("ImageLabel")
         local ButtonText = Instance.new("TextButton")
         local TextLabel = Instance.new("TextLabel")
         local ToggleBack_2 = Instance.new("ImageLabel")
         local TextButton = Instance.new("TextButton")

         Toggle.Name = "Toggle"
         Toggle.Parent = Tab
         Toggle.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
         Toggle.BackgroundTransparency = 1
         Toggle.BorderSizePixel = 0
         Toggle.Size = UDim2.new(1, 0, 1, 0)

         ButtonBack.Name = "ButtonBack"
         ButtonBack.Parent = Toggle
         ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack.BackgroundTransparency = 1
         ButtonBack.Size = UDim2.new(1, 0, 1, 0)
         ButtonBack.Image = "rbxassetid://3570695787"
         ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
         ButtonBack.ScaleType = Enum.ScaleType.Slice
         ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack.SliceScale = 0.05

         ButtonBack2.Name = "ButtonBack2"
         ButtonBack2.Parent = Toggle
         ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack2.BackgroundTransparency = 1
         ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
         ButtonBack2.Size = UDim2.new(0.694999993, -6, 1, -6)
         ButtonBack2.Image = "rbxassetid://3570695787"
         ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
         ButtonBack2.ScaleType = Enum.ScaleType.Slice
         ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack2.SliceScale = 0.05

         ButtonText.Name = "ButtonText"
         ButtonText.Parent = Toggle
         ButtonText.Active = false
         ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
         ButtonText.BackgroundTransparency = 1
         ButtonText.Selectable = false
         ButtonText.Size = UDim2.new(1, 0, 1, 0)
         ButtonText.Font = Enum.Font.SourceSansBold
         ButtonText.LineHeight = 1.1000000238419
         ButtonText.Text = ""
         ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         ButtonText.TextSize = 17
         ButtonText.ZIndex = 2

         TextLabel.Parent = Toggle
         TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
         TextLabel.BackgroundTransparency = 1
         TextLabel.Size = UDim2.new(0.680000007, -5, 1, 0)
         TextLabel.Font = Enum.Font.SourceSansBold
         TextLabel.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         TextLabel.TextSize = 17
         TextLabel.Text = Name

         ToggleBack_2.Name = "ToggleBack"
         ToggleBack_2.Parent = Toggle
         ToggleBack_2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ToggleBack_2.BackgroundTransparency = 1
         ToggleBack_2.ClipsDescendants = true
         ToggleBack_2.Position = UDim2.new(0, 147, 0, 3)
         ToggleBack_2.Size = UDim2.new(0.264999986, -6, 1, -6)
         ToggleBack_2.Image = "rbxassetid://3570695787"
         ToggleBack_2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
         ToggleBack_2.ScaleType = Enum.ScaleType.Slice
         ToggleBack_2.SliceCenter = Rect.new(100, 100, 100, 100)
         ToggleBack_2.SliceScale = 0.05

         TextButton.Parent = ToggleBack_2
         TextButton.BackgroundColor3 = Color3.new(1, 1, 1)
         TextButton.BackgroundTransparency = 1
         TextButton.Size = UDim2.new(1, 0, 1, 0)
         TextButton.Font = Enum.Font.SourceSansBold
         TextButton.Text = Default.Name
         TextButton.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         TextButton.TextSize = 16
         local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
         local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

         local ButtonDark1 = Color3.fromRGB(20, 20, 20)
         local ButtonDark2 = Color3.fromRGB(25, 25, 25)

         local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
         local ButtonPessed2 = Color3.fromRGB(55, 55, 55)

         ButtonText.MouseEnter:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ToggleBack_2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )

         ButtonText.MouseLeave:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm1}
            ):Play()
            TS:Create(
            ToggleBack_2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm2}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonNorm2}
            ):Play()
         end
         )

         ButtonText.MouseButton1Click:Connect(
         function()
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed1}
            ):Play()
            TS:Create(
            ToggleBack_2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed2}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonPessed2}
            ):Play()
            wait()

            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark1}
            ):Play()
            TS:Create(
            ToggleBack_2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
            TS:Create(
            ButtonBack2,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {ImageColor3 = ButtonDark2}
            ):Play()
         end
         )
         togglebindff = false
         local kb = Default
         ButtonText.MouseButton1Click:Connect(
         function()
            Ripple(ButtonText)
            TextButton.Text = "..."
            local key,gp = game:GetService('UserInputService').InputBegan:wait()
            TextButton.Text = tostring(key.KeyCode.Name)
            wait(0.05)
            callback(key.KeyCode)
            togglebindff = true
         end
         )

      end
      function Stuff:DropDown(Text, buttons, callback)
         Text = Text or ""
         buttons = buttons or {""}
         callback = callback or function()end

         local Button = Instance.new("Frame")
         local ButtonBack = Instance.new("ImageLabel")
         local ButtonBack2 = Instance.new("ImageLabel")
         local ButtonText = Instance.new("TextBox")
         local DropDownScroll = Instance.new("ScrollingFrame")

         Button.Name = "DropDown"
         Button.Parent = Tab
         Button.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
         Button.BackgroundTransparency = 1
         Button.BorderSizePixel = 0
         Button.Size = UDim2.new(0, 100, 0, 100)
         Button.ZIndex = 2
         ButtonBack.Name = "ButtonBack"
         ButtonBack.Parent = Button
         ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack.BackgroundTransparency = 1
         ButtonBack.Size = UDim2.new(1, 0, 1, 0)
         ButtonBack.Image = "rbxassetid://3570695787"
         ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
         ButtonBack.ScaleType = Enum.ScaleType.Slice
         ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack.SliceScale = 0.05
         ButtonBack.ZIndex = 2
         ButtonBack2.Name = "ButtonBack2"
         ButtonBack2.Parent = Button
         ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
         ButtonBack2.BackgroundTransparency = 1
         ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
         ButtonBack2.Size = UDim2.new(1, -6, 1, -6)
         ButtonBack2.Image = "rbxassetid://3570695787"
         ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
         ButtonBack2.ScaleType = Enum.ScaleType.Slice
         ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
         ButtonBack2.SliceScale = 0.05
         ButtonBack2.ZIndex = 2
         ButtonText.Name = "ButtonText"
         ButtonText.Parent = Button
         ButtonText.Active = false
         ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
         ButtonText.BackgroundTransparency = 1
         ButtonText.Selectable = false
         ButtonText.Size = UDim2.new(1, 0, 1, 0)
         ButtonText.Font = Enum.Font.SourceSansBold
         ButtonText.LineHeight = 1.1000000238419
         ButtonText.Text = ""
         ButtonText.PlaceholderText = Text
         ButtonText.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
         ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
         ButtonText.TextSize = 17
         ButtonText.ZIndex = 2
         ButtonBack.ClipsDescendants = true
         DropDownScroll.Name = "DropDownScroll"
         DropDownScroll.Parent = ButtonBack
         DropDownScroll.ScrollBarThickness = 0
         DropDownScroll.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
         DropDownScroll.BackgroundTransparency = 1
         DropDownScroll.Position = UDim2.new(0, 3, 0, 32)
         DropDownScroll.Size = UDim2.new(0, 197, 0, 90)
         DropDownScroll.ZIndex = 2
         local UIListLayout = Instance.new("UIListLayout")

         UIListLayout.Parent = DropDownScroll
         UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
         UIListLayout.Padding = UDim.new(0, 5)
         local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
         local ButtonNorm2 = Color3.fromRGB(28, 28, 28)
         local ButtonDark1 = Color3.fromRGB(20, 20, 20)
         local ButtonDark2 = Color3.fromRGB(25, 25, 25)
         local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
         local ButtonPessed2 = Color3.fromRGB(55, 55, 55)
         local ButtonsObj = {}
         for _, name in pairs(buttons) do
            local ButtonBack2 = Instance.new("ImageLabel")
            local ddb = Instance.new("TextButton")

            ButtonBack2.Name = "ButtonBack2"
            ButtonBack2.Parent = DropDownScroll
            ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
            ButtonBack2.BackgroundTransparency = 1
            ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
            ButtonBack2.Size = UDim2.new(0, 194, 0, 19)
            ButtonBack2.Image = "rbxassetid://3570695787"
            ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
            ButtonBack2.ScaleType = Enum.ScaleType.Slice
            ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
            ButtonBack2.SliceScale = 0.05
            ButtonBack2.ZIndex = 2
            ddb.Name = "DropDownButton"
            ddb.Parent = ButtonBack2
            ddb.Active = false
            ddb.BackgroundColor3 = Color3.new(0.784314, 0, 0)
            ddb.BackgroundTransparency = 1
            ddb.Position = UDim2.new(0, -3, 0, -3)
            ddb.Selectable = false
            ddb.Size = UDim2.new(0, 200, 0, 25)
            ddb.Font = Enum.Font.SourceSansBold
            ddb.LineHeight = 1.1000000238419
            ddb.Text = name
            ddb.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
            ddb.TextSize = 17
            ddb.ZIndex = 2
            ButtonsObj[name] = ButtonBack2
            ddb.MouseEnter:Connect(
            function()
               TS:Create(
               ButtonBack2,
               TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
               {ImageColor3 = ButtonDark2}
               ):Play()
            end
            )
            ddb.MouseLeave:Connect(
            function()
               TS:Create(
               ButtonBack2,
               TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
               {ImageColor3 = ButtonNorm2}
               ):Play()
            end
            )

            ddb.MouseButton1Click:Connect(
            function()
               TS:Create(
               ButtonBack2,
               TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
               {ImageColor3 = ButtonPessed2}
               ):Play()
               Ripple(ddb)
               wait()
               spawn(function()
               callback(name)
               end)
               TS:Create(
               ButtonBack2,
               TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
               {ImageColor3 = ButtonDark2}
               ):Play()

               for i = 1, #name do
                  local stringsub = name:sub(1, i)
                  ButtonText.Text = stringsub
                  wait()
               end
            end
            )
         end
         local function Refresh(Table)
            for i,v in pairs(ButtonsObj) do
               v:Destroy()
            end
            ButtonsObj = {}
            for _, name in pairs(Table) do
               local ButtonBack2 = Instance.new("ImageLabel")
               local ddb = Instance.new("TextButton")

               ButtonBack2.Name = "ButtonBack2"
               ButtonBack2.Parent = DropDownScroll
               ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
               ButtonBack2.BackgroundTransparency = 1
               ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
               ButtonBack2.Size = UDim2.new(0, 194, 0, 19)
               ButtonBack2.Image = "rbxassetid://3570695787"
               ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
               ButtonBack2.ScaleType = Enum.ScaleType.Slice
               ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
               ButtonBack2.SliceScale = 0.05
               ButtonBack2.ZIndex = 2
               ddb.Name = "DropDownButton"
               ddb.Parent = ButtonBack2
               ddb.Active = false
               ddb.BackgroundColor3 = Color3.new(0.784314, 0, 0)
               ddb.BackgroundTransparency = 1
               ddb.Position = UDim2.new(0, -3, 0, -3)
               ddb.Selectable = false
               ddb.Size = UDim2.new(0, 200, 0, 25)
               ddb.Font = Enum.Font.SourceSansBold
               ddb.LineHeight = 1.1000000238419
               ddb.Text = name
               ddb.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
               ddb.TextSize = 17
               ddb.ZIndex = 2
               ButtonsObj[name] = ButtonBack2
               ddb.MouseEnter:Connect(
               function()
                  TS:Create(
                  ButtonBack2,
                  TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                  {ImageColor3 = ButtonDark2}
                  ):Play()
               end
               )
               ddb.MouseLeave:Connect(
               function()
                  TS:Create(
                  ButtonBack2,
                  TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                  {ImageColor3 = ButtonNorm2}
                  ):Play()
               end
               )

               ddb.MouseButton1Click:Connect(
               function()
                  TS:Create(
                  ButtonBack2,
                  TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                  {ImageColor3 = ButtonPessed2}
                  ):Play()
                  Ripple(ddb)
                  wait()
                  spawn(function()
                  callback(name)
                  end)
                  TS:Create(
                  ButtonBack2,
                  TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                  {ImageColor3 = ButtonDark2}
                  ):Play()

                  for i = 1, #name do
                     local stringsub = name:sub(1, i)
                     ButtonText.Text = stringsub
                     wait()
                  end
               end
               )
            end
         end

         local focused = false
         ButtonText:GetPropertyChangedSignal("Text"):Connect(function()
         local Text = ButtonText.Text
         if Text == "" then
            for i, v in pairs(ButtonsObj) do
               v.Visible = true
            end
         else
            for i, v in pairs(ButtonsObj) do
               if string.find(string.lower(i), string.lower(Text)) then
                  if not focused then
                     wait(0.11)
                  end
                  v.Visible = true
               elseif not string.find(string.lower(i), string.lower(Text)) then
                  v.Visible = false
               end
            end
         end
         DropDownScroll.CanvasSize =
         UDim2.new(
         0,
         UIListLayout.AbsoluteContentSize.X,
         0,
         UIListLayout.AbsoluteContentSize.Y
         )
      end
      )

      local TS = game:GetService("TweenService")

      local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
      local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

      local ButtonDark1 = Color3.fromRGB(20, 20, 20)
      local ButtonDark2 = Color3.fromRGB(25, 25, 25)

      local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
      local ButtonPessed2 = Color3.fromRGB(55, 55, 55)

      ButtonBack.MouseEnter:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
         if not focused then
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 1.3, 0)}
            ):Play()
         end
      end
      )

      ButtonBack.MouseLeave:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm2}
         ):Play()

         if not focused then
            TS:Create(
            ButtonBack,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 1, 0)}
            ):Play()
         end
      end
      )
      ButtonText.FocusLost:Connect(
      function()


         focused = false
         wait(0.1)
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {Size = UDim2.new(1, 0, 1, 0)}
         ):Play()
         spawn(function()
         wait(.1)
         for i,v in next,ButtonsObj do
            v.ZIndex = 2
            v.DropDownButton.ZIndex = 2
         end
         ButtonText.ZIndex = 2
         ButtonBack2.ZIndex = 2
         ButtonBack.ZIndex = 2
         end)
      end
      )
      DropDownScroll.CanvasSize =
      UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y)
      ButtonText.Focused:Connect(
      function()
         for i,v in next,ButtonsObj do
            v.ZIndex = 3
            v.DropDownButton.ZIndex = 3
         end
         ButtonText.ZIndex = 3
         ButtonBack2.ZIndex = 3
         ButtonBack.ZIndex = 3
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonPessed1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonPessed2}
         ):Play()
         Ripple(ButtonText)
         wait()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
         focused = true
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
         {Size = UDim2.new(1, 0, 5, 0)}
         ):Play()
      end
      )
      return {refresh = Refresh}
   end

   function Stuff:Toggle(Name, Default, CallBack)
      Name = Name or ""
      Default = Default or false
      CallBack = CallBack or function()end
      local Toggle = Instance.new("Frame")
      local ButtonBack = Instance.new("ImageLabel")
      local ButtonBack2 = Instance.new("ImageLabel")
      local ButtonText = Instance.new("TextButton")
      local ToggleBack = Instance.new("ImageLabel")
      local ToggleBit = Instance.new("ImageLabel")
      local TextLabel = Instance.new("TextLabel")

      Toggle.Name = "Toggle"
      Toggle.Parent = Tab
      Toggle.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
      Toggle.BackgroundTransparency = 1
      Toggle.BorderSizePixel = 0
      Toggle.Size = UDim2.new(0, 100, 0, 100)

      ButtonBack.Name = "ButtonBack"
      ButtonBack.Parent = Toggle
      ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ButtonBack.BackgroundTransparency = 1
      ButtonBack.Size = UDim2.new(1, 0, 1, 0)
      ButtonBack.Image = "rbxassetid://3570695787"
      ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
      ButtonBack.ScaleType = Enum.ScaleType.Slice
      ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
      ButtonBack.SliceScale = 0.05

      ButtonBack2.Name = "ButtonBack2"
      ButtonBack2.Parent = Toggle
      ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ButtonBack2.BackgroundTransparency = 1
      ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
      ButtonBack2.Size = UDim2.new(0.694999993, -6, 1, -6)
      ButtonBack2.Image = "rbxassetid://3570695787"
      ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
      ButtonBack2.ScaleType = Enum.ScaleType.Slice
      ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
      ButtonBack2.SliceScale = 0.05

      ButtonText.Name = "ButtonText"
      ButtonText.Parent = Toggle
      ButtonText.Active = false
      ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
      ButtonText.BackgroundTransparency = 1
      ButtonText.Selectable = false
      ButtonText.Size = UDim2.new(1, 0, 1, 0)
      ButtonText.Font = Enum.Font.SourceSansBold
      ButtonText.LineHeight = 1.1000000238419
      ButtonText.Text = ""
      ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
      ButtonText.TextSize = 17

      ToggleBack.Name = "ToggleBack"
      ToggleBack.Parent = Toggle
      ToggleBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ToggleBack.BackgroundTransparency = 1
      ToggleBack.Position = UDim2.new(0, 147, 0, 3)
      ToggleBack.Size = UDim2.new(0.264999986, -6, 1, -6)
      ToggleBack.Image = "rbxassetid://3570695787"
      ToggleBack.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
      ToggleBack.ScaleType = Enum.ScaleType.Slice
      ToggleBack.SliceCenter = Rect.new(100, 100, 100, 100)
      ToggleBack.SliceScale = 0.05

      ToggleBit.Name = "ToggleBit"
      ToggleBit.Parent = ToggleBack
      ToggleBit.AnchorPoint = Vector2.new(0, 0.5)
      ToggleBit.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ToggleBit.BackgroundTransparency = 1
      ToggleBit.Position = UDim2.new(0.5, 0, 0.5, 0)
      ToggleBit.Size = UDim2.new(0.5, 0, 1, 0)
      ToggleBit.Image = "rbxassetid://3570695787"
      ToggleBit.ImageColor3 = Color3.new(0.196078, 0.196078, 0.196078)
      ToggleBit.ScaleType = Enum.ScaleType.Slice
      ToggleBit.SliceCenter = Rect.new(100, 100, 100, 100)
      ToggleBit.SliceScale = 0.05

      TextLabel.Parent = Toggle
      TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
      TextLabel.BackgroundTransparency = 1
      TextLabel.Size = UDim2.new(0.680000007, 0, 1, 0)
      TextLabel.Font = Enum.Font.SourceSansBold
      TextLabel.Text = Name
      TextLabel.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
      TextLabel.TextSize = 17

      --//button scripts

      local toggled = Default
      local toggleOn = UDim2.new(0.5, 0, 0.5, 0)
      local toggleOff = UDim2.new(0, 0, 0.5, 0)

      if toggled == true then
         ToggleBit.Position = toggleOn
      else
         ToggleBit.Position = toggleOff
      end

      local TS = game:GetService("TweenService")

      local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
      local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

      local ButtonDark1 = Color3.fromRGB(20, 20, 20)
      local ButtonDark2 = Color3.fromRGB(25, 25, 25)

      local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
      local ButtonPessed2 = Color3.fromRGB(55, 55, 55)

      ButtonText.MouseEnter:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark1}
         ):Play()
         TS:Create(
         ToggleBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
      end
      )

      ButtonText.MouseLeave:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm1}
         ):Play()
         TS:Create(
         ToggleBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm2}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm2}
         ):Play()
      end
      )

      ButtonText.MouseButton1Click:Connect(
      function()
         Ripple(ButtonText)
         toggled = not toggled

         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonPessed1}
         ):Play()
         TS:Create(
         ToggleBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonPessed2}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonPessed2}
         ):Play()
         wait()
         if toggled == false then
            TS:Create(
            ToggleBit,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = toggleOff}
            ):Play()
         else
            TS:Create(
            ToggleBit,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = toggleOn}
            ):Play()
         end
         spawn(function()
         CallBack(toggled)
         end)
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark1}
         ):Play()
         TS:Create(
         ToggleBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
      end
      )

      --button end\\
   end
   function Stuff:Label(Text, size)
      Text = Text or ""
      size = size or 13
      local lab = Instance.new("TextLabel")
      lab.Parent = Tab
      lab.TextColor3 = Color3.fromRGB(150, 150, 150)
      lab.TextSize = size
      lab.BackgroundTransparency = 1
      lab.Text = Text
   end
   function Stuff:Slider(Name, StartAmmount, EndAmmount, Default, callback)
      callback = callback or function()end
      Name = Name or ""
      StartAmmount = StartAmmount or 0
      EndAmmount = EndAmmount or 100
      Default = Default or 10

      local Slider = Instance.new("Frame")
      local ButtonBack = Instance.new("ImageLabel")
      local ButtonBack2 = Instance.new("ImageLabel")
      local ButtonText = Instance.new("TextButton")
      local ButtonText_2 = Instance.new("TextLabel")
      local SliderButton = Instance.new("TextButton")

      Slider.Name = "Slider"
      Slider.Parent = Tab
      Slider.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
      Slider.BackgroundTransparency = 1
      Slider.BorderSizePixel = 0
      Slider.Size = UDim2.new(1, 0, 1, 0)

      ButtonBack.Name = "ButtonBack"
      ButtonBack.Parent = Slider
      ButtonBack.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ButtonBack.BackgroundTransparency = 1
      ButtonBack.Size = UDim2.new(1, 0, 1, 0)
      ButtonBack.Image = "rbxassetid://3570695787"
      ButtonBack.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
      ButtonBack.ScaleType = Enum.ScaleType.Slice
      ButtonBack.SliceCenter = Rect.new(100, 100, 100, 100)
      ButtonBack.SliceScale = 0.05

      ButtonBack2.Name = "ButtonBack2"
      ButtonBack2.Parent = Slider
      ButtonBack2.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
      ButtonBack2.BackgroundTransparency = 1
      ButtonBack2.Position = UDim2.new(0, 3, 0, 3)
      ButtonBack2.Size = UDim2.new(1, -6, 1, -6)
      ButtonBack2.Image = "rbxassetid://3570695787"
      ButtonBack2.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
      ButtonBack2.ScaleType = Enum.ScaleType.Slice
      ButtonBack2.SliceCenter = Rect.new(100, 100, 100, 100)
      ButtonBack2.SliceScale = 0.05

      ButtonText.Name = "ButtonText"
      ButtonText.Parent = Slider
      ButtonText.Active = false
      ButtonText.BackgroundColor3 = Color3.new(0.784314, 0, 0)
      ButtonText.BackgroundTransparency = 1
      ButtonText.Selectable = false
      ButtonText.Size = UDim2.new(1, -5, 1, 0)
      ButtonText.Font = Enum.Font.SourceSansBold
      ButtonText.LineHeight = 1.1000000238419
      ButtonText.Text = Default
      ButtonText.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
      ButtonText.TextSize = 17
      ButtonText.TextXAlignment = Enum.TextXAlignment.Right

      ButtonText_2.Name = "ButtonText"
      ButtonText_2.Parent = Slider
      ButtonText_2.BackgroundColor3 = Color3.new(0.784314, 0, 0)
      ButtonText_2.BackgroundTransparency = 1
      ButtonText_2.Position = UDim2.new(0, 5, 0, 0)
      ButtonText_2.Size = UDim2.new(1, -5, 1, 0)
      ButtonText_2.Font = Enum.Font.SourceSansBold
      ButtonText_2.LineHeight = 1.1000000238419
      ButtonText_2.Text = Name
      ButtonText_2.TextColor3 = Color3.new(0.588235, 0.588235, 0.588235)
      ButtonText_2.TextSize = 17
      ButtonText_2.TextXAlignment = Enum.TextXAlignment.Left

      SliderButton.Name = "SliderButton"
      SliderButton.Parent = Slider
      SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
      SliderButton.BackgroundTransparency = 1
      SliderButton.Size = UDim2.new(1, 0, 1, 0)
      SliderButton.Font = Enum.Font.SourceSans
      SliderButton.TextColor3 = Color3.new(0, 0, 0)
      SliderButton.TextSize = 14
      SliderButton.TextTransparency = 1

      --//button scripts

      local Button = SliderButton
      local ButtonButton = ButtonText

      local TS = game:GetService("TweenService")

      local ButtonNorm1 = Color3.fromRGB(25, 25, 25)
      local ButtonNorm2 = Color3.fromRGB(28, 28, 28)

      local ButtonDark1 = Color3.fromRGB(20, 20, 20)
      local ButtonDark2 = Color3.fromRGB(25, 25, 25)

      local ButtonPessed1 = Color3.fromRGB(50, 50, 50)
      local ButtonPessed2 = Color3.fromRGB(55, 55, 55)

      Button.MouseEnter:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonDark2}
         ):Play()
      end
      )

      Button.MouseLeave:Connect(
      function()
         TS:Create(
         ButtonBack,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm1}
         ):Play()
         TS:Create(
         ButtonBack2,
         TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
         {ImageColor3 = ButtonNorm2}
         ):Play()
      end
      )

      local mouse = game.Players.LocalPlayer:GetMouse()
      local uis = game:GetService("UserInputService")
      local Value

      local origsize = ButtonBack2.AbsoluteSize
      ButtonBack2.Size =
      UDim2.new(
      0,
      math.clamp((ButtonBack2.AbsoluteSize.X / EndAmmount) * Default, 0, origsize.X),
      0,
      origsize.Y
      )
      spawn(function()
      callback(Default)
      end)
      SliderButton.MouseButton1Up:Connect(
      function()
         Ripple(SliderButton)
      end
      )
      SliderButton.MouseButton1Down:Connect(
      function()
         ButtonBack2.Size =
         UDim2.new(
         0,
         math.clamp(mouse.X - ButtonBack2.AbsolutePosition.X, 0, origsize.X),
         0,
         origsize.Y
         )
         Value =
         math.floor(
         (((tonumber(EndAmmount) - tonumber(StartAmmount)) / origsize.X) *
         ButtonBack2.AbsoluteSize.X) +
         tonumber(StartAmmount)
         ) or 0
         ButtonText.Text = Value
         pcall(
         function()
            callback(Value)
         end
         )

         moveconnection =
         mouse.Move:Connect(
         function()
            ButtonText.Text = Value
            Value =
            math.floor(
            (((tonumber(EndAmmount) - tonumber(StartAmmount)) / origsize.X) *
            ButtonBack2.AbsoluteSize.X) +
            tonumber(StartAmmount)
            )
            pcall(
            function()
               spawn(function()
               callback(Value)
               end)
            end
            )
            ButtonBack2.Size =
            UDim2.new(
            0,
            math.clamp(mouse.X - ButtonBack2.AbsolutePosition.X, 0, origsize.X),
            0,
            origsize.Y
            )
         end
         )
         releaseconnection =
         uis.InputEnded:Connect(
         function(Mouse)
            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
               Value =
               math.floor(
               (((tonumber(EndAmmount) - tonumber(StartAmmount)) / origsize.X) *
               ButtonBack2.AbsoluteSize.X) +
               tonumber(StartAmmount)
               )
               pcall(
               function()
                  spawn(function()
                  callback(Value)
                  end)
               end
               )
               ButtonBack2.Size =
               UDim2.new(
               0,
               math.clamp(mouse.X - ButtonBack2.AbsolutePosition.X, 0, origsize.X),
               0,
               origsize.Y
               )
               moveconnection:Disconnect()
               releaseconnection:Disconnect()
            end
         end
         )
      end
      )

      --button end\\
   end
   return Stuff
end
spawn(
function()
   wait(0.1)
   for _, v in pairs(Screens:GetChildren()) do
      if v:IsA("ScrollingFrame") then
         v.CanvasSize =
         UDim2.new(0, 0, 0, v:FindFirstChildOfClass("UIGridLayout").AbsoluteContentSize.Y)
      end
   end
end
)
spawn(function()
local timeT = 0.5
local TS = game:GetService("TweenService")
local mouse = game.Players.LocalPlayer:GetMouse()
local dont = {}
local dontText = {}
local dontImage = {}
function switchUp(Name)
   for i, v in pairs(Screens:GetChildren()) do
      if v.Visible then
         if v:IsA("ScrollingFrame") then
            for i, v in pairs(v:GetDescendants()) do
               if v.Parent.Name ~= "DropDownScroll" and v.Parent.Parent.Name ~= "DropDownScroll" then
                  if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                  elseif v:IsA("TextButton") or v:IsA("TextLabel") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.TextTransparency ~= 1 then
                        local orig2 = v.TextTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.TextTransparency = orig2
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                     if v.TextTransparency == 1 and not dontText[v] then
                        dontText[v] = v
                     end
                  elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.ImageTransparency ~= 1 then
                        local orig2 = v.ImageTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.ImageTransparency = orig2
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                     if v.ImageTransparency == 1 and not dontImage[v] then
                        dontImage[v] = v
                     end
                  end
               end
            end
            local old = v.Position

            v:TweenPosition(
            v.Position + UDim2.new(0, 0, -1, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            timeT
            )
            spawn(
            function()
               wait(timeT)
               v.Position = old
               if v.Name ~= Name.Name then
                  v.Visible = false
               end
            end
            )
         end
      end
   end
   wait(timeT)
   local screen = Name

   screen.Visible = true

   local old = UDim2.new(0, 0, 0, 0)
   screen.Position = UDim2.new(0, 0, 1, 0)
   screen:TweenPosition(old, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, timeT)

   for i, v in pairs(screen:GetDescendants()) do
      if v.Parent.Name ~= "DropDownScroll" and v.Parent.Parent.Name ~= "DropDownScroll" then
         local dont1 = false
         local dont2 = false
         local dont3 = false
         for _, item in pairs(dont) do
            if v.Name == item.Name then
               dont1 = true
            end
         end
         for _, item in pairs(dontText) do
            if v.Name == item.Name then
               dont2 = true
            end
         end
         for _, item in pairs(dontImage) do
            if v.Name == item.Name then
               dont3 = true
            end
         end
         if v:IsA("Frame") or v:IsA("ScrollingFrame") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end
         elseif v:IsA("TextButton") or v:IsA("TextLabel") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end

            if dont2 == false then
               local orig2 = v.TextTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {TextTransparency = 0}
               ):Play()
            end
         elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end

            if dont3 == false then
               local orig2 = v.ImageTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {ImageTransparency = 0}
               ):Play()
            end
         end
      end
   end
   wait(1)
end

function switchDown(Name)
   for i, v in pairs(Screens:GetChildren()) do
      if v.Visible then
         if v.Parent.Name ~= "DropDownScroll" and v.Parent.Parent.Name ~= "DropDownScroll" then
            if v:IsA("ScrollingFrame") then
               for i, v in pairs(v:GetDescendants()) do
                  if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                  elseif v:IsA("TextButton") or v:IsA("TextLabel") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.TextTransparency ~= 1 then
                        local orig2 = v.TextTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.TextTransparency = orig2
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                     if v.TextTransparency == 1 and not dontText[v] then
                        dontText[v] = v
                     end
                  elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
                     if v.BackgroundTransparency ~= 1 then
                        local orig = v.BackgroundTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.BackgroundTransparency = orig
                        end
                        )
                     end
                     if v.ImageTransparency ~= 1 then
                        local orig2 = v.ImageTransparency
                        TS:Create(
                        v,
                        TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 1}
                        ):Play()
                        spawn(
                        function()
                           wait(timeT)
                           v.ImageTransparency = orig2
                        end
                        )
                     end
                     if v.BackgroundTransparency == 1 and not dont[v] then
                        dont[v] = v
                     end
                     if v.ImageTransparency == 1 and not dontImage[v] then
                        dontImage[v] = v
                     end
                  end
               end
               local old = v.Position
               v:TweenPosition(
               v.Position + UDim2.new(0, 0, 1, 0),
               Enum.EasingDirection.Out,
               Enum.EasingStyle.Quad,
               timeT
               )
               spawn(
               function()
                  wait(timeT)
                  v.Position = old
                  if v.Name ~= Name.Name then
                     v.Visible = false
                  end
               end
               )
            end
         end
      end
   end
   wait(timeT)
   local screen = Name

   screen.Visible = true

   local old = UDim2.new(0, 0, 0, 0)
   screen.Position = UDim2.new(0, 0, -1, 0)
   screen:TweenPosition(old, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, timeT)

   for i, v in pairs(screen:GetDescendants()) do
      if v.Parent.Name ~= "DropDownScroll" and v.Parent.Parent.Name ~= "DropDownScroll" then
         local dont1 = false
         local dont2 = false
         local dont3 = false
         for _, item in pairs(dont) do
            if v.Name == item.Name then
               dont1 = true
            end
         end
         for _, item in pairs(dontText) do
            if v.Name == item.Name then
               dont2 = true
            end
         end
         for _, item in pairs(dontImage) do
            if v.Name == item.Name then
               dont3 = true
            end
         end
         if v:IsA("Frame") or v:IsA("ScrollingFrame") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end
         elseif v:IsA("TextButton") or v:IsA("TextLabel") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end

            if dont2 == false then
               local orig2 = v.TextTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {TextTransparency = 0}
               ):Play()
            end
         elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
            if dont == false then
               local orig = v.BackgroundTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0}
               ):Play()
            end

            if dont3 == false then
               local orig2 = v.ImageTransparency
               TS:Create(
               v,
               TweenInfo.new(timeT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {ImageTransparency = 0}
               ):Play()
            end
         end
      end
   end
   wait(1)
end
local currentTab = 1
local maxnumber = 0
spawn(
function()
   wait(0.1)
   maxnumber = #Screens:GetChildren()
end
)
local cooldownscroll = 1

local tabskey = library.TabsBind

local CC = workspace.CurrentCamera
local Char = game.Players.LocalPlayer.Character
if Char:FindFirstChild("Head") then
   local Zoom = (CC.CFrame.Position - Char.Head.Position).magnitude
   game.Players.LocalPlayer.CameraMaxZoomDistance = Zoom
   game.Players.LocalPlayer.CameraMinZoomDistance = Zoom
end

local isfocus
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(
function(key)
   if key.KeyCode == library.TabsBind then
      local CC = workspace.CurrentCamera
      local Char = game.Players.LocalPlayer.Character
      if Char:FindFirstChild("Head") then
         local Zoom = (CC.CFrame.Position - Char.Head.Position).magnitude
         local focusedTextbox = uis:GetFocusedTextBox()
         if focusedTextbox then
            isfocus = true
         else
            isfocus = false
         end
         if not isfocus then
            yes = not yes

            if not yes then
               OldM = game.Players.LocalPlayer.CameraMaxZoomDistance
               OldMin = game.Players.LocalPlayer.CameraMinZoomDistance
               game.Players.LocalPlayer.CameraMaxZoomDistance = Zoom
               game.Players.LocalPlayer.CameraMinZoomDistance = Zoom
            else
               game.Players.LocalPlayer.CameraMaxZoomDistance = OldM
               game.Players.LocalPlayer.CameraMinZoomDistance = OldMin
            end
            for i, v in pairs(Screens:GetChildren()) do
               if v:IsA("ScrollingFrame") then
                  v.ScrollingEnabled = yes
               end
            end

         end
      end
   end
end
)

local ActionS = game:GetService("ContextActionService")

function handler(name, state, input)
   print(yes)
   if input.Position.Z == 1 then
      if yes == false then
         if cooldownscroll == 1 then
            cooldownscroll = 0
            currentTab = currentTab + 1
            if currentTab >= maxnumber + 1 then
               currentTab = 1
            end
            for i, v in pairs(Screens:GetChildren()) do
               if v:IsA("ScrollingFrame") then
                  if v:FindFirstChild("Order") then
                     if v.Order.Value == currentTab then
                        spawn(
                        function()
                           switchUp(v)
                        end
                        )
                     end
                  end
               end
            end
            spawn(
            function()
               if cooldownscroll == 0 then
                  wait(timeT * 2)
                  cooldownscroll = 1
               end
            end
            )
         end
      end
   else
      if yes == false then
         if cooldownscroll == 1 then
            cooldownscroll = 0
            currentTab = currentTab - 1
            if currentTab == 0 or currentTab <= 0 then
               currentTab = maxnumber
            end
            for i, v in pairs(Screens:GetChildren()) do
               if v:IsA("ScrollingFrame") then
                  if v:FindFirstChild("Order") then
                     if v.Order.Value == currentTab then
                        spawn(
                        function()
                           switchDown(v)
                        end
                        )
                     end
                  end
               end
            end
            spawn(
            function()
               wait(timeT)
               cooldownscroll = 1
            end
            )
         end
      end
   end
end

local UserInputService = game:GetService("UserInputService")

UserInputService.InputChanged:Connect(
function(input, gameProcessed)
   if input.UserInputType == Enum.UserInputType.MouseWheel then
      local keyPressed = input.KeyCode
      local focusedTextbox = UIS:GetFocusedTextBox()
      if focusedTextbox then
         isfocus = true
      else
         isfocus = false
      end
      if not isfocus then
         handler(0, 0, input)
      end
   end
end
)
end)
function library:Confirm(Titletxt, Texttxt, callback)
   if not Titletxt then
      Titletxt = ""
   elseif Titletxt then
      Titletxt = tostring(Titletxt)
   end
   if not Texttxt then
      Texttxt = ""
   elseif Texttxt then
      Texttxt = tostring(Texttxt)
   end
   if not callback then
      callback = function()
   end
end
spawn(
function()
   local Notification = Instance.new("TextButton")
   local Body = Instance.new("ImageLabel")
   local Body2 = Instance.new("ImageLabel")
   local PurpleStrip = Instance.new("Frame")
   local Title = Instance.new("TextLabel")
   local Text = Instance.new("TextLabel")

   Notification.Name = "Notification"
   Notification.Parent = lt2gui
   Notification.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
   Notification.BackgroundTransparency = 1
   Notification.AnchorPoint = Vector2.new(1, 1)
   Notification.ClipsDescendants = false
   Notification.Position = UDim2.new(1, 200, 1, -10)
   local normnoti = UDim2.new(1, -10, 1, -10)
   local notnoti = UDim2.new(1, 200, 1, -10)
   Notification.Size = UDim2.new(0, 200, 0, 59)
   Notification.Font = Enum.Font.SourceSans
   Notification.TextColor3 = Color3.new(0, 0, 0)
   Notification.TextSize = 1
   Notification.TextTransparency = 1

   Body.Name = "Body"
   Body.Parent = Notification
   Body.BackgroundColor3 = Color3.new(1, 1, 1)
   Body.BackgroundTransparency = 1
   Body.Size = UDim2.new(1, 0, 1, 0)
   Body.Image = "rbxassetid://3570695787"
   Body.ImageColor3 = Color3.fromRGB(30, 30, 30)
   Body.ScaleType = Enum.ScaleType.Slice
   Body.SliceCenter = Rect.new(100, 100, 100, 100)
   Body.SliceScale = 0.09

   Body2.Name = "Body"
   Body2.Parent = Body
   Body2.BackgroundColor3 = Color3.new(1, 1, 1)
   Body2.BackgroundTransparency = 1
   Body2.Size = UDim2.new(1, 0, 0.3, 15)
   Body2.Image = "rbxassetid://3570695787"
   Body2.ImageColor3 = Color3.fromRGB(20, 20, 20)
   Body2.ScaleType = Enum.ScaleType.Slice
   Body2.SliceCenter = Rect.new(100, 100, 100, 100)
   Body2.SliceScale = 0.09

   PurpleStrip.Name = "PurpleStrip"
   PurpleStrip.Parent = Body
   PurpleStrip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
   PurpleStrip.BorderSizePixel = 0
   PurpleStrip.Position = UDim2.new(0, 0, 0.300000012, 0)
   PurpleStrip.Size = UDim2.new(1, 0, 0, 15)

   Title.Name = "Title"
   Title.Parent = Body
   Title.BackgroundColor3 = Color3.new(1, 1, 1)
   Title.BackgroundTransparency = 1
   Title.Size = UDim2.new(1, 0, 0.300000012, 0)
   Title.Font = Enum.Font.GothamBold
   Title.Text = Titletxt
   Title.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
   Title.TextSize = 14

   Text.Name = "Text"
   Text.Parent = Body
   Text.AnchorPoint = Vector2.new(0.5, 1)
   Text.BackgroundColor3 = Color3.new(1, 1, 1)
   Text.BackgroundTransparency = 1
   Text.Position = UDim2.new(0.5, 0, 1, 0)
   Text.Size = UDim2.new(1, 0, 0.600000024, 0)
   Text.Font = Enum.Font.GothamBold
   Text.Text = Texttxt
   Text.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
   Text.TextSize = 14
   Text.TextWrapped = true
   local ok = Instance.new("TextButton")
   local okimg = Instance.new("ImageLabel")
   local oklab = Instance.new("TextLabel")
   local okback = Instance.new("ImageLabel")
   local cancel = Instance.new("TextButton")
   local cancelimg = Instance.new("ImageLabel")
   local cancellab = Instance.new("TextLabel")
   local cancelback = Instance.new("ImageLabel")

   ok.Name = "ok"
   ok.Parent = Notification
   ok.BackgroundColor3 = Color3.new(1, 1, 1)
   ok.BackgroundTransparency = 1
   ok.Position = UDim2.new(0, 0, 0, 5)
   local normok = UDim2.new(-0.4, 10, 0, 5)
   local notok = UDim2.new(0, 0, 0, 5)
   ok.Size = UDim2.new(0.4, -20, 0.5, -8)
   ok.Font = Enum.Font.SourceSans
   ok.TextColor3 = Color3.new(0, 0, 0)
   ok.TextSize = 14
   ok.TextTransparency = 1

   okimg.Name = "okimg"
   okimg.Parent = ok
   okimg.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
   okimg.BackgroundTransparency = 1
   okimg.Size = UDim2.new(1, 0, 1, 0)
   okimg.ZIndex = -2
   okimg.Position = UDim2.new(0, 0, 0, 0)
   okimg.Image = "rbxassetid://3570695787"
   okimg.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
   okimg.ScaleType = Enum.ScaleType.Slice
   okimg.SliceCenter = Rect.new(100, 100, 100, 100)
   okimg.SliceScale = 0.05
   oklab.Name = "oklab"
   oklab.Parent = okimg
   oklab.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
   oklab.BackgroundTransparency = 1
   oklab.BorderSizePixel = 0
   oklab.Position = UDim2.new(0, 5, 0, 5)
   oklab.Size = UDim2.new(1, -10, 1, -10)
   oklab.ZIndex = 0
   oklab.Font = Enum.Font.SourceSansBold
   oklab.Text = "ok"
   oklab.TextColor3 = Color3.fromRGB(170, 170, 170)
   oklab.TextSize = 14
   okback.Name = "okback"
   okback.Parent = oklab
   okback.AnchorPoint = Vector2.new(0.5, 0.5)
   okback.BackgroundColor3 = Color3.new(1, 1, 1)
   okback.BackgroundTransparency = 1
   okback.Position = UDim2.new(0.5, 0, 0.5, 0)
   okback.Size = UDim2.new(1, 0, 1, 0)
   okback.ZIndex = -1
   okback.Image = "rbxassetid://3570695787"
   okback.ImageColor3 = Color3.fromRGB(25, 25, 25)
   okback.ScaleType = Enum.ScaleType.Slice
   okback.SliceCenter = Rect.new(100, 100, 100, 100)
   okback.SliceScale = 0.05
   cancel.Name = "cancel"
   cancel.Parent = Notification
   cancel.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
   cancel.BackgroundTransparency = 1
   cancel.Position = UDim2.new(0, 0, 0.5, 5)
   local normcancel = UDim2.new(-0.4, 10, 0.5, 5)
   local notcancel = UDim2.new(0, 0, 0.5, 5)
   cancel.Size = UDim2.new(0.4, -20, 0.5, -8)
   cancel.Font = Enum.Font.SourceSans
   cancel.TextColor3 = Color3.new(0, 0, 0)
   cancel.TextSize = 14
   cancel.TextTransparency = 1

   cancelimg.Name = "cancelimg"
   cancelimg.Parent = cancel
   cancelimg.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
   cancelimg.BackgroundTransparency = 1
   cancelimg.Size = UDim2.new(1, 0, 1, 0)
   cancelimg.ZIndex = -2
   cancelimg.Image = "rbxassetid://3570695787"
   cancelimg.ImageColor3 = Color3.new(0.109804, 0.109804, 0.109804)
   cancelimg.ScaleType = Enum.ScaleType.Slice
   cancelimg.SliceCenter = Rect.new(100, 100, 100, 100)
   cancelimg.SliceScale = 0.05
   cancellab.Name = "cancellab"
   cancellab.Parent = cancelimg
   cancellab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   cancellab.BackgroundTransparency = 1
   cancellab.BorderSizePixel = 0
   cancellab.Position = UDim2.new(0, 5, 0, 5)
   cancellab.Size = UDim2.new(1, -10, 1, -10)
   cancellab.ZIndex = 0
   cancellab.Font = Enum.Font.SourceSansBold
   cancellab.Text = "cancel"
   cancellab.TextColor3 = Color3.fromRGB(170, 170, 170)
   cancellab.TextSize = 14
   cancelback.Name = "cancelback"
   cancelback.Parent = cancellab
   cancelback.AnchorPoint = Vector2.new(0.5, 0.5)
   cancelback.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
   cancelback.BackgroundTransparency = 1
   cancelback.Position = UDim2.new(0.5, 0, 0.5, 0)
   cancelback.Size = UDim2.new(1, 0, 1, 0)
   cancelback.ZIndex = -1
   cancelback.Image = "rbxassetid://3570695787"
   cancelback.ImageColor3 = Color3.fromRGB(25, 25, 25)
   cancelback.ScaleType = Enum.ScaleType.Slice
   cancelback.SliceCenter = Rect.new(100, 100, 100, 100)
   cancelback.SliceScale = 0.05

   local lol = true

   --//      code
   spawn(
   function()
      wait(10)
      if lol == true then
         ok:TweenPosition(notok, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2)
         cancel:TweenPosition(
         notcancel,
         Enum.EasingDirection.Out,
         Enum.EasingStyle.Quad,
         0.2
         )
         wait(0.2)
         Notification:TweenPosition(
         notnoti,
         Enum.EasingDirection.Out,
         Enum.EasingStyle.Quad,
         0.3
         )
         wait(0.3)
         Notification:Destroy()
      end
   end
   )

   ok.MouseButton1Click:Connect(
   function()
      lol = false
      spawn(
      function()
         callback()
      end
      )

      ok:TweenPosition(notok, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2)
      cancel:TweenPosition(
      notcancel,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.2
      )
      wait(0.2)
      Notification:TweenPosition(
      notnoti,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.3
      )
      wait(0.3)
      Notification:Destroy()
   end
   )
   cancel.MouseButton1Click:Connect(
   function()
      lol = false
      ok:TweenPosition(notok, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2)
      cancel:TweenPosition(
      notcancel,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.2
      )
      wait(0.2)
      Notification:TweenPosition(
      notnoti,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.3
      )
      wait(0.3)
      Notification:Destroy()
   end
   )

   Notification:TweenPosition(normnoti, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3)
   spawn(
   function()
      wait(0.4)
      ok:TweenPosition(normok, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2)
      cancel:TweenPosition(
      normcancel,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.2
      )
   end
   )
end
)
end

function library:Notification(Titletxt, Texttxt)
if not Titletxt then
   Titletxt = ""
elseif Titletxt then
   Titletxt = tostring(Titletxt)
end
if not Texttxt then
   Texttxt = ""
elseif Texttxt then
   Texttxt = tostring(Texttxt)
end
local Notification = Instance.new("TextButton")
local Body = Instance.new("ImageLabel")
local Body2 = Instance.new("ImageLabel")
local PurpleStrip = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Text = Instance.new("TextLabel")

Notification.Name = "Notification"
Notification.Parent = lt2gui
Notification.AnchorPoint = Vector2.new(1, 1)
Notification.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
Notification.BackgroundTransparency = 1
Notification.ClipsDescendants = true
Notification.Position = UDim2.new(1, 200, 1, -10)
local normnoti = UDim2.new(1, -10, 1, -10)
local notnoti = UDim2.new(1, 200, 1, -10)
Notification.Size = UDim2.new(0, 200, 0, 59)
Notification.Font = Enum.Font.SourceSans
Notification.TextColor3 = Color3.new(0, 0, 0)
Notification.TextSize = 1
Notification.TextTransparency = 1

Body.Name = "Body"
Body.Parent = Notification
Body.BackgroundColor3 = Color3.new(1, 1, 1)
Body.BackgroundTransparency = 1
Body.Size = UDim2.new(1, 0, 1, 0)
Body.Image = "rbxassetid://3570695787"
Body.ImageColor3 = Color3.fromRGB(30, 30, 30)
Body.ScaleType = Enum.ScaleType.Slice
Body.SliceCenter = Rect.new(100, 100, 100, 100)
Body.SliceScale = 0.09

Body2.Name = "Body"
Body2.Parent = Body
Body2.BackgroundColor3 = Color3.new(1, 1, 1)
Body2.BackgroundTransparency = 1
Body2.Size = UDim2.new(1, 0, 0.3, 15)
Body2.Image = "rbxassetid://3570695787"
Body2.ImageColor3 = Color3.fromRGB(20, 20, 20)
Body2.ScaleType = Enum.ScaleType.Slice
Body2.SliceCenter = Rect.new(100, 100, 100, 100)
Body2.SliceScale = 0.09

PurpleStrip.Name = "PurpleStrip"
PurpleStrip.Parent = Body
PurpleStrip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PurpleStrip.BorderSizePixel = 0
PurpleStrip.Position = UDim2.new(0, 0, 0.3, 0)
PurpleStrip.Size = UDim2.new(1, 0, 0, 15)

Title.Name = "Title"
Title.Parent = Body
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.300000012, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = Titletxt
Title.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title.TextSize = 14

Text.Name = "Text"
Text.Parent = Body
Text.AnchorPoint = Vector2.new(0.5, 1)
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0.5, 0, 1, 0)
Text.Size = UDim2.new(1, 0, 0.600000024, 0)
Text.Font = Enum.Font.GothamBold
Text.Text = Texttxt
Text.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Text.TextSize = 14
Text.TextWrapped = true

--               //code

Notification:TweenPosition(normnoti, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3)
lol = true

Notification.MouseButton1Click:Connect(
function()
   lol = false
   Notification:TweenPosition(notnoti, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3)
   wait(0.3)
   Notification:Destroy()
end
)
spawn(
function()
   wait(5)
   if lol == true then
      Notification:TweenPosition(
      notnoti,
      Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad,
      0.3
      )
      wait(0.3)
      Notification:Destroy()
   end
end
)
end
return Tabs
end
end
return library
