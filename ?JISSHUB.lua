--=========================================================
--                 MIGUELITOHUB
--             SCRIPT PARA WORKSPACE
--=========================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--=========================================================
-- REMOTE EVENT
--=========================================================

local remote = ReplicatedStorage:FindFirstChild("MiguelitoHUB_Remote")

if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "MiguelitoHUB_Remote"
	remote.Parent = ReplicatedStorage
end

--=========================================================
-- LOCAL SCRIPT QUE SE CREARÁ AUTOMÁTICAMENTE
--=========================================================

local clientCode = [[

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--=========================================================
-- CONFIG
--=========================================================

local GREEN = Color3.fromRGB(90,255,120)
local PURPLE = Color3.fromRGB(180,60,255)
local WHITE = Color3.fromRGB(245,255,245)
local BLACK = Color3.fromRGB(5,7,8)

local speed = 16
local speedEnabled = false
local espEnabled = false
local protectionEnabled = false
local voxEnabled = false

local espObjects = {}
local oldSky = nil

-- ID DE LA BANDERA DE ESPAÑA
local VOX_TEXTURE = "rbxassetid://5852478589"

--=========================================================
-- UTILIDADES
--=========================================================

local function corner(object, radius)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,radius or 10)
	c.Parent = object

end

local function outline(object)

	local s = Instance.new("UIStroke")
	s.Color = GREEN
	s.Thickness = 2
	s.Parent = object

	return s

end

local function button(parent,text)

	local b = Instance.new("TextButton")

	b.Size = UDim2.new(1,-20,0,45)
	b.BackgroundColor3 = Color3.fromRGB(10,20,13)

	b.Text = text
	b.TextColor3 = WHITE
	b.TextSize = 16
	b.Font = Enum.Font.GothamBold

	b.AutoButtonColor = false
	b.Parent = parent

	corner(b,8)
	outline(b)

	b.MouseEnter:Connect(function()

		TweenService:Create(
			b,
			TweenInfo.new(.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(20,50,27),

				TextColor3 = GREEN
			}
		):Play()

	end)

	b.MouseLeave:Connect(function()

		TweenService:Create(
			b,
			TweenInfo.new(.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(10,20,13),

				TextColor3 = WHITE
			}
		):Play()

	end)

	return b

end

--=========================================================
-- GUI
--=========================================================

local gui = Instance.new("ScreenGui")

gui.Name = "MiguelitoHUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--=========================================================
-- BOTÓN MH
--=========================================================

local mh = Instance.new("TextButton")

mh.Name = "MH"
mh.Size = UDim2.fromOffset(70,70)
mh.Position = UDim2.new(0,20,.5,-35)

mh.BackgroundColor3 =
	Color3.fromRGB(10,10,10)

mh.Text = "🥵\nMH"
mh.TextColor3 = WHITE
mh.TextSize = 20
mh.Font = Enum.Font.GothamBlack

mh.AutoButtonColor = false
mh.Parent = gui

corner(mh,14)
outline(mh)

--=========================================================
-- MENÚ
--=========================================================

local menu = Instance.new("Frame")

menu.Size = UDim2.fromOffset(360,250)
menu.Position = UDim2.new(.5,-180,.5,-125)

menu.BackgroundColor3 = BLACK
menu.Visible = false
menu.Parent = gui

corner(menu,15)
outline(menu)

local menuTitle = Instance.new("TextLabel")

menuTitle.Size = UDim2.new(1,0,0,70)
menuTitle.BackgroundTransparency = 1

menuTitle.Text = "MiguelitoHUB"
menuTitle.TextColor3 = GREEN
menuTitle.TextSize = 32
menuTitle.Font = Enum.Font.GothamBlack

menuTitle.Parent = menu

local play = button(menu,"JUGAR")

play.Size = UDim2.new(1,-60,0,55)
play.Position = UDim2.new(0,30,0,110)

--=========================================================
-- HUB
--=========================================================

local hub = Instance.new("Frame")

hub.Size = UDim2.fromOffset(700,470)
hub.Position = UDim2.new(.5,-350,.5,-235)

hub.BackgroundColor3 =
	Color3.fromRGB(5,8,6)

hub.Visible = false
hub.Parent = gui

corner(hub,18)
outline(hub)

--=========================================================
-- ESTRELLAS
--=========================================================

local stars = Instance.new("Frame")

stars.Size = UDim2.fromScale(1,1)
stars.BackgroundTransparency = 1
stars.ClipsDescendants = true

stars.ZIndex = 0
stars.Parent = hub

local function createStar()

	local s = Instance.new("Frame")

	s.Size = UDim2.fromOffset(
		math.random(2,5),
		math.random(10,30)
	)

	s.BackgroundColor3 = GREEN
	s.BorderSizePixel = 0

	s.Position = UDim2.new(
		math.random(),
		0,
		-0.1,
		0
	)

	s.Rotation = math.random(20,50)
	s.Parent = stars

	local tween = TweenService:Create(
		s,
		TweenInfo.new(
			math.random(15,30)/10,
			Enum.EasingStyle.Linear
		),
		{
			Position =
				UDim2.new(
					math.random(),
					0,
					1.1,
					0
				),

			BackgroundTransparency = 1
		}
	)

	tween:Play()

	tween.Completed:Connect(function()
		s:Destroy()
	end)

end

task.spawn(function()

	while gui.Parent do

		if hub.Visible then
			createStar()
		end

		task.wait(.15)

	end

end)

--=========================================================
-- TÍTULO
--=========================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1,-30,0,65)
title.Position = UDim2.new(0,15,0,5)

title.BackgroundTransparency = 1
title.Text = "MiguelitoHUB"

title.TextColor3 = GREEN
title.TextSize = 35
title.Font = Enum.Font.GothamBlack

title.ZIndex = 5
title.Parent = hub

--=========================================================
-- SIDEBAR
--=========================================================

local sidebar = Instance.new("Frame")

sidebar.Size = UDim2.new(0,165,1,-85)
sidebar.Position = UDim2.new(0,15,0,75)

sidebar.BackgroundColor3 =
	Color3.fromRGB(8,14,9)

sidebar.ZIndex = 4
sidebar.Parent = hub

corner(sidebar,12)

local nav = Instance.new("TextLabel")

nav.Size = UDim2.new(1,0,0,45)
nav.BackgroundTransparency = 1

nav.Text = "NAVEGACIÓN"
nav.TextColor3 = GREEN
nav.TextSize = 15
nav.Font = Enum.Font.GothamBold

nav.ZIndex = 5
nav.Parent = sidebar

local mainTab = button(sidebar,"MAIN")

mainTab.Position = UDim2.new(0,10,0,60)
mainTab.Size = UDim2.new(1,-20,0,45)
mainTab.ZIndex = 5

local creditsTab = button(sidebar,"CRÉDITOS")

creditsTab.Position = UDim2.new(0,10,0,115)
creditsTab.Size = UDim2.new(1,-20,0,45)
creditsTab.ZIndex = 5

--=========================================================
-- CONTENIDO
--=========================================================

local content = Instance.new("Frame")

content.Size = UDim2.new(1,-200,1,-85)
content.Position = UDim2.new(0,190,0,75)

content.BackgroundTransparency = 1
content.ZIndex = 4
content.Parent = hub

--=========================================================
-- MAIN
--=========================================================

local main = Instance.new("Frame")

main.Size = UDim2.fromScale(1,1)
main.BackgroundTransparency = 1

main.ZIndex = 4
main.Parent = content

local label = Instance.new("TextLabel")

label.Size = UDim2.new(1,0,0,35)

label.BackgroundTransparency = 1
label.Text = "FUNCIONES"

label.TextColor3 = GREEN
label.TextSize = 18
label.Font = Enum.Font.GothamBold

label.TextXAlignment =
	Enum.TextXAlignment.Left

label.ZIndex = 5
label.Parent = main

--=========================================================
-- VELOCIDAD
--=========================================================

local speedButton =
	button(main,"Velocidad")

speedButton.Position =
	UDim2.new(0,0,0,45)

speedButton.ZIndex = 5

local speedPanel = Instance.new("Frame")

speedPanel.Size =
	UDim2.new(1,0,0,70)

speedPanel.Position =
	UDim2.new(0,0,0,95)

speedPanel.BackgroundColor3 =
	Color3.fromRGB(8,16,10)

speedPanel.Visible = false

speedPanel.ZIndex = 5
speedPanel.Parent = main

corner(speedPanel,8)
outline(speedPanel)

local speedLabel = Instance.new("TextLabel")

speedLabel.Size =
	UDim2.new(.5,0,1,0)

speedLabel.BackgroundTransparency = 1

speedLabel.Text =
	"Velocidad: 16"

speedLabel.TextColor3 = WHITE
speedLabel.TextSize = 16
speedLabel.Font = Enum.Font.GothamBold

speedLabel.ZIndex = 6
speedLabel.Parent = speedPanel

local minus =
	button(speedPanel,"-")

minus.Size =
	UDim2.fromOffset(45,40)

minus.Position =
	UDim2.new(1,-105,0,15)

minus.ZIndex = 6

local plus =
	button(speedPanel,"+")

plus.Size =
	UDim2.fromOffset(45,40)

plus.Position =
	UDim2.new(1,-55,0,15)

plus.ZIndex = 6

local function updateSpeed()

	local character =
		player.Character

	if character then

		local humanoid =
			character:FindFirstChildOfClass(
				"Humanoid"
			)

		if humanoid then

			humanoid.WalkSpeed =
				speedEnabled and speed or 16

		end

	end

	speedLabel.Text =
		"Velocidad: " .. speed

end

speedButton.MouseButton1Click:Connect(function()

	speedEnabled =
		not speedEnabled

	speedPanel.Visible =
		speedEnabled

	updateSpeed()

end)

minus.MouseButton1Click:Connect(function()

	speed =
		math.max(8,speed-2)

	updateSpeed()

end)

plus.MouseButton1Click:Connect(function()

	speed =
		math.min(100,speed+2)

	updateSpeed()

end)

--=========================================================
-- PROTECCIÓN
--=========================================================

local protection =
	button(main,"Protección")

protection.Position =
	UDim2.new(0,0,0,180)

protection.ZIndex = 5

local function updateProtection()

	local character =
		player.Character

	if not character then
		return
	end

	local old =
		character:FindFirstChild(
			"MiguelitoProtection"
		)

	if old then
		old:Destroy()
	end

	if protectionEnabled then

		local highlight =
			Instance.new("Highlight")

		highlight.Name =
			"MiguelitoProtection"

		highlight.FillColor =
			PURPLE

		highlight.OutlineColor =
			Color3.fromRGB(
				230,150,255
			)

		highlight.FillTransparency = .65
		highlight.OutlineTransparency = 0

		highlight.Adornee =
			character

		highlight.Parent =
			character

	end

end

protection.MouseButton1Click:Connect(function()

	protectionEnabled =
		not protectionEnabled

	protection.Text =
		protectionEnabled
		and "Protección ✓"
		or "Protección"

	updateProtection()

end)

--=========================================================
-- ESP
--=========================================================

local esp =
	button(main,"ESP")

esp.Position =
	UDim2.new(0,0,0,235)

esp.ZIndex = 5

local function removeESP()

	for p,h in pairs(espObjects) do

		if h then
			h:Destroy()
		end

		espObjects[p] = nil

	end

end

local function addESP(p)

	if p == player then
		return
	end

	local character =
		p.Character

	if not character then
		return
	end

	if espObjects[p] then
		espObjects[p]:Destroy()
	end

	local h =
		Instance.new("Highlight")

	h.Name =
		"MiguelitoESP"

	h.FillColor =
		PURPLE

	h.OutlineColor =
		Color3.fromRGB(
			235,150,255
		)

	h.FillTransparency = .7
	h.OutlineTransparency = 0

	h.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	h.Adornee =
		character

	h.Parent =
		character

	espObjects[p] = h

end

local function enableESP()

	for _,p in ipairs(
		Players:GetPlayers()
	) do

		addESP(p)

	end

end

esp.MouseButton1Click:Connect(function()

	espEnabled =
		not espEnabled

	if espEnabled then

		enableESP()

		esp.Text =
			"ESP ✓"

	else

		removeESP()

		esp.Text =
			"ESP"

	end

end)

Players.PlayerAdded:Connect(function(p)

	p.CharacterAdded:Connect(function()

		task.wait(1)

		if espEnabled then
			addESP(p)
		end

	end)

end)

--=========================================================
-- VOX / BANDERA
--=========================================================

local function enableVOX()

	local current =
		Lighting:FindFirstChildOfClass(
			"Sky"
		)

	if current then
		oldSky = current:Clone()
	end

	for _,obj in ipairs(
		Lighting:GetChildren()
	) do

		if obj:IsA("Sky") then
			obj:Destroy()
		end

	end

	local sky =
		Instance.new("Sky")

	sky.Name =
		"MiguelitoVOXSky"

	sky.SkyboxBk = VOX_TEXTURE
	sky.SkyboxDn = VOX_TEXTURE
	sky.SkyboxFt = VOX_TEXTURE
	sky.SkyboxLf = VOX_TEXTURE
	sky.SkyboxRt = VOX_TEXTURE
	sky.SkyboxUp = VOX_TEXTURE

	sky.Parent =
		Lighting

end

local function disableVOX()

	local sky =
		Lighting:FindFirstChild(
			"MiguelitoVOXSky"
		)

	if sky then
		sky:Destroy()
	end

	if oldSky then

		oldSky.Parent =
			Lighting

		oldSky = nil

	end

end

local vox =
	button(main,"VOX")

vox.Position =
	UDim2.new(0,0,0,290)

vox.ZIndex = 5

vox.MouseButton1Click:Connect(function()

	voxEnabled =
		not voxEnabled

	if voxEnabled then

		enableVOX()

		vox.Text =
			"VOX ✓"

	else

		disableVOX()

		vox.Text =
			"VOX"

	end

end)

--=========================================================
-- CRÉDITOS
--=========================================================

local credits =
	Instance.new("Frame")

credits.Size =
	UDim2.fromScale(1,1)

credits.BackgroundTransparency = 1
credits.Visible = false

credits.ZIndex = 4
credits.Parent = content

local creditTitle =
	Instance.new("TextLabel")

creditTitle.Size =
	UDim2.new(1,0,0,60)

creditTitle.BackgroundTransparency = 1

creditTitle.Text =
	"CRÉDITOS"

creditTitle.TextColor3 =
	GREEN

creditTitle.TextSize = 30
creditTitle.Font =
	Enum.Font.GothamBlack

creditTitle.ZIndex = 5
creditTitle.Parent = credits

local creditText =
	Instance.new("TextLabel")

creditText.Size =
	UDim2.new(1,-20,0,100)

creditText.Position =
	UDim2.new(0,10,0,80)

creditText.BackgroundTransparency = 1

creditText.Text =
	"By Abascal (VOX)"

creditText.TextColor3 =
	WHITE

creditText.TextSize = 22
creditText.Font =
	Enum.Font.GothamBold

creditText.ZIndex = 5
creditText.Parent = credits

--=========================================================
-- TABS
--=========================================================

mainTab.MouseButton1Click:Connect(function()

	main.Visible = true
	credits.Visible = false

end)

creditsTab.MouseButton1Click:Connect(function()

	main.Visible = false
	credits.Visible = true

end)

--=========================================================
-- ABRIR MH
--=========================================================

mh.MouseButton1Click:Connect(function()

	menu.Visible =
		not menu.Visible

end)

play.MouseButton1Click:Connect(function()

	menu.Visible = false
	hub.Visible = true

end)

--=========================================================
-- RESPAWN
--=========================================================

player.CharacterAdded:Connect(function()

	task.wait(1)

	if speedEnabled then
		updateSpeed()
	end

	if protectionEnabled then
		updateProtection()
	end

	if espEnabled then
		enableESP()
	end

end)

]]

--=========================================================
-- CREAR LOCAL SCRIPT AUTOMÁTICAMENTE
--=========================================================

local function setupPlayer(player)

	local playerScripts =
		player:WaitForChild("PlayerScripts")

	local old =
		playerScripts:FindFirstChild(
			"MiguelitoHUB_Client"
		)

	if old then
		old:Destroy()
	end

	local localScript =
		Instance.new("LocalScript")

	localScript.Name =
		"MiguelitoHUB_Client"

	-- Roblox permite asignar Source a scripts
	-- creados desde el servidor únicamente
	-- en entornos donde el código sea generado
	-- previamente.

	localScript.Source = clientCode

	localScript.Parent =
		playerScripts

end

--=========================================================
-- JUGADORES
--=========================================================

Players.PlayerAdded:Connect(function(player)

	setupPlayer(player)

end)

for _,player in ipairs(
	Players:GetPlayers()
) do

	task.spawn(function()
		setupPlayer(player)
	end)

end

print("====================================")
print("      MIGUELITOHUB SERVER")
print("      CARGADO CORRECTAMENTE")
print("====================================")
