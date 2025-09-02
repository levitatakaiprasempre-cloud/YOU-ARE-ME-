-- Script para Delta Executor - Saber Showdown
-- Kill Aura, Anti Slap, Anti-Ban, Anti-Kick
-- GUI estilo Dragon Ball

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Configurações iniciais
local KillAura = true
local KillAuraRange = 15
local AntiSlap = true
local AntiBan = true
local AntiKick = true

-- Funções de proteção
if AntiBan then
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "Kick" or method == "kick" then
            if AntiKick then
                return nil
            end
        end
        
        return old(...)
    end)
end

-- Função Anti Slap
if AntiSlap then
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SlapEvent").OnClientEvent:Connect(function()
        if AntiSlap then
            return
        end
    end)
end

-- Função Kill Aura
local function KillAuraFunction()
    if not KillAura or not LocalPlayer.Character then return end
    
    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = player.Character:FindFirstChild("Humanoid")
            
            if targetHRP and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (humanoidRootPart.Position - targetHRP.Position).Magnitude
                
                if distance <= KillAuraRange then
                    -- Simular ataque
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SlapEvent"):FireServer(player)
                end
            end
        end
    end
end

-- Criar GUI estilo Dragon Ball
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DragonBallGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Header com drag
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 30)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0.5, -100, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SABER SHOWDOWN - DBZ"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Header

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = Header

-- Conteúdo
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Abas
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, 0, 0, 40)
Tabs.Position = UDim2.new(0, 0, 0, 0)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Content

local CombatTabButton = Instance.new("TextButton")
CombatTabButton.Name = "CombatTabButton"
CombatTabButton.Size = UDim2.new(0.5, 0, 1, 0)
CombatTabButton.Position = UDim2.new(0, 0, 0, 0)
CombatTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CombatTabButton.BorderSizePixel = 0
CombatTabButton.Text = "COMBATE"
CombatTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CombatTabButton.Font = Enum.Font.GothamBold
CombatTabButton.TextSize = 14
CombatTabButton.Parent = Tabs

local SettingsTabButton = Instance.new("TextButton")
SettingsTabButton.Name = "SettingsTabButton"
SettingsTabButton.Size = UDim2.new(0.5, 0, 1, 0)
SettingsTabButton.Position = UDim2.new(0.5, 0, 0, 0)
SettingsTabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsTabButton.BorderSizePixel = 0
SettingsTabButton.Text = "PROTEÇÕES"
SettingsTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTabButton.Font = Enum.Font.GothamBold
SettingsTabButton.TextSize = 14
SettingsTabButton.Parent = Tabs

-- Container das abas
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, 0, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Content

-- Aba de Combate
local CombatTab = Instance.new("ScrollingFrame")
CombatTab.Name = "CombatTab"
CombatTab.Size = UDim2.new(1, 0, 1, 0)
CombatTab.Position = UDim2.new(0, 0, 0, 0)
CombatTab.BackgroundTransparency = 1
CombatTab.Visible = true
CombatTab.ScrollBarThickness = 4
CombatTab.CanvasSize = UDim2.new(0, 0, 0, 300)
CombatTab.Parent = TabContainer

-- Aba de Configurações
local SettingsTab = Instance.new("ScrollingFrame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.Position = UDim2.new(0, 0, 0, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
SettingsTab.ScrollBarThickness = 4
SettingsTab.CanvasSize = UDim2.new(0, 0, 0, 200)
SettingsTab.Parent = TabContainer

-- Elementos da aba de combate
local KillAuraToggle = Instance.new("TextButton")
KillAuraToggle.Name = "KillAuraToggle"
KillAuraToggle.Size = UDim2.new(0.9, 0, 0, 40)
KillAuraToggle.Position = UDim2.new(0.05, 0, 0, 10)
KillAuraToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KillAuraToggle.BorderSizePixel = 0
KillAuraToggle.Text = "KILL AURA: DESATIVADO"
KillAuraToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAuraToggle.Font = Enum.Font.GothamBold
KillAuraToggle.TextSize = 14
KillAuraToggle.Parent = CombatTab

local RangeLabel = Instance.new("TextLabel")
RangeLabel.Name = "RangeLabel"
RangeLabel.Size = UDim2.new(0.9, 0, 0, 20)
RangeLabel.Position = UDim2.new(0.05, 0, 0, 60)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "ALCANCE: " .. tostring(KillAuraRange)
RangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.TextSize = 14
RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
RangeLabel.Parent = CombatTab

local RangeSlider = Instance.new("TextButton")
RangeSlider.Name = "RangeSlider"
RangeSlider.Size = UDim2.new(0.9, 0, 0, 20)
RangeSlider.Position = UDim2.new(0.05, 0, 0, 85)
RangeSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
RangeSlider.BorderSizePixel = 0
RangeSlider.Text = ""
RangeSlider.Parent = CombatTab

local RangeFill = Instance.new("Frame")
RangeFill.Name = "RangeFill"
RangeFill.Size = UDim2.new((KillAuraRange - 5) / 25, 0, 1, 0)
RangeFill.Position = UDim2.new(0, 0, 0, 0)
RangeFill.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
RangeFill.BorderSizePixel = 0
RangeFill.Parent = RangeSlider

-- Elementos da aba de configurações
local AntiSlapToggle = Instance.new("TextButton")
AntiSlapToggle.Name = "AntiSlapToggle"
AntiSlapToggle.Size = UDim2.new(0.9, 0, 0, 40)
AntiSlapToggle.Position = UDim2.new(0.05, 0, 0, 10)
AntiSlapToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
AntiSlapToggle.BorderSizePixel = 0
AntiSlapToggle.Text = "ANTI SLAP: ATIVADO"
AntiSlapToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiSlapToggle.Font = Enum.Font.GothamBold
AntiSlapToggle.TextSize = 14
AntiSlapToggle.Parent = SettingsTab

local AntiBanToggle = Instance.new("TextButton")
AntiBanToggle.Name = "AntiBanToggle"
AntiBanToggle.Size = UDim2.new(0.9, 0, 0, 40)
AntiBanToggle.Position = UDim2.new(0.05, 0, 0, 60)
AntiBanToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
AntiBanToggle.BorderSizePixel = 0
AntiBanToggle.Text = "ANTI BAN: ATIVADO"
AntiBanToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiBanToggle.Font = Enum.Font.GothamBold
AntiBanToggle.TextSize = 14
AntiBanToggle.Parent = SettingsTab

local AntiKickToggle = Instance.new("TextButton")
AntiKickToggle.Name = "AntiKickToggle"
AntiKickToggle.Size = UDim2.new(0.9, 0, 0, 40)
AntiKickToggle.Position = UDim2.new(0.05, 0, 0, 110)
AntiKickToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
AntiKickToggle.BorderSizePixel = 0
AntiKickToggle.Text = "ANTI KICK: ATIVADO"
AntiKickToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiKickToggle.Font = Enum.Font.GothamBold
AntiKickToggle.TextSize = 14
AntiKickToggle.Parent = SettingsTab

-- Bola do Dragão (para reabrir a GUI)
local DragonBall = Instance.new("ImageButton")
DragonBall.Name = "DragonBall"
DragonBall.Size = UDim2.new(0, 50, 0, 50)
DragonBall.Position = UDim2.new(0, 20, 0.5, -25)
DragonBall.BackgroundTransparency = 1
DragonBall.Image = "rbxassetid://6756586445" -- Imagem de uma esfera amarela
DragonBall.Visible = false
DragonBall.Parent = ScreenGui

-- Função para arrastar a GUI
local function setupDrag(gui, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Configurar arrasto para o header
setupDrag(MainFrame, Header)

-- Funções de toggle
KillAuraToggle.MouseButton1Click:Connect(function()
    KillAura = not KillAura
    if KillAura then
        KillAuraToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        KillAuraToggle.Text = "KILL AURA: ATIVADO"
    else
        KillAuraToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        KillAuraToggle.Text = "KILL AURA: DESATIVADO"
    end
end)

AntiSlapToggle.MouseButton1Click:Connect(function()
    AntiSlap = not AntiSlap
    if AntiSlap then
        AntiSlapToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        AntiSlapToggle.Text = "ANTI SLAP: ATIVADO"
    else
        AntiSlapToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AntiSlapToggle.Text = "ANTI SLAP: DESATIVADO"
    end
end)

AntiBanToggle.MouseButton1Click:Connect(function()
    AntiBan = not AntiBan
    if AntiBan then
        AntiBanToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        AntiBanToggle.Text = "ANTI BAN: ATIVADO"
    else
        AntiBanToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AntiBanToggle.Text = "ANTI BAN: DESATIVADO"
    end
end)

AntiKickToggle.MouseButton1Click:Connect(function()
    AntiKick = not AntiKick
    if AntiKick then
        AntiKickToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        AntiKickToggle.Text = "ANTI KICK: ATIVADO"
    else
        AntiKickToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AntiKickToggle.Text = "ANTI KICK: DESATIVADO"
    end
end)

-- Trocar abas
CombatTabButton.MouseButton1Click:Connect(function()
    CombatTab.Visible = true
    SettingsTab.Visible = false
    CombatTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SettingsTabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

SettingsTabButton.MouseButton1Click:Connect(function()
    CombatTab.Visible = false
    SettingsTab.Visible = true
    CombatTabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SettingsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

-- Minimizar GUI
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    DragonBall.Visible = true
end)

-- Reabrir GUI com a bola do dragão
DragonBall.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    DragonBall.Visible = false
end)

-- Configurar slider de alcance
RangeSlider.MouseButton1Down:Connect(function()
    local connection
    connection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            local xPos = math.clamp(input.Position.X - RangeSlider.AbsolutePosition.X, 0, RangeSlider.AbsoluteSize.X)
            local ratio = xPos / RangeSlider.AbsoluteSize.X
            KillAuraRange = math.floor(5 + ratio * 25)
            RangeFill.Size = UDim2.new(ratio, 0, 1, 0)
            RangeLabel.Text = "ALCANCE: " .. tostring(KillAuraRange)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

-- Loop principal do Kill Aura
RunService.RenderStepped:Connect(function()
    KillAuraFunction()
end)

-- Ajustar para mobile
if UserInputService.TouchEnabled then
    MainFrame.Size = UDim2.new(0, 320, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
    DragonBall.Size = UDim2.new(0, 60, 0, 60)
end

print("Script Saber Showdown DBZ carregado com sucesso!")
