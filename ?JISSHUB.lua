--=========================================================
--                 MIGUELITOHUB
--=========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--=========================================================
-- CONFIGURACIÓN
--=========================================================

local DEFAULT_SPEED = 16
local speedValue = DEFAULT_SPEED

-- Bandera de España
local VOX_SKY_TEXTURE = "rbxassetid://5852478589"

--=========================================================
-- COLORES
--=========================================================

local GREEN = Color3.fromRGB(90, 255, 120)
local DARK_GREEN = Color3.fromRGB(10, 35, 18)
local BLACK = Color3.fromRGB(5, 7, 8)
local PURPLE = Color3.fromRGB(180, 60, 255)
local WHITE = Color3.fromRGB(245, 255, 245)

--=========================================================
-- VARIABLES
--=========================================================

local hubOpen = false
local mainHubOpen = false
local speedOpen = false
local antiHitEnabled = false
local espEnabled = false
local voxEnabled = false

local highlights = {}
local antiHitHighlight
local oldSky

--=========================================================
-- GUI
--=========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "MiguelitoHUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--=========================================================
-- FUNCIONES VISUALES
--=========================================================

local function corner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 10)
	c.Parent = obj
	return c
end

local function stroke(obj, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness or 2
	s.Transparency = 0
	s.Parent = obj
	return s
end

local function glow(obj, color)
	local s = stroke(obj, color, 2)

	task.spawn(function()
		while obj.Parent do
			TweenService:Create(
				s,
				TweenInfo.new(
					0.8,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{Transparency = 0.45}
			):Play()

			task.wait(0.8)

			if not obj.Parent then
				break
			end

			TweenService:Create(
				s,
				TweenInfo.new(
					0.8,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{Transparency = 0}
			):Play()

			task.wait(0.8)
		end
	end)
end

local function makeButton(parent, text, height)
	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -20, 0, height or 42)
	button.BackgroundColor3 = Color3.fromRGB(12, 20, 14)
	button.Text = text
	button.TextColor3 = WHITE
	button.TextSize = 16
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.Parent = parent

	corner(button, 8)
	glow(button, GREEN)

	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(20, 50, 27),
				TextColor3 = GREEN
			}
		):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(12, 20, 14),
				TextColor3 = WHITE
			}
		):Play()
	end)

	return button
end

--=========================================================
-- BOTÓN MH
--=========================================================

local mhButton = Instance.new("TextButton")

mhButton.Name = "MHButton"
mhButton.Size = UDim2.fromOffset(70, 70)
mhButton.Position = UDim2.new(0, 20, 0.5, -35)
mhButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mhButton.Text = ""
mhButton.AutoButtonColor = false
mhButton.Parent = gui

corner(mhButton, 14)
glow(mhButton, GREEN)

local emoji = Instance.new("TextLabel")
emoji.Size = UDim2.fromScale(1, 1)
emoji.BackgroundTransparency = 1
emoji.Text = "🥵"
emoji.TextSize = 43
emoji.ZIndex = 2
emoji.Parent = mhButton

local mhText = Instance.new("TextLabel")
mhText.Size = UDim2.fromScale(1, 1)
mhText.BackgroundTransparency = 1
mhText.Text = "MH"
mhText.TextColor3 = WHITE
mhText.TextSize = 25
mhText.Font = Enum.Font.GothamBlack
mhText.ZIndex = 3
mhText.Parent = mhButton

--=========================================================
-- MENÚ INICIAL
--=========================================================

local menu = Instance.new("Frame")

menu.Name = "StartMenu"
menu.Size = UDim2.fromOffset(360, 250)
menu.Position = UDim2.new(0.5, -180, 0.5, -125)
menu.BackgroundColor3 = BLACK
menu.Visible = false
menu.Parent = gui

corner(menu, 15)
glow(menu, GREEN)

local menuTitle = Instance.new("TextLabel")

menuTitle.Size = UDim2.new(1, 0, 0, 70)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "MiguelitoHUB"
menuTitle.TextColor3 = GREEN
menuTitle.TextSize = 32
menuTitle.Font = Enum.Font.GothamBlack
menuTitle.Parent = menu

local playButton = makeButton(menu, "JUGAR", 55)

playButton.Size = UDim2.new(1, -60, 0, 55)
playButton.Position = UDim2.new(0, 30, 0, 110)

--=========================================================
-- HUB PRINCIPAL
--=========================================================

local hub = Instance.new("Frame")

hub.Name = "Hub"
hub.Size = UDim2.new(0, 700, 0, 470)
hub.Position = UDim2.new(0.5, -350, 0.5, -235)
hub.BackgroundColor3 = Color3.fromRGB(5, 8, 6)
hub.Visible = false
hub.Parent = gui

corner(hub, 18)
glow(hub, GREEN)

--=========================================================
-- ESTRELLAS FUGACES
--=========================================================

local starsContainer = Instance.new("Frame")

starsContainer.Size = UDim2.fromScale(1, 1)
starsContainer.BackgroundTransparency = 1
starsContainer.ClipsDescendants = true
starsContainer.ZIndex = 0
starsContainer.Parent = hub

local function createStar()

	local star = Instance.new("Frame")

	star.Size = UDim2.fromOffset(
		math.random(2, 5),
		math.random(10, 30)
	)

	star.BackgroundColor3 = GREEN
	star.BorderSizePixel = 0
	star.BackgroundTransparency = math.random(0, 30) / 100
	star.Rotation = math.random(20, 50)
	star.ZIndex = 0

	star.Position = UDim2.new(
		math.random(),
		0,
		-0.1,
		0
	)

	star.Parent = starsContainer

	local endX = math.random(0, 100) / 100

	local tween = TweenService:Create(
		star,
		TweenInfo.new(
			math.random(15, 30) / 10,
			Enum.EasingStyle.Linear
		),
		{
			Position = UDim2.new(endX, 0, 1.1, 0),
			BackgroundTransparency = 1
		}
	)

	tween:Play()

	tween.Completed:Connect(function()
		star:Destroy()
	end)
end

task.spawn(function()

	while gui.Parent do

		if hub.Visible then
			createStar()
		end

		task.wait(0.15)
	end

end)

--=========================================================
-- TÍTULO
--=========================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -30, 0, 65)
title.Position = UDim2.new(0, 15, 0, 5)
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

sidebar.Size = UDim2.new(0, 165, 1, -85)
sidebar.Position = UDim2.new(0, 15, 0, 75)
sidebar.BackgroundColor3 = Color3.fromRGB(8, 14, 9)
sidebar.ZIndex = 4
sidebar.Parent = hub

corner(sidebar, 12)
stroke(sidebar, Color3.fromRGB(35, 100, 50), 1)

local sideTitle = Instance.new("TextLabel")

sideTitle.Size = UDim2.new(1, 0, 0, 45)
sideTitle.BackgroundTransparency = 1
sideTitle.Text = "NAVEGACIÓN"
sideTitle.TextColor3 = GREEN
sideTitle.TextSize = 15
sideTitle.Font = Enum.Font.GothamBold
sideTitle.ZIndex = 5
sideTitle.Parent = sidebar

local mainTab = makeButton(sidebar, "MAIN", 45)

mainTab.Position = UDim2.new(0, 10, 0, 60)
mainTab.Size = UDim2.new(1, -20, 0, 45)
mainTab.ZIndex = 5

local creditsTab = makeButton(sidebar, "CRÉDITOS", 45)

creditsTab.Position = UDim2.new(0, 10, 0, 115)
creditsTab.Size = UDim2.new(1, -20, 0, 45)
creditsTab.ZIndex = 5

--=========================================================
-- CONTENIDO
--=========================================================

local content = Instance.new("Frame")

content.Size = UDim2.new(1, -200, 1, -85)
content.Position = UDim2.new(0, 190, 0, 75)
content.BackgroundTransparency = 1
content.ZIndex = 4
content.Parent = hub

--=========================================================
-- MAIN
--=========================================================

local mainFrame = Instance.new("Frame")

mainFrame.Size = UDim2.fromScale(1, 1)
mainFrame.BackgroundTransparency = 1
mainFrame.ZIndex = 4
mainFrame.Parent = content

local info = Instance.new("TextLabel")

info.Size = UDim2.new(1, 0, 0, 35)
info.BackgroundTransparency = 1
info.Text = "FUNCIONES"
info.TextColor3 = GREEN
info.TextSize = 18
info.Font = Enum.Font.GothamBold
info.TextXAlignment = Enum.TextXAlignment.Left
info.ZIndex = 5
info.Parent = mainFrame

--=========================================================
-- VELOCIDAD
--=========================================================

local speedButton = makeButton(
	mainFrame,
	"Velocidad",
	45
)

speedButton.Position = UDim2.new(0, 0, 0, 45)
speedButton.ZIndex = 5

local speedPanel = Instance.new("Frame")

speedPanel.Size = UDim2.new(1, 0, 0, 70)
speedPanel.Position = UDim2.new(0, 0, 0, 95)
speedPanel.BackgroundColor3 = Color3.fromRGB(8, 16, 10)
speedPanel.Visible = false
speedPanel.ZIndex = 5
speedPanel.Parent = mainFrame

corner(speedPanel, 8)
stroke(speedPanel, Color3.fromRGB(40, 120, 55), 1)

local speedLabel = Instance.new("TextLabel")

speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: 16"
speedLabel.TextColor3 = WHITE
speedLabel.TextSize = 16
speedLabel.Font = Enum.Font.GothamBold
speedLabel.ZIndex = 6
speedLabel.Parent = speedPanel

local minus = makeButton(speedPanel, "-", 40)

minus.Size = UDim2.fromOffset(45, 40)
minus.Position = UDim2.new(1, -105, 0, 15)
minus.ZIndex = 6

local plus = makeButton(speedPanel, "+", 40)

plus.Size = UDim2.fromOffset(45, 40)
plus.Position = UDim2.new(1, -55, 0, 15)
plus.ZIndex = 6

local function updateSpeed()

	local character = player.Character

	if character then

		local humanoid =
			character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.WalkSpeed = speedValue
		end

	end

	speedLabel.Text =
		"Velocidad: " .. tostring(speedValue)
end

speedButton.MouseButton1Click:Connect(function()

	speedOpen = not speedOpen

	speedPanel.Visible = speedOpen

end)

minus.MouseButton1Click:Connect(function()

	speedValue = math.max(
		8,
		speedValue - 2
	)

	updateSpeed()

end)

plus.MouseButton1Click:Connect(function()

	speedValue = math.min(
		100,
		speedValue + 2
	)

	updateSpeed()

end)

--=========================================================
-- ANTI BATE
--=========================================================

local antiHitButton = makeButton(
	mainFrame,
	"Anti bate",
	45
)

antiHitButton.Position =
	UDim2.new(0, 0, 0, 180)

antiHitButton.ZIndex = 5

local function enableAntiHit()

	local character = player.Character

	if not character then
		return
	end

	local forceField =
		character:FindFirstChild("MiguelitoAntiHit")

	if not forceField then

		forceField = Instance.new("ForceField")

		forceField.Name =
			"MiguelitoAntiHit"

		forceField.Visible = false
		forceField.Parent = character

	end

	if not antiHitHighlight then

		antiHitHighlight =
			Instance.new("Highlight")

		antiHitHighlight.Name =
			"MiguelitoAntiHitbox"

		antiHitHighlight.FillColor =
			PURPLE

		antiHitHighlight.OutlineColor =
			Color3.fromRGB(230, 150, 255)

		antiHitHighlight.FillTransparency = 0.65
		antiHitHighlight.OutlineTransparency = 0

		antiHitHighlight.DepthMode =
			Enum.HighlightDepthMode.Occluded

		antiHitHighlight.Adornee =
			character

		antiHitHighlight.Parent =
			character

	end

end

local function disableAntiHit()

	local character = player.Character

	if character then

		local ff =
			character:FindFirstChild(
				"MiguelitoAntiHit"
			)

		if ff then
			ff:Destroy()
		end

		local h =
			character:FindFirstChild(
				"MiguelitoAntiHitbox"
			)

		if h then
			h:Destroy()
		end

	end

	antiHitHighlight = nil

end

antiHitButton.MouseButton1Click:Connect(function()

	antiHitEnabled =
		not antiHitEnabled

	if antiHitEnabled then

		enableAntiHit()

		antiHitButton.Text =
			"Anti bate  ✓"

	else

		disableAntiHit()

		antiHitButton.Text =
			"Anti bate"

	end

end)

--=========================================================
-- ESP
--=========================================================

local function addESP(otherPlayer)

	if otherPlayer == player then
		return
	end

	local character =
		otherPlayer.Character

	if not character then
		return
	end

	if highlights[otherPlayer] then
		highlights[otherPlayer]:Destroy()
	end

	local highlight =
		Instance.new("Highlight")

	highlight.Name =
		"MiguelitoESP"

	highlight.FillColor =
		PURPLE

	highlight.OutlineColor =
		Color3.fromRGB(235, 150, 255)

	highlight.FillTransparency = 0.7
	highlight.OutlineTransparency = 0

	highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	highlight.Adornee =
		character

	highlight.Parent =
		character

	highlights[otherPlayer] =
		highlight

end

local function removeESP()

	for playerObject, highlight
		in pairs(highlights) do

		if highlight then
			highlight:Destroy()
		end

		highlights[playerObject] = nil

	end

end

local function enableESP()

	for _, otherPlayer
		in ipairs(Players:GetPlayers()) do

		addESP(otherPlayer)

	end

end

local espButton =
	makeButton(mainFrame, "ESP", 45)

espButton.Position =
	UDim2.new(0, 0, 0, 235)

espButton.ZIndex = 5

espButton.MouseButton1Click:Connect(function()

	espEnabled =
		not espEnabled

	if espEnabled then

		enableESP()

		espButton.Text =
			"ESP  ✓"

	else

		removeESP()

		espButton.Text =
			"ESP"

	end

end)

Players.PlayerAdded:Connect(function(newPlayer)

	newPlayer.CharacterAdded:Connect(function()

		task.wait(1)

		if espEnabled then
			addESP(newPlayer)
		end

	end)

end)

--=========================================================
-- VOX - BANDERA DE ESPAÑA
--=========================================================

local function createVOXSky()

	if VOX_SKY_TEXTURE == "rbxassetid://0" then

		warn(
			"MiguelitoHUB: falta la textura del cielo."
		)

		return

	end

	-- Guardar el cielo actual
	local currentSky =
		Lighting:FindFirstChildOfClass("Sky")

	if currentSky then
		oldSky = currentSky:Clone()
	end

	-- Eliminar cielos anteriores
	for _, object
		in ipairs(Lighting:GetChildren()) do

		if object:IsA("Sky") then
			object:Destroy()
		end

	end

	-- Crear cielo VOX
	local sky =
		Instance.new("Sky")

	sky.Name =
		"MiguelitoVOXSky"

	-- Bandera de España
	sky.SkyboxBk =
		VOX_SKY_TEXTURE

	sky.SkyboxDn =
		VOX_SKY_TEXTURE

	sky.SkyboxFt =
		VOX_SKY_TEXTURE

	sky.SkyboxLf =
		VOX_SKY_TEXTURE

	sky.SkyboxRt =
		VOX_SKY_TEXTURE

	sky.SkyboxUp =
		VOX_SKY_TEXTURE

	sky.Parent =
		Lighting

end

local function removeVOXSky()

	local currentSky =
		Lighting:FindFirstChild(
			"MiguelitoVOXSky"
		)

	if currentSky then
		currentSky:Destroy()
	end

	if oldSky then

		oldSky.Parent =
			Lighting

		oldSky = nil

	end

end

local voxButton =
	makeButton(mainFrame, "VOX", 45)

voxButton.Position =
	UDim2.new(0, 0, 0, 290)

voxButton.ZIndex = 5

voxButton.MouseButton1Click:Connect(function()

	voxEnabled =
		not voxEnabled

	if voxEnabled then

		createVOXSky()

		voxButton.Text =
			"VOX  ✓"

	else

		removeVOXSky()

		voxButton.Text =
			"VOX"

	end

end)

--=========================================================
-- CRÉDITOS
--=========================================================

local creditsFrame =
	Instance.new("Frame")

creditsFrame.Size =
	UDim2.fromScale(1, 1)

creditsFrame.BackgroundTransparency = 1
creditsFrame.Visible = false
creditsFrame.ZIndex = 4
creditsFrame.Parent = content

local creditsTitle =
	Instance.new("TextLabel")

creditsTitle.Size =
	UDim2.new(1, 0, 0, 60)

creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "CRÉDITOS"
creditsTitle.TextColor3 = GREEN
creditsTitle.TextSize = 30
creditsTitle.Font = Enum.Font.GothamBlack
creditsTitle.ZIndex = 5
creditsTitle.Parent = creditsFrame

local creditsText =
	Instance.new("TextLabel")

creditsText.Size =
	UDim2.new(1, -20, 0, 100)

creditsText.Position =
	UDim2.new(0, 10, 0, 80)

creditsText.BackgroundTransparency = 1
creditsText.Text = "By Abascal (VOX)"
creditsText.TextColor3 = WHITE
creditsText.TextSize = 22
creditsText.Font = Enum.Font.GothamBold
creditsText.ZIndex = 5
creditsText.Parent = creditsFrame

--=========================================================
-- MAIN / CRÉDITOS
--=========================================================

mainTab.MouseButton1Click:Connect(function()

	mainFrame.Visible = true
	creditsFrame.Visible = false

end)

creditsTab.MouseButton1Click:Connect(function()

	mainFrame.Visible = false
	creditsFrame.Visible = true

end)

--=========================================================
-- BOTÓN MH: ABRIR / CERRAR
--=========================================================

mhButton.MouseButton1Click:Connect(function()

	hubOpen =
		not hubOpen

	if hubOpen then

		menu.Visible = true

	else

		menu.Visible = false
		hub.Visible = false
		mainHubOpen = false

	end

end)

--=========================================================
-- JUGAR
--=========================================================

playButton.MouseButton1Click:Connect(function()

	menu.Visible = false
	hub.Visible = true

	mainHubOpen = true

	mainFrame.Visible = true
	creditsFrame.Visible = false

end)

--=========================================================
-- RESPAWN
--=========================================================

player.CharacterAdded:Connect(function(character)

	task.wait(1)

	if speedValue ~= DEFAULT_SPEED then
		updateSpeed()
	end

	if antiHitEnabled then
		enableAntiHit()
	end

	if espEnabled then
		enableESP()
	end

end)

--=========================================================
-- ARRASTRAR EL HUB
--=========================================================

local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart =
			input.Position

		startPos =
			hub.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false

			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if dragging
		and (
			input.UserInputType ==
				Enum.UserInputType.MouseMovement

			or input.UserInputType ==
				Enum.UserInputType.Touch
		) then

		local delta =
			input.Position - dragStart

		hub.Position =
			UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)

	end

end)

--=========================================================
-- FINAL
--=========================================================

print("====================================")
print("       MIGUELITOHUB CARGADO")
print("       ESPAÑA 🇪🇸")
print("====================================")
