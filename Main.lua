local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

-- 1. Hoofdframe
local main = Instance.new("Frame")
main.Name = "XenoGhost"
main.Size = UDim2.new(0, 450, 0, 300)
main.Position = UDim2.new(0.5, -225, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = script.Parent -- Zorg dat dit in een ScreenGui staat!

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 1.5

-- 2. Zijbalk
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
sidebar.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", sidebar)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- 3. Pagina Systeem
local pages = {}
local currentPage = nil

local function createPage(name)
    local p = Instance.new("ScrollingFrame", main)
    p.Name = name.."Page"
    p.Size = UDim2.new(1, -130, 1, -10)
    p.Position = UDim2.new(0, 125, 0, 5)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 2
    
    local pLayout = Instance.new("UIListLayout", p)
    pLayout.Padding = UDim.new(0, 8)
    
    pages[name] = p
    return p
end

-- Maak de pagina's aan
local combatPage = createPage("COMBAT")
local visualsPage = createPage("VISUALS")
local movementPage = createPage("MOVEMENT")

-- 4. Functie voor knoppen op de pagina's
local function addButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.95, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.MouseButton1Click:Connect(callback)
end

-- 5. Tabs koppelen
local function addTab(name)
    local tabBtn = Instance.new("TextButton", sidebar)
    tabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    tabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.GothamBold
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        pages[name].Visible = true
    end)
end

addTab("COMBAT")
addTab("VISUALS")
addTab("MOVEMENT")

-- VOEG HIER JE FUNCTIES TOE
addButton(movementPage, "Ghost Mode (Semi-Invis)", function()
    print("Ghost Mode geactiveerd!")
    -- Hier komt de code die we eerder hebben gemaakt
end)

addButton(visualsPage, "ESP Highlights", function()
    print("ESP laden...")
end)

-- 6. Dragging (Houdt je oude code hieronder)
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
