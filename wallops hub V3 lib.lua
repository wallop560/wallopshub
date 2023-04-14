local library = {}
function err(...)
	warn(...)
end

local ThemeColours = {
	Title = Color3.fromRGB(200,200,215),
	Top = Color3.fromRGB(100,100,130),
	UnderTop = Color3.fromRGB(50,50,70),
	MenuButton = Color3.fromRGB(65, 65, 95),
	TabBar = Color3.fromRGB(40,40,50),
	Body = Color3.fromRGB(40,40,70),
	Text = Color3.fromRGB(250,250,250),
	TabButton = Color3.fromRGB(50,50,70),
	Ripple = Color3.fromRGB(0,0,0),
	Sections = Color3.fromRGB(45,45,75),
	Buttons = Color3.fromRGB(60,60,110)
}
local themeobjects = {}
function GiveTheme(object,themename,themeprop,offset)
	themeprop = themeprop or 'BackgroundColor3'
	offset = offset or Color3.new(0,0,0)
	object[themeprop] = Color3.new(ThemeColours[themename].R + offset.R,ThemeColours[themename].G + offset.G,ThemeColours[themename].B + offset.B)
	if ThemeColours[themename]  then
		table.insert(themeobjects,{o=object,tn=themename,tp=themeprop,off=offset})
	end
end
function library:SetThemeColor(prop,clr)
	if ThemeColours[prop] then
		ThemeColours[prop] = clr
		for i,v in next,themeobjects do
			v.o[v.tp] = Color3.new(ThemeColours[v.tn].R + v.off.R,ThemeColours[v.tn].G + v.off.G,ThemeColours[v.tn].B + v.off.B)
		end
	else
		err('Did not provide a valid property')
	end
end
function Create(ins,props,themename,themeprop,children)
	ins = ins or 'Frame'
	children = children or {}
	themename = themename or ''
	themeprop = themeprop or 'BackgroundColor3'
	props = props or {}
	local instance = Instance.new(ins)
	for i,v in next,props do
		if i ~= themeprop  then
			instance[i] = v
		else
			if ThemeColours[themename] then
				instance[i] = ThemeColours[themename]
			else
				instance[i] = v
			end	
		end
		if themename and ThemeColours[themename] then
			GiveTheme(instance,themename,themeprop)
		end
	end
	for i,v in next,children do
		v.Parent = instance
	end
	return instance
end
function NewDragger(frame,hold)
	local dragging = false
	local startdragging
	local inp
	local startpos

	function updatedragger(input)
		local pos = input.Position - startdragging
		game:GetService('TweenService'):Create(frame,TweenInfo.new(.1),{Position = UDim2.new(startpos.X.Scale,startpos.X.Offset + pos.X,startpos.Y.Scale,startpos.Y.Offset + pos.Y)}):Play()
	end
	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			startdragging = input.Position
			startpos = frame.Position
			dragging = true
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			inp = input
		end
	end)
	game:service("UserInputService").InputChanged:Connect(function(input)
		if input == inp and dragging then
			updatedragger(input)
		end
	end)
end
function library:Window(name)
	name = name or ''
	local dead = false
	local function Ripple(thing,cd)
		local TweenService = game:GetService("TweenService")
		local mouse = game.Players.LocalPlayer:GetMouse()
		local x = mouse.X
		local y = mouse.Y
		local Circle = Create("ImageLabel",{
			Name = "Circle",
			BackgroundColor3 = ThemeColours.Ripple,
			BackgroundTransparency = 1,
			ZIndex = 10,
			Image = "rbxassetid://266543268",
			ImageColor3 = Color3.fromRGB(90,30,100),
			ImageTransparency = 0.5,
			SliceScale = 1,
			Position = UDim2.new(0, x - thing.AbsolutePosition.X, 0, y - thing.AbsolutePosition.Y),
			Parent = thing
		},'Ripple','ImageColor3')
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
		spawn(
			function()
				wait(1)
				Circle:Destroy()
			end
		)
	end
	local uilib2
	if game:GetService("RunService"):IsStudio() then
		uilib2 = Create("ScreenGui",{
			Name = "ui lib 2",
			Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		}
		)
	else
		uilib2 = Create("ScreenGui",{
			Name = "ui lib 2",
			Parent = game.CoreGui,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		}
		)
	end

	local Body = Create("Frame",{
		Name = "Body",
		Parent = uilib2,
		BackgroundColor3 = Color3.fromRGB(40, 40, 70),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0.32432434, 0, 0, 20),
		Size = UDim2.new(0, 484, 0, 346)
	},'Body',nil,
	{
		Create('UICorner',{ CornerRadius = UDim.new(0, 3) })
	}
	)

	local Top = Create('Frame',{
		Name = "Top",
		Parent = Body,
		BackgroundColor3 = Color3.fromRGB(100, 100, 130),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2
	},'Top',nil,{
		Create('Frame',{
			Name = "UnderTop",
			BackgroundColor3 = Color3.fromRGB(50, 50, 70),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 25),
			Size = UDim2.new(1, 0, 0, 5)	
		},'UnderTop',nil),
		Create('UICorner',{CornerRadius = UDim.new(0, 2)})
	}
	)
	local namelab = Create('TextLabel',{
		TextSize = 22,
		Parent = Top,
		Font = Enum.Font.SourceSansBold,
		BackgroundTransparency = 1,
		Size = UDim2.new(0,0,1,0),
		Position = UDim2.new(.5,0,0,0),
		AnchorPoint = Vector2.new(.5,0),
		Text = name
	},'Title','TextColor3')

	local TabsButton = Create('TextButton',{
		Name = "TabsButton",
		Parent = Top,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0, 3),
		Size = UDim2.new(0, 30, 1, -6),
		ZIndex = 200,
		Font = Enum.Font.SourceSans,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 1.000,
		TextTransparency = 1.000
	})

	local Top2 = Create('Frame',{
		Name = "Top2",
		Parent = Body,
		BackgroundColor3 = Color3.fromRGB(100, 100, 130),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 5),
		Size = UDim2.new(1, 0, 0, 20)
	},'Top',nil)

	local Screens = Create('Frame',{
		Name = "Screens",
		Parent = Body,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		ClipsDescendants = true,
		Position = UDim2.new(0, 8, 0, 30),
		Size = UDim2.new(1, -16, 1, -30)
	})

	local Tabs = Create('ScrollingFrame',{
		Name = "Tabs",
		Parent = Body,
		BackgroundColor3 = Color3.fromRGB(40, 40, 50),
		BorderSizePixel = 0,
		Position = UDim2.new(0,-150,0,0),
		Size = UDim2.new(0, 150, 1, 0),
		ScrollBarThickness = 0
	},'TabBar',nil,{
		Create('Frame',{
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 0, 35)
		})
	})
	
	local BarUIListLayout = Create('UIListLayout',{
		Parent = Tabs,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0,4)
	})
	function updateTabs()
	    Tabs.CanvasSize = UDim2.new(0,0,0,BarUIListLayout.AbsoluteContentSize.Y + 2)
	end
	NewDragger(Body,Top)

	local TT = .15
	local tabsopen = false
	local TabLines = {}

	for i = 1,3 do
		TabLines[i] = Create('Frame',{
			Parent = TabsButton,
			AnchorPoint = Vector2.new(0.5, .5 * (i - 1)),
			BackgroundColor3 = Color3.fromRGB(65, 65, 95),
			BorderSizePixel = 0,
			Position = UDim2.new(.5,0,.5 * (i - 1),0),
			Size = UDim2.new(1, 0, 0, 5),
			ZIndex = 12
		},'MenuButton',nil,{
			Create('UICorner',{CornerRadius = UDim.new(0, 4)})
		}
		) 
	end

	TabsButton.MouseButton1Click:Connect(function()
		tabsopen = not tabsopen
		if tabsopen then
			Screens:TweenPosition(UDim2.new(0, 158,0, 30),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			Tabs:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			for i,v in next,TabLines do
				v:TweenSize(UDim2.new(0,0,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			end
			wait(TT)
			TabsButton.Position = UDim2.new(0, 23-(TabsButton.Parent.AbsoluteSize.Y - 6),0,15 + (TabsButton.Parent.AbsoluteSize.Y - 6) - 31)
			--button.Size = UDim2.new(0,button.Parent.AbsoluteSize.Y -6,0, 30)
			TabsButton.Rotation = 90
			for i,v in next,TabLines do
				v:TweenSize(UDim2.new(1,-6,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			end
		else
			Screens:TweenPosition(UDim2.new(0, 8,0, 30),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			Tabs:TweenPosition(UDim2.new(0,-150,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			for i,v in next,TabLines do
				v:TweenSize(UDim2.new(0,0,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			end
			wait(TT)
			TabsButton.Position = UDim2.new(0,5,0,3)
			--button.Size = UDim2.new(0, 30,1,-6)
			TabsButton.Rotation = 0
			for i,v in next,TabLines do
				v:TweenSize(UDim2.new(1,0,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			end
		end
	end)
	local Tabstbl = {}
	function Tabstbl:ChangeTitle(txt)
		txt = txt or ''
		namelab.Text = txt
	end
	function Tabstbl:Kill()
	    dead = true
		uilib2:Destroy()
	end
	local firstTab = true
	local TabsTable = {}
	local selected 

	function Tabstbl:Tab(name)
		name = name or ''
		local tabstuff = {}



		local Frame_2 = Create('Frame',{
			Parent = Tabs,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 0, 25)
		})
		local TextButton = Create('TextButton',{
			Parent = Frame_2,
			BackgroundColor3 = Color3.fromRGB(50, 50, 70),
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -20, 1, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSansBold,
			Text = '',
			TextColor3 = ThemeColours.Text,
			TextSize = 16.000,
			TextWrapped = true,
			ClipsDescendants = true
		},'TabButton',nil,{
			Create('UICorner',{CornerRadius = UDim.new(0, 4)})
		})
		local tabname = Create('TextLabel',{Size = UDim2.new(1,0,1,0),Text = name,TextColor3 = ThemeColours.Text,BackgroundTransparency = 1,Font = Enum.Font.SourceSansBold,TextSize = 16.000,Parent = TextButton},'Text','TextColor3')
		function tabstuff:ChangeTitle(title)
			tabname.Text = title
		end
		local Tab = Create('ScrollingFrame',{
			Visible = firstTab,
			Name = name,
			Parent = Screens,
			BackgroundColor3 = Color3.fromRGB(255, 0, 0),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.new(1, 0, 1, 0),
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0,0,0,0)
		},nil,nil,{
			Create('Frame',{BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
		})
		if firstTab then
			selected = Tab
			firstTab = false
		end
		local tablisttho = Create('UIListLayout',{
			Padding = UDim.new(0,5),
			Parent = Tab
		})
		local function updateTab()
			Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y)
		end
		updateTab()
		TabsTable[name] = Tab
		TextButton.MouseButton1Click:Connect(function()
			game:GetService('TweenService'):Create(TextButton,TweenInfo.new(.1,Enum.EasingStyle.Quad),{BackgroundColor3 = Color3.fromRGB(90, 90, 110)}):Play()
			spawn(function()
				wait(.1)
				game:GetService('TweenService'):Create(TextButton,TweenInfo.new(.2,Enum.EasingStyle.Quad),{BackgroundColor3 = ThemeColours.TabButton}):Play()

			end)
			Ripple(TextButton)
			tabsopen = false
			Screens:TweenPosition(UDim2.new(0, 8,0, 30),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			Tabs:TweenPosition(UDim2.new(0,-150,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
			for i,v in next,TabLines do
				if v:IsA('Frame') then
					v:TweenSize(UDim2.new(0,0,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
				end	
			end
			if tostring(selected) ~= name then

				selected:TweenPosition(UDim2.new(0,0,1,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TT)
				spawn(function()
					wait(TT)
					selected.Visible = false
					selected = Tab
				end)

				Tab.Position = UDim2.new(0,0,-1,0)
				Tab.Visible = true

				Tab:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Quad,TT)
			end
			wait(TT)

			TabsButton.Position = UDim2.new(0,5,0,3)
			--button.Size = UDim2.new(0, 30,1,-6)
			TabsButton.Rotation = 0
			for i,v in next,TabLines do
				if v:IsA('Frame') then
					v:TweenSize(UDim2.new(1,0,0,v.AbsoluteSize.Y),Enum.EasingDirection.In,Enum.EasingStyle.Quad,TT)
				end	
			end
		end)
		function tabstuff:Section(name,open)
			name = name or ''
			if open ~= false and open ~= true then
				open = true
			end
			updateTab()
			local sectionstuff = {}
			local section = Create('TextButton',{
				Text = '',
				AutoButtonColor = false,
				Name = "section",
				Parent = Tab,
				BackgroundColor3 = ThemeColours.Sections,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Position = UDim2.new(0, 0, 0, 5),
				Size = UDim2.new(1, 0, 0, 27)
			},'Sections',nil,{
				Create('UICorner',{CornerRadius = UDim.new(0, 3)})
			})

			local Frame = Create('Frame',{
				Parent = section,
				BackgroundColor3 = Color3.fromRGB(50, 50, 70),
				BackgroundTransparency = 1.000,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -10, 0, 0)
			})
			local UIListLayout = Create("UIListLayout",{
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = Frame,
				Padding = UDim.new(0, 8)
			})
			local SectionName = Create("TextLabel",{
				Name = "SectionName",
				Parent = Frame,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(0, 200, 0, 17),
				Font = Enum.Font.GothamBold,
				Text = name,
				LineHeight = 1.1,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16.000,
				TextXAlignment = Enum.TextXAlignment.Left
			},'Text','TextColor3')
			local function updateSection()
				if open then

					section.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
					updateTab()
				end
			end
			function sectionstuff:ToggleSection(opn)
				open = opn
				local opening = true
				if opn then
					section:TweenSize(UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10),Enum.EasingDirection.In,Enum.EasingStyle.Linear,.1)
				else
					section:TweenSize(UDim2.new(1, 0, 0, 27),Enum.EasingDirection.In,Enum.EasingStyle.Linear,.1)
				end
				spawn(function()
					repeat updateTab() game:GetService('RunService').RenderStepped:Wait() until not opening
				end)
				spawn(function()
					wait(.1)
					opening = false
				end)
			end
			local press = false
			local press2 = false
			section.MouseButton1Click:Connect(function()
				if press then
					Ripple(section)
					sectionstuff:ToggleSection(not open)
				end
				press = true
				spawn(function()
					wait(.3)
					press = false
				end)

			end)

			function sectionstuff:ChangeTitle(ttl)
				SectionName.Text = ttl or ''
			end
			function sectionstuff:Kill()
				section:Destroy()
			end
			function sectionstuff:Toggle(name,toggled,callback)
			    name = name or ''
			    toggled = toggled or false
			    callback = callback or function() end
				local tglstuff = {}
				local tgl = toggled
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				GiveTheme(Button,'Text','TextColor3')
				function tglstuff:Kill()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				function tglstuff:ChangeTitle(txt)
					Button.Text = txt
				end

				local ToggleBut = Create('Frame',{
					Name = "Button",
					Parent = Button,
					AnchorPoint = Vector2.new(1,.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					BackgroundColor3 = Color3.fromRGB(55,55,105),
					LayoutOrder = 1,
					Size = UDim2.new(0, 60, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				local ToggleBit = Create('Frame',{
					Name = "Button",
					Parent = ToggleBut,
					Position = UDim2.new(0,0,0,0),
					BackgroundColor3 = Color3.fromRGB(50,50,100),
					LayoutOrder = 1,
					Size = UDim2.new(0, 25, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(ToggleBit,'Buttons','BackgroundColor3',Color3.fromRGB(-15,-15,-15))
				GiveTheme(ToggleBut,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				if toggled then
					ToggleBit.Position = UDim2.new(1,-25,0,0)
				end
				function tglstuff:Toggle(tgled)
					tgl = tgled
					spawn(function()
						callback(tgl)
					end)
					if tgl then
						game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.2),{Position = UDim2.new(1,-25,0,0)}):Play()
					else
						game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.2),{Position = UDim2.new(0,0,0,0)}):Play()
					end
				end
				Button.MouseButton1Click:Connect(function()
					Ripple(Button)
					tgl = not tgl
					spawn(function()
						callback(tgl)
					end)
					if tgl then
						game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.2),{Position = UDim2.new(1,-25,0,0)}):Play()
					else
						game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.2),{Position = UDim2.new(0,0,0,0)}):Play()
					end
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 15,ThemeColours.Buttons.G * 255 + 15,ThemeColours.Buttons.B * 255 -15)}):Play()
					wait(.05)
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
					game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 20,ThemeColours.Buttons.G * 255 - 20,ThemeColours.Buttons.B * 255 - 20)}):Play()
				end)
				Button.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
					game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 20,ThemeColours.Buttons.G * 255 - 20,ThemeColours.Buttons.B * 255 - 20)}):Play()
				end)
				Button.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  ThemeColours.Buttons}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
					game:GetService('TweenService'):Create(ToggleBit,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				updateSection()
				updateTab()
				return tglstuff
			end
			function sectionstuff:Button(name,CallBack)
			    name = name or ''
			    CallBack = CallBack or function() end
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				GiveTheme(Button,'Text','TextColor3')
				function buttonstf:Kill()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				function buttonstf:ChangeText(txt)
					Button.Text = txt
				end
				Button.MouseButton1Click:Connect(function()
					Ripple(Button)
					spawn(CallBack)
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					wait(.05)
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.05,Enum.EasingStyle.Linear),{BackgroundColor3 = ThemeColours.Buttons}):Play()
				end)
				Button.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
				end)
				Button.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 = ThemeColours.Buttons}):Play()
				end)
				updateTab()
				updateSection()
				return buttonstf
			end

			function sectionstuff:Box(name,typev,deault,callback)
			    name = name or ''
			    typev = typev or ''
			    default = default or ''
			    callback = callback or function() end
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				GiveTheme(Button,'Text','TextColor3')
				local ToggleBut = Create('TextBox',{
					Name = "Button",
					Text = deault,
					TextSize = 13,
					Font = Enum.Font.GothamBold,
					Parent = Button,
					AnchorPoint = Vector2.new(1,.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					BackgroundColor3 = Color3.fromRGB(55,55,105),
					LayoutOrder = 1,
					Size = UDim2.new(0, 150, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(ToggleBut,'Text','TextColor3')

				GiveTheme(ToggleBut,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				function buttonstf:Kill()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				function buttonstf:ChangeText(txt)
					Button.Text = txt
				end
				ToggleBut:GetPropertyChangedSignal('Text'):Connect(function()
					if typev == 'number' then
						ToggleBut.Text = ToggleBut.Text:gsub('%D+', '')
					end

					spawn(function()
						callback(ToggleBut.Text)
					end)
				end)
				Button.MouseButton1Click:Connect(function()
					Ripple(Button)

					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					ToggleBut:CaptureFocus()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  ThemeColours.Buttons}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
				end)
				updateTab()
				updateSection()
				return buttonstf
			end

			function sectionstuff:Bind(name,deault,callback,EndCallBack,ChangeCallback)
			    name = name or ''
			    default = default or Enum.KeyCode.G
			    callback = callback or function() end
			    EndCallBack = EndCallBack or function() end
			    ChangeCallback = ChangeCallback or function() end
				local keyl = deault
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				GiveTheme(Button,'Text','TextColor3')
				local ToggleBut = Create('TextLabel',{
					Name = "Button",
					Text = deault.Name,
					TextSize = 14,
					Font = Enum.Font.GothamBold,
					Parent = Button,
					AnchorPoint = Vector2.new(1,.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					BackgroundColor3 = Color3.fromRGB(55,55,105),
					LayoutOrder = 1,
					Size = UDim2.new(0, 100, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(ToggleBut,'Text','TextColor3')

				GiveTheme(ToggleBut,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))

				function buttonstf:ChangeKey(key)
					keyl = key
					Button.Text = key.Name
				end
				Button.MouseButton1Click:Connect(function()
					Ripple(Button)

					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					spawn(function()
						local old = ToggleBut.Text
						ToggleBut.Text = '...'
						local key = game:GetService('UserInputService').InputBegan:Wait()
						key = key.KeyCode
						if key == Enum.KeyCode.Unknown then
							ToggleBut.Text = old
						else
							ToggleBut.Text = key.Name
							wait()
							keyl = key
							spawn(function()
							    ChangeCallback(key1)
							end)
						end
					end)
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				local keypress = game:GetService('UserInputService').InputBegan:Connect(function(key)
					if game:GetService('UserInputService'):GetFocusedTextBox() then return end
					
					if dead then return end
					key = key.KeyCode
					if key == keyl then
						spawn(callback)
					end
				end)
				local keyend = game:GetService('UserInputService').InputEnded:Connect(function(key)
					if dead then return end
					if game:GetService('UserInputService'):GetFocusedTextBox() then return end
					
					key = key.KeyCode
					if key == keyl then
						spawn(EndCallBack)
					end
				end)
				function buttonstf:Kill()
					keypress:Disconnect()
					keyend:Disconnect()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				Button.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  ThemeColours.Buttons}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
				end)
				updateTab()
				updateSection()
				return buttonstf
			end

			function sectionstuff:Slider(name,min,max,Default,Inc,CallBack)
			    name = name or ''
			    min,max = min or 0,max or 1
			    Default = Default or 0
			    Inc = Inc or 1
			    CallBack = CallBack or function() end
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				GiveTheme(Button,'Text','TextColor3')
				local SliderBut = Create('TextButton',{
					Name = "Button",
					Parent = Button,
					Active = false,
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(50, 50, 100),
					ClipsDescendants = true,
					LayoutOrder = 1,
					Position = UDim2.new(1, -5, 0.5, 0),
					Selectable = false,
					Size = UDim2.new(0, 247, 0, 25),
					Text = ""
				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(SliderBut,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				local SliderTxt = Create('TextLabel',{
					Parent = SliderBut,
					AnchorPoint = Vector2.new(1, 0),
					BackgroundColor3 = Color3.fromRGB(123, 255, 0),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(1, -5, 0, 0),
					Size = UDim2.new(0, 50, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.GothamBold,
					Text = tostring(Default),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 15.000,
					TextXAlignment = Enum.TextXAlignment.Right
				},'Text','TextColor3')
				local SliderBit = Create('Frame',{
					Parent = SliderBut,
					BackgroundColor3 = Color3.fromRGB(45, 45, 95),
					BorderSizePixel = 0,
					Size = UDim2.new(0,247,1,0)
				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(SliderBit,'Buttons','BackgroundColor3',Color3.fromRGB(-15,-15,-15))
				local max2 = tonumber(SliderBit.Size.X.Offset)
				function buttonstf:Kill()
					Button:Destroy()
					updateTab()
					updateSection()

				end


				Button.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
				end)
				Button.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 = ThemeColours.Buttons}):Play()
				end)
				local mouse = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local v = Default
				local ov

				function buttonstf:ChangeName(txt)
					Button.Text = txt
				end
				function buttonstf:ChangeValue(num)
					v = num
					SliderTxt.Text = tostring(v)
					spawn(function()CallBack(v)end)
					SliderBit.Size = UDim2.new(0,math.clamp((max2/max)*v,0,max2) ,1,0)
				end
				function buttonstf:ChangeMax(num)
					max = num
					SliderTxt.Text = tostring(v)
					spawn(function()CallBack(v)end)
					SliderBit.Size = UDim2.new(0,math.clamp((max2/max)*v,0,max2) ,1,0)
				end
				function buttonstf:ChangeMin(num)
					min = num
					SliderTxt.Text = tostring(v)
					spawn(function()CallBack(v)end)
					SliderBit.Size = UDim2.new(0,math.clamp((max2/max)*v,0,max2) ,1,0)
				end
				function buttonstf:ChangeInc(num)
					Inc = num
				end

				SliderTxt.Text = tostring(v)
				spawn(function()CallBack(v)end)
				SliderBit.Size = UDim2.new(0,math.clamp((max2/max)*v,0,max2) ,1,0)
				ov = v
				local function Updateslider()
					v = math.round(((((max-min)/max2)*SliderBit.AbsoluteSize.X)+min)/Inc)*Inc
					SliderTxt.Text = tostring(v)
					if v ~= ov then
						spawn(function()CallBack(v)end)
					end
					SliderBit.Size = UDim2.new(0,math.clamp(mouse.X- SliderBit.AbsolutePosition.X,0,max2) ,1,0)
					ov = v
				end

				SliderBut.MouseButton1Down:Connect(function()
					Ripple(SliderBit)
					Updateslider()
					local mbe = mouse.Move:Connect(function()
						Updateslider()
					end)
					local h 
					h = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							h:Disconnect()
							mbe:Disconnect()
						end
					end)
				end)

				updateTab()
				updateSection()
				return buttonstf
			end
			function sectionstuff:DropDown(name,tabl,callback)
			    name = name or ''
			    tabl = tabl or {}
			    callback = callback or function() end
				local normsize = UDim2.new(0,245, 0, 83)
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					ZIndex = 1,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				local Button2 = Create("TextButton",{
					Name = "Button",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = '',
					Transparency = 1,
					AutoButtonColor = false,
					Size = UDim2.new(1, 7, 1 ,0),
					TextSize = 18,
					TextTransparency = 1,
					ZIndex = 1,
					Position = UDim2.new(0,-7,0,0),
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				})
				GiveTheme(Button,'Text','TextColor3')
				local ToggleBut = Create('TextBox',{
					Name = "Button",
					Text = '',
					ZIndex = 1,
					TextSize = 13,
					Font = Enum.Font.GothamBold,
					Parent = Button,
					AnchorPoint = Vector2.new(1,.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					BackgroundColor3 = Color3.fromRGB(55,55,105),
					LayoutOrder = 1,
					Size = UDim2.new(0, 150, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				local DDMenu = Create("Frame",{
					Name = "Button",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					ZIndex = 1,
					Transparency = 1,
					ClipsDescendants = true,
					AnchorPoint = Vector2.new(1,0),
					Size = UDim2.new(0,245, 0, 0),
					Position = UDim2.new(1,-5,0.5,10)
				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)})
				})
				local DDMenu2 = Create("ScrollingFrame",{
					Name = "Button",
					Parent = DDMenu,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					ZIndex = 1,
					ScrollBarThickness = 0,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Size = UDim2.new(1,-10,1,0),
					Position = UDim2.new(0,5,0,0)
				},nil,nil,{
					Create('Frame',{Size = UDim2.new(0,0,0,0),Transparency = 1})
				})
				local UIL = Create('UIListLayout',{
					Parent = DDMenu2,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0,2)
				})

				local function updateListLayout()
					DDMenu2.CanvasSize = UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y)
				end
				updateListLayout()
				local buttonsobj = {}

				for i,v in next,tabl do
					local sel = Create('TextButton',{
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						Size = UDim2.new(1,0,0,25),
						TextSize = 17,
						Font = Enum.Font.SourceSansBold,
						Text = tostring(v),
						Parent = DDMenu2
					},'Buttons',nil,{
						Create('UICorner',{CornerRadius = UDim.new(0, 3)})
					})
					table.insert(buttonsobj,sel)
					GiveTheme(sel,'Text','TextColor3')
					local name2 = tostring(v)
					sel.MouseButton1Click:Connect(function()
						spawn(function()
							callback(name2)
						end)
						for i = 1, #name2 do
							local stringsub = name2:sub(1, i)
							ToggleBut.Text = stringsub
							wait()
						end
					end)
					updateListLayout()
				end
				ToggleBut:GetPropertyChangedSignal('Text'):Connect(function()
					local txt = ToggleBut.Text
					local s = false
					for i,v in next,buttonsobj do
						if string.find(string.lower(v.Text),string.lower(txt)) then
							v.Visible = true
							s = true
						else
							v.Visible = false
						end
					end
					if not s then
						for i,v in next,buttonsobj do
							v.Visible = true
						end
					end
					wait()
					updateListLayout()
				end)
				GiveTheme(ToggleBut,'Text','TextColor3')
				GiveTheme(DDMenu,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				GiveTheme(ToggleBut,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				function buttonstf:Kill()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				function buttonstf:ChangeText(txt)
					Button.Text = txt
				end
				function buttonstf:Refresh(tabl)
					for i,v in next,buttonsobj do
					    v:Destroy()
					end
					buttonsobj = {}
					for i,v in next,tabl do
					    local sel = Create('TextButton',{
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						Size = UDim2.new(1,0,0,25),
						TextSize = 17,
						Font = Enum.Font.SourceSansBold,
						Text = tostring(v),
						Parent = DDMenu2
					},'Buttons',nil,{
						Create('UICorner',{CornerRadius = UDim.new(0, 3)})
					})
					table.insert(buttonsobj,sel)
					GiveTheme(sel,'Text','TextColor3')
					local name2 = tostring(v)
					sel.MouseButton1Click:Connect(function()
						spawn(function()
							callback(name2)
						end)
						for i = 1, #name2 do
							local stringsub = name2:sub(1, i)
							ToggleBut.Text = stringsub
							wait()
						end
					end)
					updateListLayout()
					end
				end
				Button2.MouseButton1Click:Connect(function()
					Ripple(Button2)

					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					ToggleBut:CaptureFocus()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button2.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button2.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  ThemeColours.Buttons}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
				end)
				local TT = .1
				ToggleBut.Focused:Connect(function()
					Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y + 105)

					Button.ZIndex = 5
					DDMenu.Transparency = 0
					DDMenu:TweenSize(normsize,Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)


					section.ClipsDescendants = false
					wait(TT)
				end)
				ToggleBut.FocusLost:Connect(function()
					Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y )

					wait(0.1)
					DDMenu:TweenSize(UDim2.new(0,normsize.X.Offset,0,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)

					wait(TT)
					DDMenu.Transparency = 1
					Button.ZIndex = 1
					section.ClipsDescendants = true
				end)
				updateTab()
				updateSection()
				return buttonstf
			end

			function sectionstuff:ColorPicker(name,clr,callback)
			    name = name or ''
			    clr = clr or Color3.new(0,0,0)
			    callback = callback or function() end
				local hue,sat,brightness = Color3.toHSV(clr)

				local normsize = UDim2.new(0,245, 0, 120)
				local buttonstf = {}
				local Button = Create("TextButton",{
					Name = "Button",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = name,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 30),
					TextSize = 18,
					ZIndex = 1,
					TextTransparency = 0,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				},'Buttons',nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)}),
					Create('UIPadding',{PaddingLeft = UDim.new(0,8)})
				})
				local Button2 = Create("TextButton",{
					Name = "Button",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					Text = '',
					Transparency = 1,
					AutoButtonColor = false,
					Size = UDim2.new(1, 7, 1 ,0),
					TextSize = 18,
					TextTransparency = 1,
					ZIndex = 1,
					Position = UDim2.new(0,-7,0,0),
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left
				})
				GiveTheme(Button,'Text','TextColor3')
				local ToggleBut = Create('TextButton',{
					Name = "Button",
					Text = '',
					ZIndex = 1,
					BorderSizePixel = 0,
					Parent = Button,
					AnchorPoint = Vector2.new(1,.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					BackgroundColor3 = clr,
					LayoutOrder = 1,
					AutoButtonColor = false,
					Size = UDim2.new(0, 150, 0, 25)

				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				local DDMenu = Create("Frame",{
					Name = "Button",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(60, 60, 110),
					LayoutOrder = 1,
					ZIndex = 1,
					Transparency = 1,
					ClipsDescendants = true,
					AnchorPoint = Vector2.new(1,0),
					Size = UDim2.new(0,245, 0, 0),
					Position = UDim2.new(1,-5,0.5,10)
				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0, 3)})
				})
				local canvas = Create('ImageButton',{
					Name = 'Canvas',
					Parent = DDMenu,
					Size = UDim2.new(0,149,0,93),
					BorderSizePixel = 0,
					Position = UDim2.new(0,5,0,5),
					Image = 'rbxassetid://5108535320',
					AutoButtonColor = false,
					ImageColor3 = Color3.fromHSV(hue,1,1)
				},nil,nil,{
					Create('UICorner',{CornerRadius = UDim.new(0,3)}),
					Create('Frame',{
						Name = 'Marker',
						Size = UDim2.new(0,8,0,8),
						Position = UDim2.new(sat, 0, 1-brightness,0),
						BackgroundColor3 = Color3.fromRGB(0,0,0),
						AnchorPoint = Vector2.new(.5,.5),
						ZIndex = 2
					},nil,nil,{
						Create('UICorner',{CornerRadius = UDim.new(0,20)}),
						Create('Frame',{
							Name = 'MarkerBit',
							ZIndex = 3,
							Position = UDim2.new(0,1,0,1),
							Size = UDim2.new(1,-2,1,-2),
							BackgroundColor3 = Color3.new(1,1,1)
						},nil,nil,{
							Create('UICorner',{CornerRadius = UDim.new(0,20)})
						})
					}),
					Create('ImageLabel',{
						Size = UDim2.new(1,0,1,0),
						Name = 'Brightness',
						Image = 'rbxassetid://5107152095',
						BackgroundTransparency = 1
					},nil,nil,{Create('UICorner',{CornerRadius = UDim.new(0,3)})}),
					Create('ImageLabel',{
						Size = UDim2.new(1,0,1,0),
						Name = 'Saturation',
						Image = 'rbxassetid://5107152351',
						BackgroundTransparency = 1
					},nil,nil,{Create('UICorner',{CornerRadius = UDim.new(0,3)})})
				})
				local RGBar = Create('TextButton',{
					Name = 'RGBar',
					Text = '',
					AutoButtonColor = false,
					Parent = DDMenu,
					Size = UDim2.new(0,10,0,93),
					BackgroundColor3 = Color3.new(1,1,1),
					BorderSizePixel = 0,
					Position = UDim2.new(0,159,0,5)
				},nil,nil,{
					Create('UIGradient',{
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), 
							ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)), 
							ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), 
							ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), 
							ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), 
							ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)), 
							ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
						}),
						Rotation = 90
					}),
					Create('UICorner',{CornerRadius = UDim.new(0,3)}),
					Create('Frame',{
						Name = 'Marker',
						Size = UDim2.new(0,8,0,8),
						Position = UDim2.new(sat, 0, 1-brightness,0),
						BackgroundColor3 = Color3.fromRGB(0,0,0),
						AnchorPoint = Vector2.new(.5,.5),
						ZIndex = 2
					},nil,nil,{
						Create('UICorner',{CornerRadius = UDim.new(0,20)}),
						Create('Frame',{
							Name = 'MarkerBit',
							ZIndex = 3,
							Position = UDim2.new(0,1,0,1),
							Size = UDim2.new(1,-2,1,-2),
							BackgroundColor3 = Color3.new(1,1,1)
						},nil,nil,{
							Create('UICorner',{CornerRadius = UDim.new(0,20)})
						})
					})
				})

				local ToggleBut4 = Create('TextButton',{
					Name = 'Canvas',
					Parent = DDMenu,
					Text = 'Rainbow',
					TextSize = 20,
					Font = Enum.Font.GothamBold,
					Size = UDim2.new(1,-10,0,17),
					AnchorPoint = Vector2.new(.5,1),
					Position = UDim2.new(.5,0,1,-3),
					AutoButtonColor = false
				},'Text','TextColor3',{
					Create('UICorner',{CornerRadius = UDim.new(0,3)})
				})
				GiveTheme(ToggleBut4,'Buttons','BackgroundColor3')
				local R = Create('TextLabel',{
					Name = 'R',
					Parent = DDMenu,
					Text = 'R:',
					TextSize = 20,
					Font = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					Size = UDim2.new(0,30,0,20),
					AnchorPoint = Vector2.new(1,0),
					Position = UDim2.new(1, -40,0, 5)
				},'Text','TextColor3',{
					Create('TextBox',{
						Name = 'Box',
						Size = UDim2.new(1,0,1,0),
						BackgroundTransparency = 1,
						Text = '',
						Font = Enum.Font.GothamBold,
						TextSize = 15,
						Position = UDim2.new(1,0,0,0)
					},'Text','TextColor3',{
						Create('Frame',{
							Name = 'Line',
							Size = UDim2.new(0,0,0,2),
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.new(1,1,1),
							AnchorPoint = Vector2.new(.5,1),
							Position = UDim2.new(.5,0,1,0)
						})
					})
				})
				R.Box.Focused:Connect(function()
					R.Box.Line:TweenSize(UDim2.new(1,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				R.Box.FocusLost:Connect(function()
					R.Box.Text = tostring(tonumber(R.Box.Text) or 0)
					R.Box.Line:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				local G = Create('TextLabel',{
					Name = 'G',
					Parent = DDMenu,
					Text = 'G:',
					TextSize = 20,
					Font = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					Size = UDim2.new(0,30,0,20),
					AnchorPoint = Vector2.new(1,0),
					Position = UDim2.new(1, -40,0, 40)
				},'Text','TextColor3',{
					Create('TextBox',{
						Name = 'Box',
						Size = UDim2.new(1,0,1,0),
						BackgroundTransparency = 1,
						Text = '',
						Font = Enum.Font.GothamBold,
						TextSize = 15,
						Position = UDim2.new(1,0,0,0)
					},'Text','TextColor3',{
						Create('Frame',{
							Name = 'Line',
							Size = UDim2.new(0,0,0,2),
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.new(1,1,1),
							AnchorPoint = Vector2.new(.5,1),
							Position = UDim2.new(.5,0,1,0)
						})
					})
				})
				G.Box.Focused:Connect(function()
					
					G.Box.Line:TweenSize(UDim2.new(1,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				G.Box.FocusLost:Connect(function()
					G.Box.Text = tostring(tonumber(G.Box.Text) or 0)
					G.Box.Line:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				local B = Create('TextLabel',{
					Name = 'B',
					Parent = DDMenu,
					Text = 'B:',
					TextSize = 20,
					Font = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					Size = UDim2.new(0,30,0,20),
					AnchorPoint = Vector2.new(1,0),
					Position = UDim2.new(1, -40,0, 75)
				},'Text','TextColor3',{
					Create('TextBox',{
						Name = 'Box',
						Size = UDim2.new(1,0,1,0),
						BackgroundTransparency = 1,
						Text = '',
						Font = Enum.Font.GothamBold,
						TextSize = 15,
						Position = UDim2.new(1,0,0,0)
					},'Text','TextColor3',{
						Create('Frame',{
							Name = 'Line',
							Size = UDim2.new(0,0,0,2),
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.new(1,1,1),
							AnchorPoint = Vector2.new(.5,1),
							Position = UDim2.new(.5,0,1,0)
						})
					})
				})
				B.Box.Focused:Connect(function()
					B.Box.Line:TweenSize(UDim2.new(1,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				B.Box.FocusLost:Connect(function()
					B.Box.Text = tostring(tonumber(B.Box.Text) or 0)
					B.Box.Line:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,.1)
				end)
				for i,v in next,{R,G,B} do
					v.Box:GetPropertyChangedSignal('Text'):Connect(function()
						clr =  Color3.fromRGB(tonumber(R.Box.Text),tonumber(G.Box.Text),tonumber(B.Box.Text))
						hue,sat,brightness = Color3.toHSV(clr)
						
						RGBar.Marker.Position = UDim2.new(
							.5,
							0,
							hue,
							0
						)
						canvas.ImageColor3 = Color3.fromHSV(hue, 1, 1)
						canvas.Marker.Position = UDim2.new(sat, 0, 1-brightness,0)
						ToggleBut.BackgroundColor3 = Color3.fromHSV(hue,sat,brightness)
						callback(clr)
					end)
				end

				GiveTheme(DDMenu,'Buttons','BackgroundColor3',Color3.fromRGB(-10,-10,-10))
				function buttonstf:Kill()
					Button:Destroy()
					updateTab()
					updateSection()
				end
				function buttonstf:ChangeText(txt)
					Button.Text = txt
				end

				local rainbow = false
				Button2.MouseEnter:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ToggleBut.BackgroundColor3.R * 255 -15,ToggleBut.BackgroundColor3.G * 255 -15,ToggleBut.BackgroundColor3.B * 255 -15)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
				end)
				Button2.MouseLeave:Connect(function()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  ThemeColours.Buttons}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ToggleBut.BackgroundColor3.R * 255 +15,ToggleBut.BackgroundColor3.G * 255 +15,ToggleBut.BackgroundColor3.B * 255 +15)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 10,ThemeColours.Buttons.G * 255 - 10,ThemeColours.Buttons.B * 255 - 10)}):Play()
				end)
				local mr = math.round
				local function MoveMarker(x,y)

					canvas.Marker.Position = UDim2.new(
						0,
						math.clamp(x - canvas.AbsolutePosition.X,0,canvas.AbsoluteSize.X),
						0,
						math.clamp(y - canvas.AbsolutePosition.Y,0,canvas.AbsoluteSize.Y)
					)
				end
				local mouse = game.Players.LocalPlayer:GetMouse()
				local function UpdatePicker()
					local x,y = mouse.X,mouse.Y
					MoveMarker(x,y)
					local rX,rY = x,y
					local sX,sY = (1/canvas.AbsoluteSize.X)*rX,(1/canvas.AbsoluteSize.Y)*rY
					sat = math.clamp((x - canvas.AbsolutePosition.X) / canvas.AbsoluteSize.X, 0, 1)


					brightness = 1 - math.clamp((y - canvas.AbsolutePosition.Y) / canvas.AbsoluteSize.Y, 0, 1)
					clr = Color3.fromHSV(hue,sat,brightness)
				
					ToggleBut.BackgroundColor3 = clr
					R.Box.Text,G.Box.Text,B.Box.Text = tostring(mr(clr.R*255)),tostring(mr(clr.G*255)),tostring(mr(clr.B*255))
					callback(clr)
				end
				local function UpdateSlider()
					local x,y = mouse.X,mouse.Y
					local rX,rY = x-RGBar.AbsolutePosition.X,y-RGBar.AbsolutePosition.Y
					hue = 1 - math.clamp(1 - ((y - RGBar.AbsolutePosition.Y) / RGBar.AbsoluteSize.Y), 0, 1)
					RGBar.Marker.Position = UDim2.new(
						.5,
						0,
						0,
						math.clamp(rY,0,RGBar.AbsoluteSize.Y)
					)
					clr = Color3.fromHSV(hue,sat,brightness)
					canvas.ImageColor3 = Color3.fromHSV(hue, 1, 1)
					ToggleBut.BackgroundColor3 = clr
					R.Box.Text,G.Box.Text,B.Box.Text = tostring(mr(clr.R*255)),tostring(mr(clr.G*255)),tostring(mr(clr.B*255))
					callback(clr)
				end
				local function SetRGB(rgbvd)
					hue,sat,brightness = Color3.toHSV(rgbvd)
					clr = rgbvd
					RGBar.Marker.Position = UDim2.new(
						.5,
						0,
						hue,
						0
					)
					canvas.ImageColor3 = Color3.fromHSV(hue, 1, 1)
					canvas.Marker.Position = UDim2.new(sat, 0, 1-brightness,0)
					ToggleBut.BackgroundColor3 = Color3.fromHSV(hue,sat,brightness)
					R.Box.Text,G.Box.Text,B.Box.Text = tostring(mr(clr.R*255)),tostring(mr(clr.G*255)),tostring(mr(clr.B*255))
					callback(rgbvd)
				end
				SetRGB(clr)
				
				local uis = game:GetService('UserInputService')
				canvas.MouseButton1Down:Connect(function()
					Ripple(canvas)
					UpdatePicker()
					rainbow = false
					local mbe = mouse.Move:Connect(function()
						UpdatePicker()
					end)
					local h
					h = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							h:Disconnect()
							mbe:Disconnect()
						end
					end)
				end)
				RGBar.MouseButton1Down:Connect(function()
					Ripple(RGBar)
					UpdateSlider()
					rainbow = false
					local mbe = mouse.Move:Connect(function()
						UpdateSlider()
					end)
					local h
					h = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							h:Disconnect()
							mbe:Disconnect()
						end
					end)
				end)
				
				local TT = .1
				ToggleBut.MouseButton1Click:Connect(function()
					if section.ClipsDescendants then
						Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y + 105)
						Button.ZIndex = 5
						DDMenu.Transparency = 0
						DDMenu:TweenSize(normsize,Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)
						

						section.ClipsDescendants = false

					else
						Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y)
						DDMenu:TweenSize(UDim2.new(0,normsize.X.Offset,0,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)

						wait(TT)
						DDMenu.Transparency = 1
						Button.ZIndex = 1
						section.ClipsDescendants = true

					end
				end)
				Button2.MouseButton1Click:Connect(function()
					Ripple(Button2)
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 30,ThemeColours.Buttons.G * 255 + 30,ThemeColours.Buttons.B * 255 )}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ToggleBut.BackgroundColor3.R * 255 +20,ToggleBut.BackgroundColor3.G * 255 +20,ToggleBut.BackgroundColor3.B * 255 +20)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 + 20,ThemeColours.Buttons.G * 255 + 20,ThemeColours.Buttons.B * 255 -10)}):Play()
					wait()
					game:GetService('TweenService'):Create(Button,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 5,ThemeColours.Buttons.G * 255 - 5,ThemeColours.Buttons.B * 255 - 5)}):Play()
					game:GetService('TweenService'):Create(ToggleBut,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ToggleBut.BackgroundColor3.R * 255 -20,ToggleBut.BackgroundColor3.G * 255 -20,ToggleBut.BackgroundColor3.B * 255 -20)}):Play()
					game:GetService('TweenService'):Create(DDMenu,TweenInfo.new(.1),{BackgroundColor3 =  Color3.fromRGB(ThemeColours.Buttons.R * 255 - 15,ThemeColours.Buttons.G * 255 - 15,ThemeColours.Buttons.B * 255 - 15)}):Play()
					if section.ClipsDescendants then
						Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y + 105)

						Button.ZIndex = 5
						DDMenu.Transparency = 0
						DDMenu:TweenSize(normsize,Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)


						section.ClipsDescendants = false
					else
						Tab.CanvasSize = UDim2.new(0,0,0,tablisttho.AbsoluteContentSize.Y)

						DDMenu:TweenSize(UDim2.new(0,normsize.X.Offset,0,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,TT)

						wait(TT)
						DDMenu.Transparency = 1
						Button.ZIndex = 1
						section.ClipsDescendants = true
					end
				end)

				ToggleBut4.MouseButton1Click:Connect(function()
					rainbow = true
					sat = 1
					brightness = 1
					hue = 0
					while rainbow do
						wait()
						if not Frame then rainbow = false end
						SetRGB(Color3.fromHSV(hue,1,1))
						hue = hue + .005
					end
				end)
				updateTab()
				updateSection()
				return buttonstf
			end
			return sectionstuff
		end
		updateTabs()
		return tabstuff
	end
	return Tabstbl
end
return library
