--// JISSHUB v1
--// LocalScript
--// Colocar en StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- CONFIGURACIÓN
--------------------------------------------------

local BLUE = Color3.fromRGB(0, 180, 255)
local CYAN = Color3.fromRGB(0, 255, 220)
local DARK = Color3.fromRGB(3, 8, 20)
local WHITE = Color3.fromRGB(235, 250, 255)

local infiniteJump = false
local traspasa = false
local menuOpen = false

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "JISSHUB_GUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--------------------------------------------------
-- BOTÓN JISSHUB
--------------------------------------------------

local openButton = Instance.new("TextButton")
openButton.Name = "JISSHUB_Button"
openButton.Size = UDim2.fromOffset(135, 60)
openButton.Position = UDim2.new(0, 20, 0.5, -30)
openButton.BackgroundColor3 = DARK
openButton.BorderSizePixel = 0
openButton.Text = ""
openButton.AutoButtonColor = false
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 12)
openCorner.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Color = BLUE
openStroke.Thickness = 2
openStroke.Parent = openButton

local diamond = Instance.new("TextLabel")
diamond.Size = UDim2.fromScale(1, 1)
diamond.BackgroundTransparency = 1
diamond.Text = "◆"
diamond.TextColor3 = BLUE
diamond.TextTransparency = 0.25
diamond.TextSize = 45
diamond.Font = Enum.Font.GothamBlack
diamond.ZIndex = 1
diamond.Parent = openButton

local openText = Instance.new("TextLabel")
openText.Size = UDim2.fromScale(1, 1)
openText.BackgroundTransparency = 1
openText.Text = "JISSHUB"
openText.TextColor3 = WHITE
openText.TextSize = 21
openText.Font = Enum.Font.GothamBlack
openText.ZIndex = 2
openText.Parent = openButton

--------------------------------------------------
-- MENÚ
--------------------------------------------------

local menu = Instance.new("Frame")
menu.Name = "JISSHUB_Menu"
menu.Size = UDim2.fromOffset(550, 400)
menu.Position = UDim2.new(0.5, -275, 0.5, -200)
menu.BackgroundColor3 = DARK
menu.BackgroundTransparency = 0.08
menu.BorderSizePixel = 0
menu.Visible = false
menu.ClipsDescendants = true
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 18)
menuCorner.Parent = menu

--------------------------------------------------
-- AURORA BOREAL
--------------------------------------------------

local aurora1 = Instance.new("Frame")
aurora1.Size = UDim2.new(1.5, 0, 0.75, 0)
aurora1.Position = UDim2.new(-0.25, 0, -0.25, 0)
aurora1.BackgroundColor3 = Color3.fromRGB(0, 110, 150)
aurora1.BackgroundTransparency = 0.72
aurora1.BorderSizePixel = 0
aurora1.Rotation = -8
aurora1.ZIndex = 0
aurora1.Parent = menu

local aurora1Corner = Instance.new("UICorner")
aurora1Corner.CornerRadius = UDim.new(1, 0)
aurora1Corner.Parent = aurora1

local aurora2 = Instance.new("Frame")
aurora2.Size = UDim2.new(1.4, 0, 0.7, 0)
aurora2.Position = UDim2.new(-0.1, 0, -0.15, 0)
aurora2.BackgroundColor3 = Color3.fromRGB(80, 30, 190)
aurora2.BackgroundTransparency = 0.78
aurora2.BorderSizePixel = 0
aurora2.Rotation = 8
aurora2.ZIndex = 0
aurora2.Parent = menu

local aurora2Corner = Instance.new("UICorner")
aurora2Corner.CornerRadius = UDim.new(1, 0)
aurora2Corner.Parent = aurora2

local aurora3 = Instance.new("Frame")
aurora3.Size = UDim2.new(1.3, 0, 0.65, 0)
aurora3.Position = UDim2.new(0.05, 0, -0.05, 0)
aurora3.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
aurora3.BackgroundTransparency = 0.86
aurora3.BorderSizePixel = 0
aurora3.Rotation = -4
aurora3.ZIndex = 0
aurora3.Parent = menu

local aurora3Corner = Instance.new("UICorner")
aurora3Corner.CornerRadius = UDim.new(1, 0)
aurora3Corner.Parent = aurora3

--------------------------------------------------
-- ANIMACIÓN AURORA
--------------------------------------------------

task.spawn(function()

	while gui.Parent do

		TweenService:Create(
			aurora1,
			TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(-0.05, 0, -0.12, 0),
				Rotation = 5
			}
		):Play()

		TweenService:Create(
			aurora2,
			TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(-0.25, 0, -0.05, 0),
				Rotation = -5
			}
		):Play()

		TweenService:Create(
			aurora3,
			TweenInfo.new(4.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(-0.1, 0, -0.15, 0),
				Rotation = 8
			}
		):Play()

		task.wait(4)

		TweenService:Create(
			aurora1,
			TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(-0.25, 0, -0.25, 0),
				Rotation = -8
			}
		):Play()

		TweenService:Create(
			aurora2,
			TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(-0.1, 0, -0.15, 0),
				Rotation = 8
			}
		):Play()

		TweenService:Create(
			aurora3,
			TweenInfo.new(4.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Position = UDim2.new(0.05, 0, -0.05, 0),
				Rotation = -4
			}
		):Play()

		task.wait(4)
	end
end)

--------------------------------------------------
-- BORDE NEÓN
--------------------------------------------------

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = BLUE
menuStroke.Thickness = 3
menuStroke.Parent = menu

local glow = Instance.new("UIStroke")
glow.Color = CYAN
glow.Thickness = 7
glow.Transparency = 0.75
glow.Parent = menu

task.spawn(function()

	while gui.Parent do

		TweenService:Create(
			menuStroke,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Transparency = 0.35,
				Thickness = 4
			}
		):Play()

		TweenService:Create(
			glow,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Transparency = 0.45,
				Thickness = 10
			}
		):Play()

		task.wait(0.8)

		TweenService:Create(
			menuStroke,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Transparency = 0,
				Thickness = 3
			}
		):Play()

		TweenService:Create(
			glow,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				Transparency = 0.75,
				Thickness = 7
			}
		):Play()

		task.wait(0.8)
	end
end)

--------------------------------------------------
-- PARTÍCULAS
--------------------------------------------------

local particleFolder = Instance.new("Folder")
particleFolder.Name = "BlueParticles"
particleFolder.Parent = menu

task.spawn(function()

	while gui.Parent do

		if menu.Visible then

			local p = Instance.new("Frame")
			local size = math.random(2, 6)

			p.Size = UDim2.fromOffset(size, size)
			p.Position = UDim2.new(
				math.random(0, 100) / 100,
				0,
				-0.05,
				0
			)

			p.BackgroundColor3 = BLUE
			p.BackgroundTransparency = math.random(20, 60) / 100
			p.BorderSizePixel = 0
			p.ZIndex = 1
			p.Parent = particleFolder

			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(1, 0)
			corner.Parent = p

			local tween = TweenService:Create(
				p,
				TweenInfo.new(
					math.random(3, 6),
					Enum.EasingStyle.Linear
				),
				{
					Position = UDim2.new(
						p.Position.X.Scale,
						0,
						1.1,
						0
					)
				}
			)

			tween:Play()

			tween.Completed:Connect(function()
				p:Destroy()
			end)
		end

		task.wait(0.12)
	end
end)

--------------------------------------------------
-- TÍTULO
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 55)
title.Position = UDim2.fromOffset(20, 8)
title.BackgroundTransparency = 1
title.Text = "JISSHUB v1"
title.TextColor3 = WHITE
title.TextSize = 32
title.Font = Enum.Font.Arcade
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 5
title.Parent = menu

local line = Instance.new("Frame")
line.Size = UDim2.new(1, -40, 0, 2)
line.Position = UDim2.fromOffset(20, 68)
line.BackgroundColor3 = BLUE
line.BorderSizePixel = 0
line.ZIndex = 5
line.Parent = menu

--------------------------------------------------
-- TABS
--------------------------------------------------

local tabs = Instance.new("Frame")
tabs.Size = UDim2.fromOffset(155, 285)
tabs.Position = UDim2.fromOffset(15, 85)
tabs.BackgroundColor3 = Color3.fromRGB(3, 9, 20)
tabs.BackgroundTransparency = 0.15
tabs.BorderSizePixel = 0
tabs.ZIndex = 5
tabs.Parent = menu

local tabsCorner = Instance.new("UICorner")
tabsCorner.CornerRadius = UDim.new(0, 12)
tabsCorner.Parent = tabs

local tabsStroke = Instance.new("UIStroke")
tabsStroke.Color = BLUE
tabsStroke.Thickness = 1
tabsStroke.Parent = tabs

--------------------------------------------------
-- CONTENIDO
--------------------------------------------------

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -185, 0, 285)
content.Position = UDim2.fromOffset(175, 85)
content.BackgroundTransparency = 1
content.ZIndex = 5
content.Parent = menu

--------------------------------------------------
-- FUNCIÓN CREAR BOTÓN
--------------------------------------------------

local function createButton(parent, text, position, size)

	local button = Instance.new("TextButton")

	button.Size = size
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(5, 25, 45)
	button.BackgroundTransparency = 0.05
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = WHITE
	button.TextSize = 16
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.ZIndex = 10
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = BLUE
	stroke.Thickness = 2
	stroke.Parent = button

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(0, 60, 95)
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.15),
			{
				Thickness = 4
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(5, 25, 45)
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.15),
			{
				Thickness = 2
			}
		):Play()

	end)

	return button
end

--------------------------------------------------
-- PESTAÑAS
--------------------------------------------------

local mainTab = createButton(
	tabs,
	"MAIN",
	UDim2.fromOffset(10, 20),
	UDim2.new(1, -20, 0, 55)
)

local creditsTab = createButton(
	tabs,
	"CRÉDITOS",
	UDim2.fromOffset(10, 90),
	UDim2.new(1, -20, 0, 55)
)

--------------------------------------------------
-- MAIN
--------------------------------------------------

local mainPage = Instance.new("Frame")
mainPage.Size = UDim2.fromScale(1, 1)
mainPage.BackgroundTransparency = 1
mainPage.ZIndex = 6
mainPage.Parent = content

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0, 40)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "MAIN"
mainTitle.TextColor3 = BLUE
mainTitle.TextSize = 25
mainTitle.Font = Enum.Font.GothamBlack
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.ZIndex = 10
mainTitle.Parent = mainPage

--------------------------------------------------
-- SALTO INFINITO
--------------------------------------------------

local infiniteButton = createButton(
	mainPage,
	"Salto Infinito: DESACTIVADO",
	UDim2.fromOffset(0, 55),
	UDim2.new(1, -5, 0, 60)
)

infiniteButton.MouseButton1Click:Connect(function()

	infiniteJump = not infiniteJump

	if infiniteJump then

		infiniteButton.Text = "Salto Infinito: ACTIVADO"
		infiniteButton.TextColor3 = CYAN

	else

		infiniteButton.Text = "Salto Infinito: DESACTIVADO"
		infiniteButton.TextColor3 = WHITE

	end
end)

--------------------------------------------------
-- TRASPASA
--------------------------------------------------

local traspasaButton = createButton(
	mainPage,
	"Traspasa: DESACTIVADO",
	UDim2.fromOffset(0, 130),
	UDim2.new(1, -5, 0, 60)
)

local function updateCollision()

	local character = player.Character

	if not character then
		return
	end

	for _, object in ipairs(character:GetDescendants()) do

		if object:IsA("BasePart") then
			object.CanCollide = not traspasa
		end

	end
end

traspasaButton.MouseButton1Click:Connect(function()

	traspasa = not traspasa

	if traspasa then

		traspasaButton.Text = "Traspasa: ACTIVADO"
		traspasaButton.TextColor3 = CYAN

		TweenService:Create(
			traspasaButton,
			TweenInfo.new(0.2),
			{
				BackgroundColor3 = Color3.fromRGB(0, 70, 80)
			}
		):Play()

	else

		traspasaButton.Text = "Traspasa: DESACTIVADO"
		traspasaButton.TextColor3 = WHITE

		TweenService:Create(
			traspasaButton,
			TweenInfo.new(0.2),
			{
				BackgroundColor3 = Color3.fromRGB(5, 25, 45)
			}
		):Play()

	end

	updateCollision()
end)

--------------------------------------------------
-- MANTENER TRASPASA
--------------------------------------------------

RunService.Stepped:Connect(function()

	if traspasa then
		updateCollision()
	end

end)

--------------------------------------------------
-- CRÉDITOS
--------------------------------------------------

local creditsPage = Instance.new("Frame")
creditsPage.Size = UDim2.fromScale(1, 1)
creditsPage.BackgroundTransparency = 1
creditsPage.Visible = false
creditsPage.ZIndex = 6
creditsPage.Parent = content

local creditsTitle = Instance.new("TextLabel")
creditsTitle.Size = UDim2.new(1, 0, 0, 40)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "CRÉDITOS"
creditsTitle.TextColor3 = BLUE
creditsTitle.TextSize = 25
creditsTitle.Font = Enum.Font.GothamBlack
creditsTitle.TextXAlignment = Enum.TextXAlignment.Left
creditsTitle.ZIndex = 10
creditsTitle.Parent = creditsPage

local creditsText = Instance.new("TextLabel")
creditsText.Size = UDim2.new(1, -10, 0, 150)
creditsText.Position = UDim2.fromOffset(0, 60)
creditsText.BackgroundTransparency = 1
creditsText.Text =
	"Screth: Owner/Creator.\n\n" ..
	"Isma: Ayudante Sicológico"
creditsText.TextColor3 = WHITE
creditsText.TextSize = 19
creditsText.Font = Enum.Font.GothamBold
creditsText.TextWrapped = true
creditsText.TextXAlignment = Enum.TextXAlignment.Left
creditsText.TextYAlignment = Enum.TextYAlignment.Top
creditsText.ZIndex = 10
creditsText.Parent = creditsPage

--------------------------------------------------
-- CAMBIO DE SECCIÓN
--------------------------------------------------

mainTab.MouseButton1Click:Connect(function()
	mainPage.Visible = true
	creditsPage.Visible = false
end)

creditsTab.MouseButton1Click:Connect(function()
	mainPage.Visible = false
	creditsPage.Visible = true
end)

--------------------------------------------------
-- ABRIR / CERRAR MENÚ
--------------------------------------------------

openButton.MouseButton1Click:Connect(function()

	menuOpen = not menuOpen

	if menuOpen then

		menu.Visible = true
		menu.Size = UDim2.fromOffset(0, 0)

		TweenService:Create(
			menu,
			TweenInfo.new(
				0.35,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.fromOffset(550, 400)
			}
		):Play()

	else

		local closeTween = TweenService:Create(
			menu,
			TweenInfo.new(
				0.25,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.In
			),
			{
				Size = UDim2.fromOffset(0, 0)
			}
		)

		closeTween:Play()

		closeTween.Completed:Connect(function()

			if not menuOpen then
				menu.Visible = false
			end

		end)

	end
end)

--------------------------------------------------
-- INFINITE JUMP
--------------------------------------------------

UserInputService.JumpRequest:Connect(function()

	if not infiniteJump then
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid:ChangeState(
			Enum.HumanoidStateType.Jumping
		)
	end

end)

--------------------------------------------------
-- RESPAWN
--------------------------------------------------

player.CharacterAdded:Connect(function()

	task.wait(0.5)

	if traspasa then
		updateCollision()
	end

end)

print("JISSHUB v1 cargado correctamente.")
