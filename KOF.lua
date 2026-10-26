--[[ KOF V2 | Ultra Premium | Heavy Spam Edition ]]

local Players           = game:GetService("Players")
local Player            = Players.LocalPlayer
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService   = game:GetService("TextChatService")

-- ================= SAFE PARENT (CoreGui → PlayerGui fallback) =================
local GUI_PARENT
pcall(function()
    local test = Instance.new("ScreenGui")
    test.Name = "_monk_test_"
    test.Parent = game:GetService("CoreGui")
    test:Destroy()
    GUI_PARENT = game:GetService("CoreGui")
end)
if not GUI_PARENT then
    GUI_PARENT = Player:WaitForChild("PlayerGui")
end
warn("[KOF V2] Using parent: " .. GUI_PARENT:GetFullName())

-- ================= CLEANUP =================
pcall(function()
    for _, n in ipairs({"MonkLoadingScreen","MonkMainGui","MonkTouchFx","ToxicChocoSpammer","AlphaDaddySpammer"}) do
        local o = GUI_PARENT:FindFirstChild(n)
        if o then o:Destroy() end
    end
end)

-- ================= TOUCH RIPPLE =================
pcall(function()
    local fxGui = Instance.new("ScreenGui")
    fxGui.Name = "MonkTouchFx"
    fxGui.IgnoreGuiInset = true
    fxGui.ResetOnSpawn = false
    fxGui.DisplayOrder = 2147483646
    fxGui.Parent = GUI_PARENT

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
           and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local x, y = input.Position.X, input.Position.Y
        local r = Instance.new("Frame")
        r.Size = UDim2.new(0, 16, 0, 16)
        r.Position = UDim2.new(0, x - 8, 0, y - 8)
        r.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
        r.BackgroundTransparency = 0.5
        r.BorderSizePixel = 0
        r.Parent = fxGui
        Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
        local s = Instance.new("UIStroke", r)
        s.Color = Color3.fromRGB(255, 255, 255); s.Thickness = 2; s.Transparency = 0.3
        TweenService:Create(r, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 130, 0, 130),
            Position = UDim2.new(0, x - 65, 0, y - 65),
            BackgroundTransparency = 1,
        }):Play()
        TweenService:Create(s, TweenInfo.new(0.6), {Transparency = 1}):Play()
        task.delay(0.65, function() if r.Parent then r:Destroy() end end)
    end)
end)

-- ================= INTRO CHAT =================
task.spawn(function()
    task.wait(1)
    local msg = "✌ KOF V2 LOADED ⚠️ (OWNER: KOF ✅)"
    local b = "(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)"
    local full = b .. "\n" .. msg .. "\n" .. b
    pcall(function()
        local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if ev and ev:FindFirstChild("SayMessageRequest") then
            ev.SayMessageRequest:FireServer(full, "All")
        else
            local tc = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if tc then tc:SendAsync(full) end
        end
    end)
end)

------------------------------------------------------------
-- LOADING SCREEN (simplified, faster)
------------------------------------------------------------
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "MonkLoadingScreen"
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false
loadingGui.DisplayOrder = 999999
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.Parent = GUI_PARENT

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

for _ = 1, 80 do
    local s = Instance.new("Frame")
    local sz = math.random(1, 3)
    s.Size = UDim2.new(0, sz, 0, sz)
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    s.BackgroundTransparency = math.random(30, 88) / 100
    s.BorderSizePixel = 0
    s.Parent = bg
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
end

local bhC = Instance.new("Frame")
bhC.Size = UDim2.new(0, 340, 0, 340)
bhC.Position = UDim2.new(0.5, 0, 0.5, 0)
bhC.AnchorPoint = Vector2.new(0.5, 0.5)
bhC.BackgroundTransparency = 1
bhC.Parent = bg

local glowImg = Instance.new("ImageLabel")
glowImg.Size = UDim2.new(0.8, 0, 0.8, 0)
glowImg.Position = UDim2.new(0.5, 0, 0.5, 0)
glowImg.AnchorPoint = Vector2.new(0.5, 0.5)
glowImg.BackgroundTransparency = 1
glowImg.Image = "rbxassetid://5028857084"
glowImg.ImageColor3 = Color3.fromRGB(150, 60, 255)
glowImg.ImageTransparency = 0.3
glowImg.Parent = bhC

local rings = {}
for i = 1, 5 do
    local ring = Instance.new("Frame")
    ring.Size = UDim2.new(0.5 + i * 0.13, 0, 0.5 + i * 0.13, 0)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.BackgroundTransparency = 1
    ring.Parent = bhC
    local stroke = Instance.new("UIStroke", ring)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(200 - i * 25, 80 + i * 15, 255 - i * 10)
    stroke.Transparency = 0.1 + i * 0.13
    Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
    table.insert(rings, {frame = ring, speed = 0.2 + i * 0.13, dir = (i % 2 == 0) and 1 or -1})
end

local eh = Instance.new("Frame")
eh.Size = UDim2.new(0.44, 0, 0.44, 0)
eh.Position = UDim2.new(0.5, 0, 0.5, 0)
eh.AnchorPoint = Vector2.new(0.5, 0.5)
eh.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
eh.BorderSizePixel = 0
eh.Parent = bhC
Instance.new("UICorner", eh).CornerRadius = UDim.new(1, 0)

local tC = Instance.new("Frame")
tC.Size = UDim2.new(0, 560, 0, 90)
tC.Position = UDim2.new(0.5, 0, 0.32, 0)
tC.AnchorPoint = Vector2.new(0.5, 0.5)
tC.BackgroundTransparency = 1
tC.Parent = bg

for off = 6, 1, -1 do
    local sh = Instance.new("TextLabel")
    sh.Size = UDim2.new(1, 0, 1, 0)
    sh.Position = UDim2.new(0, off, 0, off)
    sh.BackgroundTransparency = 1
    sh.Font = Enum.Font.GothamBlack
    sh.Text = "KOF V2"
    sh.TextColor3 = Color3.fromRGB(45, 15, 75)
    sh.TextSize = 58
    sh.Parent = tC
end
local mainT = Instance.new("TextLabel")
mainT.Size = UDim2.new(1, 0, 1, 0)
mainT.BackgroundTransparency = 1
mainT.Font = Enum.Font.GothamBlack
mainT.Text = "KOF V2"
mainT.TextColor3 = Color3.fromRGB(255, 255, 255)
mainT.TextSize = 58
mainT.Parent = tC

local mStroke = Instance.new("UIStroke", mainT)
mStroke.Color = Color3.fromRGB(190, 120, 255)
mStroke.Thickness = 2.5
mStroke.Transparency = 0.2

local function makeWing(parent, side)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, 130, 0, 80)
    holder.BackgroundTransparency = 1
    holder.Parent = parent
    holder.Position = (side == "left") and UDim2.new(0, -135, 0.5, -40) or UDim2.new(1, 5, 0.5, -40)
    for i = 1, 4 do
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, 65 - i * 7, 0, 8)
        f.Position = UDim2.new(0, 40, 0, 18 + i * 12)
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.Rotation = (side == "left") and (22 + i * 8) or (-22 - i * 8)
        f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        f.BackgroundTransparency = 0.25
        f.BorderSizePixel = 0
        f.Parent = holder
        Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
        local g = Instance.new("UIGradient", f)
        g.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 255)),
        }
    end
end
makeWing(tC, "left"); makeWing(tC, "right")

local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(0, 500, 0, 30)
subLbl.Position = UDim2.new(0.5, 0, 0.42, 0)
subLbl.AnchorPoint = Vector2.new(0.5, 0.5)
subLbl.BackgroundTransparency = 1
subLbl.Font = Enum.Font.GothamBold
subLbl.Text = "KOF  •  OWNER  •  VERIFIED ✅"
subLbl.TextColor3 = Color3.fromRGB(200, 170, 255)
subLbl.TextSize = 16
subLbl.Parent = bg

local loadLbl = Instance.new("TextLabel")
loadLbl.Size = UDim2.new(0, 400, 0, 30)
loadLbl.Position = UDim2.new(0.5, 0, 0.66, 0)
loadLbl.AnchorPoint = Vector2.new(0.5, 0.5)
loadLbl.BackgroundTransparency = 1
loadLbl.Font = Enum.Font.GothamBold
loadLbl.Text = "LOADING..."
loadLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
loadLbl.TextSize = 20
loadLbl.Parent = bg

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(0, 420, 0, 8)
pBg.Position = UDim2.new(0.5, 0, 0.73, 0)
pBg.AnchorPoint = Vector2.new(0.5, 0.5)
pBg.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
pBg.BorderSizePixel = 0
pBg.Parent = bg
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
pFill.BorderSizePixel = 0
pFill.Parent = pBg
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)
local pGrad = Instance.new("UIGradient", pFill)
pGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)),
}

local pct = Instance.new("TextLabel")
pct.Size = UDim2.new(0, 400, 0, 20)
pct.Position = UDim2.new(0.5, 0, 0.78, 0)
pct.AnchorPoint = Vector2.new(0.5, 0.5)
pct.BackgroundTransparency = 1
pct.Font = Enum.Font.Gotham
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(200, 180, 255)
pct.TextSize = 14
pct.Parent = bg

local spin, pulse = 0, 0
RunService.RenderStepped:Connect(function(dt)
    if not loadingGui.Parent then return end
    spin = spin + dt; pulse = pulse + dt * 2
    for _, r in ipairs(rings) do
        r.frame.Rotation = spin * r.speed * 60 * r.dir
    end
    bhC.Position = UDim2.new(0.5, math.sin(spin * 2) * 10, 0.5, math.cos(spin * 1.5) * 10)
    glowImg.ImageTransparency = 0.3 + math.sin(spin * 2) * 0.15
    mStroke.Transparency = 0.15 + math.sin(pulse) * 0.2
end)

local loadingDone = false
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.025)
        pFill.Size = UDim2.new(i / 100, 0, 1, 0)
        pct.Text = i .. "%"
    end
    loadLbl.Text = "KOF V2 LOADED ✔"
    task.wait(0.5)
    loadLbl.Text = "CLICK ANYWHERE TO CONTINUE"
    loadLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    TweenService:Create(loadLbl, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {TextTransparency = 0.5}):Play()
    loadingDone = true
end)

------------------------------------------------------------
-- AURA MERGE
------------------------------------------------------------
local function playAuraMerge(parent, onComplete)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 1, 0)
    c.BackgroundTransparency = 1
    c.ZIndex = 100
    c.Parent = parent

    local data = {
        {Color3.fromRGB(100, 200, 255), -0.15, -0.15},
        {Color3.fromRGB(255, 100, 200),  1.15, -0.15},
        {Color3.fromRGB(255, 215, 0),    1.15,  1.15},
        {Color3.fromRGB(180, 100, 255), -0.15,  1.15},
    }

    for _, d in ipairs(data) do
        task.spawn(function()
            local color, sx, sy = d[1], d[2], d[3]
            local orb = Instance.new("Frame")
            orb.Size = UDim2.new(0, 44, 0, 44)
            orb.Position = UDim2.new(sx, -22, sy, -22)
            orb.BackgroundColor3 = color
            orb.BorderSizePixel = 0
            orb.ZIndex = 101
            orb.Parent = c
            Instance.new("UICorner", orb).CornerRadius = UDim.new(1, 0)
            local glow = Instance.new("ImageLabel", orb)
            glow.Size = UDim2.new(3, 0, 3, 0)
            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
            glow.AnchorPoint = Vector2.new(0.5, 0.5)
            glow.BackgroundTransparency = 1
            glow.Image = "rbxassetid://5028857084"
            glow.ImageColor3 = color
            glow.ImageTransparency = 0.15

            local steps = 40
            for s = 0, steps do
                if not orb.Parent then return end
                local t = s / steps
                local ease = t < 0.5 and 2 * t * t or 1 - ((-2 * t + 2) ^ 2) / 2
                local ang = t * math.pi * 3
                local rad = (1 - ease) * 0.32
                local baseX = sx + (0.5 - sx) * ease
                local baseY = sy + (0.5 - sy) * ease
                orb.Position = UDim2.new(baseX + math.cos(ang) * rad, -22, baseY + math.sin(ang) * rad, -22)

                if s % 2 == 0 then
                    local trail = Instance.new("Frame", c)
                    trail.Size = UDim2.new(0, 22, 0, 22)
                    trail.Position = orb.Position + UDim2.new(0, 11, 0, 11)
                    trail.BackgroundColor3 = color
                    trail.BackgroundTransparency = 0.3
                    trail.BorderSizePixel = 0
                    trail.ZIndex = 99
                    Instance.new("UICorner", trail).CornerRadius = UDim.new(1, 0)
                    TweenService:Create(trail, TweenInfo.new(0.6), {
                        BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0),
                    }):Play()
                    task.delay(0.7, function() if trail.Parent then trail:Destroy() end end)
                end
                task.wait(0.028)
            end
            TweenService:Create(orb, TweenInfo.new(0.18), {
                Size = UDim2.new(0, 100, 0, 100),
                Position = UDim2.new(0.5, -50, 0.5, -50),
                BackgroundTransparency = 1,
            }):Play()
            task.delay(0.22, function() if orb.Parent then orb:Destroy() end end)
        end)
    end

    for i = 1, 3 do
        task.delay(0.9 + i * 0.15, function()
            local ring = Instance.new("Frame", c)
            ring.Size = UDim2.new(0, 20, 0, 20)
            ring.Position = UDim2.new(0.5, -10, 0.5, -10)
            ring.BackgroundTransparency = 1
            ring.ZIndex = 100
            Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
            local stroke = Instance.new("UIStroke", ring)
            local cols = {Color3.fromRGB(180,100,255), Color3.fromRGB(100,200,255), Color3.fromRGB(255,255,255)}
            stroke.Color = cols[i]
            stroke.Thickness = 5 - i
            stroke.Transparency = 0.1
            local maxSize = 700 + i * 200
            TweenService:Create(ring, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, maxSize, 0, maxSize),
                Position = UDim2.new(0.5, -maxSize / 2, 0.5, -maxSize / 2),
            }):Play()
            TweenService:Create(stroke, TweenInfo.new(1.1), {Transparency = 1}):Play()
            task.delay(1.2, function() if ring.Parent then ring:Destroy() end end)
        end)
    end

    task.delay(1.15, function()
        local flash = Instance.new("Frame", c)
        flash.Size = UDim2.new(0, 0, 0, 0)
        flash.Position = UDim2.new(0.5, 0, 0.5, 0)
        flash.AnchorPoint = Vector2.new(0.5, 0.5)
        flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        flash.BorderSizePixel = 0
        flash.ZIndex = 102
        Instance.new("UICorner", flash).CornerRadius = UDim.new(1, 0)
        TweenService:Create(flash, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(3, 0, 3, 0), BackgroundTransparency = 1,
        }):Play()
        task.delay(0.6, function() if flash.Parent then flash:Destroy() end end)
    end)

    task.delay(1.75, function()
        if c.Parent then c:Destroy() end
        if onComplete then onComplete() end
    end)
end

------------------------------------------------------------
-- MAIN GUI
------------------------------------------------------------
local function buildMainGui()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "MonkMainGui"
    mainGui.IgnoreGuiInset = true
    mainGui.ResetOnSpawn = false
    mainGui.DisplayOrder = 500
    mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainGui.Parent = GUI_PARENT

    local dim = Instance.new("Frame")
    dim.Size = UDim2.new(1, 0, 1, 0)
    dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dim.BackgroundTransparency = 1
    dim.BorderSizePixel = 0
    dim.Parent = mainGui
    TweenService:Create(dim, TweenInfo.new(0.4), {BackgroundTransparency = 0.55}):Play()

    -- WINDOW
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 0, 0, 0)
    window.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
    window.BackgroundTransparency = 0.05
    window.BorderSizePixel = 0
    window.ClipsDescendants = true
    window.Active = false
    window.Parent = mainGui
    Instance.new("UICorner", window).CornerRadius = UDim.new(0, 18)
    local wStroke = Instance.new("UIStroke", window)
    wStroke.Color = Color3.fromRGB(140, 80, 220)
    wStroke.Thickness = 2
    wStroke.Transparency = 0.2

    local wGrad = Instance.new("UIGradient", window)
    wGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 8, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 10, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 8, 22)),
    }
    wGrad.Rotation = 45

    -- DRAG LAYER (below all interactive elements)
    local dragLayer = Instance.new("Frame")
    dragLayer.Size = UDim2.new(1, 0, 1, 0)
    dragLayer.BackgroundTransparency = 1
    dragLayer.Active = true
    dragLayer.ZIndex = 2
    dragLayer.Parent = window

    -- BLACK HOLE
    local bhHolder = Instance.new("Frame")
    bhHolder.Size = UDim2.new(0, 280, 0, 280)
    bhHolder.Position = UDim2.new(0.75, -140, 0.6, -140)
    bhHolder.BackgroundTransparency = 1
    bhHolder.Active = false
    bhHolder.ZIndex = 3
    bhHolder.Parent = window

    local bhGlow = Instance.new("ImageLabel")
    bhGlow.Size = UDim2.new(2.2, 0, 2.2, 0)
    bhGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    bhGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    bhGlow.BackgroundTransparency = 1
    bhGlow.Image = "rbxassetid://5028857084"
    bhGlow.ImageColor3 = Color3.fromRGB(120, 50, 200)
    bhGlow.ImageTransparency = 0.5
    bhGlow.ZIndex = 3
    bhGlow.Parent = bhHolder

    local bhCore = Instance.new("Frame")
    bhCore.Size = UDim2.new(0.5, 0, 0.5, 0)
    bhCore.Position = UDim2.new(0.5, 0, 0.5, 0)
    bhCore.AnchorPoint = Vector2.new(0.5, 0.5)
    bhCore.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bhCore.BorderSizePixel = 0
    bhCore.Active = false
    bhCore.ZIndex = 4
    bhCore.Parent = bhHolder
    Instance.new("UICorner", bhCore).CornerRadius = UDim.new(1, 0)

    local diskHolder = Instance.new("Frame", bhHolder)
    diskHolder.Size = UDim2.new(1.3, 0, 1.3, 0)
    diskHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    diskHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    diskHolder.BackgroundTransparency = 1
    diskHolder.Active = false
    diskHolder.ZIndex = 3
    for i = 1, 3 do
        local d = Instance.new("Frame", diskHolder)
        d.Size = UDim2.new(0.55 + i * 0.14, 0, 0.55 + i * 0.14, 0)
        d.Position = UDim2.new(0.5, 0, 0.5, 0)
        d.AnchorPoint = Vector2.new(0.5, 0.5)
        d.BackgroundTransparency = 1
        d.Active = false
        d.ZIndex = 3
        Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
        local ds = Instance.new("UIStroke", d)
        ds.Color = Color3.fromRGB(160, 90 - i * 15, 240 - i * 20)
        ds.Thickness = 2 - i * 0.4
        ds.Transparency = 0.4 + i * 0.15
    end

    -- HEADER
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 82)
    header.BackgroundColor3 = Color3.fromRGB(22, 14, 40)
    header.BackgroundTransparency = 0.05
    header.BorderSizePixel = 0
    header.Active = false
    header.ZIndex = 10
    header.Parent = window
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 18)

    local hBH = Instance.new("Frame")
    hBH.Size = UDim2.new(0, 48, 0, 48)
    hBH.Position = UDim2.new(0, 14, 0.5, -24)
    hBH.BackgroundColor3 = Color3.fromRGB(5, 0, 15)
    hBH.BorderSizePixel = 0
    hBH.Active = false
    hBH.ZIndex = 12
    hBH.Parent = header
    Instance.new("UICorner", hBH).CornerRadius = UDim.new(1, 0)
    local hBHGlow = Instance.new("ImageLabel", hBH)
    hBHGlow.Size = UDim2.new(2.2, 0, 2.2, 0)
    hBHGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    hBHGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    hBHGlow.BackgroundTransparency = 1
    hBHGlow.Image = "rbxassetid://5028857084"
    hBHGlow.ImageColor3 = Color3.fromRGB(150, 60, 255)
    hBHGlow.ImageTransparency = 0.35

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -200, 0, 28)
    titleLbl.Position = UDim2.new(0, 72, 0, 10)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.Text = "KOF V2"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 24
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 12
    titleLbl.Parent = header
    local tSt = Instance.new("UIStroke", titleLbl)
    tSt.Color = Color3.fromRGB(200, 130, 255)
    tSt.Thickness = 1.5
    tSt.Transparency = 0.3

    local bRow = Instance.new("Frame")
    bRow.Size = UDim2.new(1, -200, 0, 22)
    bRow.Position = UDim2.new(0, 72, 0, 44)
    bRow.BackgroundTransparency = 1
    bRow.ZIndex = 12
    bRow.Parent = header
    local bLayout = Instance.new("UIListLayout", bRow)
    bLayout.FillDirection = Enum.FillDirection.Horizontal
    bLayout.Padding = UDim.new(0, 8)

    local function makeBadge(text, bgCol, fgCol, width)
        local b = Instance.new("Frame")
        b.Size = UDim2.new(0, width, 1, 0)
        b.BackgroundColor3 = bgCol
        b.BackgroundTransparency = 0.15
        b.BorderSizePixel = 0
        b.ZIndex = 12
        b.Parent = bRow
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
        local s = Instance.new("UIStroke", b)
        s.Color = fgCol; s.Thickness = 1; s.Transparency = 0.3
        local l = Instance.new("TextLabel", b)
        l.Size = UDim2.new(1, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Font = Enum.Font.GothamBold
        l.Text = text
        l.TextColor3 = fgCol
        l.TextSize = 11
        l.ZIndex = 13
    end
    makeBadge("👑 OWNER: KOF", Color3.fromRGB(60, 45, 10), Color3.fromRGB(255, 215, 0), 155)
    makeBadge("✅ VERIFIED", Color3.fromRGB(10, 40, 60), Color3.fromRGB(100, 220, 255), 100)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -44, 0, 12)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
    closeBtn.BackgroundTransparency = 0.15
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.BorderSizePixel = 0
    closeBtn.AutoButtonColor = false
    closeBtn.ZIndex = 14
    closeBtn.Parent = header
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 32, 0, 32)
    minBtn.Position = UDim2.new(1, -82, 0, 12)
    minBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
    minBtn.BackgroundTransparency = 0.2
    minBtn.Text = "−"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 20
    minBtn.BorderSizePixel = 0
    minBtn.AutoButtonColor = false
    minBtn.ZIndex = 14
    minBtn.Parent = header
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

    -- TABS
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -24, 0, 44)
    tabBar.Position = UDim2.new(0, 12, 0, 92)
    tabBar.BackgroundColor3 = Color3.fromRGB(20, 12, 36)
    tabBar.BackgroundTransparency = 0.1
    tabBar.BorderSizePixel = 0
    tabBar.Active = false
    tabBar.ZIndex = 10
    tabBar.Parent = window
    Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 10)
    local tabLayout = Instance.new("UIListLayout", tabBar)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -24, 1, -152)
    content.Position = UDim2.new(0, 12, 0, 144)
    content.BackgroundColor3 = Color3.fromRGB(18, 10, 32)
    content.BackgroundTransparency = 0.1
    content.BorderSizePixel = 0
    content.Active = false
    content.ZIndex = 10
    content.Parent = window
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)

    -- PAGES
    local pages, tabs = {}, {}

    local function makePage(name)
        local p = Instance.new("ScrollingFrame")
        p.Size = UDim2.new(1, -20, 1, -20)
        p.Position = UDim2.new(0, 10, 0, 10)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.ScrollBarThickness = 4
        p.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 220)
        p.CanvasSize = UDim2.new(0, 0, 0, 0)
        p.Active = false
        p.ZIndex = 11
        p.Visible = false
        p.Parent = content
        local list = Instance.new("UIListLayout", p)
        list.Padding = UDim.new(0, 8)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            p.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
        end)
        pages[name] = p
        return p
    end

    local function switchTab(name)
        for n, p in pairs(pages) do
            if n == name then
                p.Visible = true
                p.GroupTransparency = 1
                TweenService:Create(p, TweenInfo.new(0.25), {GroupTransparency = 0}):Play()
            else
                p.Visible = false
            end
        end
        for n, b in pairs(tabs) do
            if n == name then
                TweenService:Create(b, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(120, 70, 200),
                    BackgroundTransparency = 0.1
                }):Play()
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                TweenService:Create(b, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(35, 20, 55),
                    BackgroundTransparency = 0.2
                }):Play()
                b.TextColor3 = Color3.fromRGB(180, 170, 210)
            end
        end
    end

    local function addTab(name, label)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 120, 0, 34)
        b.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
        b.BackgroundTransparency = 0.2
        b.Text = label or name
        b.Font = Enum.Font.GothamBold
        b.TextColor3 = Color3.fromRGB(180, 170, 210)
        b.TextSize = 13
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 11
        b.Parent = tabBar
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        tabs[name] = b
        makePage(name)
        b.MouseButton1Click:Connect(function() switchTab(name) end)
    end

    addTab("main", "MAIN")
    addTab("targets", "TARGETS")
    addTab("info", "INFO")

    local function makeCard(parent, height)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -4, 0, height)
        card.BackgroundColor3 = Color3.fromRGB(28, 18, 48)
        card.BackgroundTransparency = 0.1
        card.BorderSizePixel = 0
        card.Active = false
        card.ZIndex = 11
        card.Parent = parent
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        local st = Instance.new("UIStroke", card)
        st.Color = Color3.fromRGB(90, 60, 140); st.Thickness = 1; st.Transparency = 0.5
        return card
    end

    -- MAIN PAGE
    local mainPage = pages["main"]

    local msgCard = makeCard(mainPage, 72)
    local msgLbl = Instance.new("TextLabel", msgCard)
    msgLbl.Size = UDim2.new(1, -20, 0, 20)
    msgLbl.Position = UDim2.new(0, 10, 0, 8)
    msgLbl.BackgroundTransparency = 1
    msgLbl.Font = Enum.Font.GothamBold
    msgLbl.Text = "CUSTOM MESSAGE PREFIX"
    msgLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    msgLbl.TextSize = 11
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.ZIndex = 12

    local msgBox = Instance.new("TextBox")
    msgBox.Size = UDim2.new(1, -20, 0, 32)
    msgBox.Position = UDim2.new(0, 10, 0, 32)
    msgBox.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
    msgBox.BorderSizePixel = 0
    msgBox.Font = Enum.Font.Gotham
    msgBox.Text = ""
    msgBox.PlaceholderText = "Type prefix..."
    msgBox.PlaceholderColor3 = Color3.fromRGB(100, 90, 130)
    msgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgBox.TextSize = 13
    msgBox.TextXAlignment = Enum.TextXAlignment.Left
    msgBox.ClearTextOnFocus = false
    msgBox.ZIndex = 12
    msgBox.Parent = msgCard
    Instance.new("UICorner", msgBox).CornerRadius = UDim.new(0, 6)
    local msgPad = Instance.new("UIPadding", msgBox)
    msgPad.PaddingLeft = UDim.new(0, 8)

    local sliderCard = makeCard(mainPage, 72)
    local sliderLbl = Instance.new("TextLabel", sliderCard)
    sliderLbl.Size = UDim2.new(1, -20, 0, 20)
    sliderLbl.Position = UDim2.new(0, 10, 0, 8)
    sliderLbl.BackgroundTransparency = 1
    sliderLbl.Font = Enum.Font.GothamBold
    sliderLbl.Text = "DELAY: 2.4s"
    sliderLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    sliderLbl.TextSize = 11
    sliderLbl.TextXAlignment = Enum.TextXAlignment.Left
    sliderLbl.ZIndex = 12

    local sliderTrack = Instance.new("Frame", sliderCard)
    sliderTrack.Size = UDim2.new(1, -30, 0, 8)
    sliderTrack.Position = UDim2.new(0, 15, 0, 48)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Active = true
    sliderTrack.ZIndex = 12
    Instance.new("UICorner", sliderTrack).CornerRadius = UDim.new(1, 0)

    local sliderFill = Instance.new("Frame", sliderTrack)
    sliderFill.Size = UDim2.new(0.24, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(160, 90, 240)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 12
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
    local sFillGrad = Instance.new("UIGradient", sliderFill)
    sFillGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)),
    }

    local sliderKnob = Instance.new("Frame", sliderTrack)
    sliderKnob.Size = UDim2.new(0, 18, 0, 18)
    sliderKnob.Position = UDim2.new(0.24, -9, 0.5, -9)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.ZIndex = 13
    Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)
    local kStroke = Instance.new("UIStroke", sliderKnob)
    kStroke.Color = Color3.fromRGB(160, 90, 240); kStroke.Thickness = 2

    local delayValue = 2.4
    local sliderDragging = false
    local function updateSlider(relX)
        local p = math.clamp(relX / sliderTrack.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(p, 0, 1, 0)
        sliderKnob.Position = UDim2.new(p, -9, 0.5, -9)
        delayValue = 0.1 + 9.9 * p
        sliderLbl.Text = string.format("DELAY: %.1fs", delayValue)
    end
    sliderTrack.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            sliderDragging = true
            updateSlider(i.Position.X - sliderTrack.AbsolutePosition.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if sliderDragging and (i.UserInputType == Enum.UserInputType.MouseMovement
           or i.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(i.Position.X - sliderTrack.AbsolutePosition.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            sliderDragging = false
        end
    end)

    local burstCard = makeCard(mainPage, 58)
    local burstLbl = Instance.new("TextLabel", burstCard)
    burstLbl.Size = UDim2.new(1, -90, 1, 0)
    burstLbl.Position = UDim2.new(0, 14, 0, 0)
    burstLbl.BackgroundTransparency = 1
    burstLbl.Font = Enum.Font.GothamBold
    burstLbl.Text = "BURST MODE (FAST)"
    burstLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    burstLbl.TextSize = 12
    burstLbl.TextXAlignment = Enum.TextXAlignment.Left
    burstLbl.ZIndex = 12

    local burstOn = false
    local burstToggle = Instance.new("Frame", burstCard)
    burstToggle.Size = UDim2.new(0, 52, 0, 26)
    burstToggle.Position = UDim2.new(1, -66, 0.5, -13)
    burstToggle.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
    burstToggle.BorderSizePixel = 0
    burstToggle.Active = true
    burstToggle.ZIndex = 12
    Instance.new("UICorner", burstToggle).CornerRadius = UDim.new(1, 0)
    local burstKnob = Instance.new("Frame", burstToggle)
    burstKnob.Size = UDim2.new(0, 20, 0, 20)
    burstKnob.Position = UDim2.new(0, 3, 0.5, -10)
    burstKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    burstKnob.BorderSizePixel = 0
    burstKnob.ZIndex = 13
    Instance.new("UICorner", burstKnob).CornerRadius = UDim.new(1, 0)

    burstToggle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            burstOn = not burstOn
            TweenService:Create(burstToggle, TweenInfo.new(0.25), {
                BackgroundColor3 = burstOn and Color3.fromRGB(160, 90, 240) or Color3.fromRGB(60, 40, 90)
            }):Play()
            TweenService:Create(burstKnob, TweenInfo.new(0.25), {
                Position = burstOn and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
            }):Play()
        end
    end)

    local statusCard = makeCard(mainPage, 46)
    local statusDot = Instance.new("Frame", statusCard)
    statusDot.Size = UDim2.new(0, 10, 0, 10)
    statusDot.Position = UDim2.new(0, 14, 0.5, -5)
    statusDot.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 12
    Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

    local statusLbl = Instance.new("TextLabel", statusCard)
    statusLbl.Size = UDim2.new(1, -100, 1, 0)
    statusLbl.Position = UDim2.new(0, 32, 0, 0)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = "STOPPED"
    statusLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
    statusLbl.TextSize = 12
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.ZIndex = 12

    local sentLbl = Instance.new("TextLabel", statusCard)
    sentLbl.Size = UDim2.new(0, 90, 1, 0)
    sentLbl.Position = UDim2.new(1, -100, 0, 0)
    sentLbl.BackgroundTransparency = 1
    sentLbl.Font = Enum.Font.GothamBold
    sentLbl.Text = "SENT: 0"
    sentLbl.TextColor3 = Color3.fromRGB(160, 120, 230)
    sentLbl.TextSize = 12
    sentLbl.TextXAlignment = Enum.TextXAlignment.Right
    sentLbl.ZIndex = 12

    local sentCount = 0
    local isSpamming = false

    local function setStatus(text, color)
        statusLbl.Text = text
        statusLbl.TextColor3 = color
        statusDot.BackgroundColor3 = color
    end

    local startBtn = Instance.new("TextButton")
    startBtn.Size = UDim2.new(1, -4, 0, 54)
    startBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
    startBtn.BackgroundTransparency = 0
    startBtn.Text = "▶ START SPAM"
    startBtn.Font = Enum.Font.GothamBlack
    startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    startBtn.TextSize = 16
    startBtn.BorderSizePixel = 0
    startBtn.AutoButtonColor = false
    startBtn.ZIndex = 11
    startBtn.Parent = mainPage
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 12)
    local sBtnGrad = Instance.new("UIGradient", startBtn)
    sBtnGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 240)),
    }
    sBtnGrad.Rotation = 30

    -- TARGETS PAGE
    local targetPage = pages["targets"]
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(1, -4, 0, 38)
    clearBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 50)
    clearBtn.BackgroundTransparency = 0.15
    clearBtn.Text = "🗑  CLEAR ALL TARGETS"
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.TextColor3 = Color3.fromRGB(255, 180, 180)
    clearBtn.TextSize = 12
    clearBtn.BorderSizePixel = 0
    clearBtn.AutoButtonColor = false
    clearBtn.ZIndex = 11
    clearBtn.Parent = targetPage
    Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 10)

    local targetBoxes = {}
    for i = 1, 10 do
        local tCard = makeCard(targetPage, 42)
        local numL = Instance.new("TextLabel", tCard)
        numL.Size = UDim2.new(0, 32, 1, 0)
        numL.BackgroundTransparency = 1
        numL.Font = Enum.Font.GothamBlack
        numL.Text = "#" .. i
        numL.TextColor3 = Color3.fromRGB(160, 120, 230)
        numL.TextSize = 12
        numL.ZIndex = 12

        local tb = Instance.new("TextBox", tCard)
        tb.Size = UDim2.new(1, -44, 0, 28)
        tb.Position = UDim2.new(0, 38, 0.5, -14)
        tb.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
        tb.BorderSizePixel = 0
        tb.Font = Enum.Font.Gotham
        tb.Text = ""
        tb.PlaceholderText = "Enter target username..."
        tb.PlaceholderColor3 = Color3.fromRGB(100, 90, 130)
        tb.TextColor3 = Color3.fromRGB(255, 255, 255)
        tb.TextSize = 12
        tb.TextXAlignment = Enum.TextXAlignment.Left
        tb.ClearTextOnFocus = false
        tb.ZIndex = 12
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
        local pad = Instance.new("UIPadding", tb)
        pad.PaddingLeft = UDim.new(0, 8)

        table.insert(targetBoxes, tb)
    end

    clearBtn.MouseButton1Click:Connect(function()
        for _, tb in ipairs(targetBoxes) do tb.Text = "" end
        clearBtn.Text = "✅  CLEARED!"
        task.delay(1.2, function() if clearBtn.Parent then clearBtn.Text = "🗑  CLEAR ALL TARGETS" end end)
    end)

    -- INFO PAGE
    local infoPage = pages["info"]
    local infoCard = makeCard(infoPage, 280)
    local infoTxt = Instance.new("TextLabel", infoCard)
    infoTxt.Size = UDim2.new(1, -20, 1, -20)
    infoTxt.Position = UDim2.new(0, 10, 0, 10)
    infoTxt.BackgroundTransparency = 1
    infoTxt.Font = Enum.Font.Gotham
    infoTxt.Text = "KOF V2 | HEAVY SPAM EDITION\n\n👑 OWNER: KOF\n✅ VERIFIED BUILD\n\n• Drag from ANYWHERE\n• Press K to toggle GUI\n• Burst = 12 msgs then 3s rest\n• Every message = KOF V2 branding\n\nMade with ❤️ by KOF"
    infoTxt.TextColor3 = Color3.fromRGB(200, 180, 255)
    infoTxt.TextSize = 13
    infoTxt.TextWrapped = true
    infoTxt.TextYAlignment = Enum.TextYAlignment.Top
    infoTxt.TextXAlignment = Enum.TextXAlignment.Left
    infoTxt.ZIndex = 12

    -- SPAM LOGIC (KOF V2 heavy)
    local sentBurst = 0
    local tIdx = 1

    local patterns = {
        "(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)",
        "o_O|o_O|o_O|o_O|o_O|o_O|o_O|o_O|",
        "- _ - _ - _ - _ - _ - _ - _ - _ - _ - _",
        "______________________________________",
        "--------------------------------------",
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
    }

    -- KOF V2 branded messages (heavy spam)
    local messages = {
        "🔥 KOF V2 ON TOP 🔥 KOF V2 ON TOP 🔥 KOF V2 ON TOP 🔥",
        "⚡ KOF V2 GOD MODE ACTIVATED ⚡ KOF V2 GOD MODE ⚡",
        "👑 KOF V2 IS UNSTOPPABLE 👑 KOF V2 IS UNSTOPPABLE 👑",
        "🚀 KOF V2 LOADED SUCCESSFULLY 🚀 KOF V2 ⚡",
        "💀 KOF V2 OWNS THE SERVER 💀 KOF V2 OWNS 💀",
        "🌟 KOF V2 BEST SPAMMER 🌟 KOF V2 BEST 🌟",
        "⚔️ KOF V2 SUPREMACY ⚔️ KOF V2 SUPREMACY ⚔️",
        "✨ KOF V2 VERIFIED OWNER ✨ KOF V2 ✨",
        "💎 KOF V2 PREMIUM EDITION 💎 KOF V2 PREMIUM 💎",
        "🔥 KOF V2 DESTROYING EVERYONE 🔥 KOF V2 🔥",
        "⚡ KOF V2 SPEED MODE ⚡ KOF V2 FAST ⚡",
        "👑 KOF IS THE KING 👑 KOF IS THE KING 👑",
        "🚀 KOF V2 TAKEOVER 🚀 KOF V2 TAKEOVER 🚀",
        "💀 KOF V2 BEAST MODE 💀 KOF V2 BEAST 💀",
        "🌟 KOF V2 PREMIUM SPAMMER 🌟 KOF V2 🌟",
        "⚔️ KOF V2 UNBEATABLE ⚔️ KOF V2 ⚔️",
        "✨ KOF V2 BEST SCRIPT ✨ KOF V2 BEST ✨",
        "💎 KOF V2 EXCLUSIVE 💎 KOF V2 💎",
        "🔥 KOF V2 FIRE MODE 🔥 KOF V2 FIRE 🔥",
        "⚡ KOF V2 LIGHTNING FAST ⚡ KOF V2 ⚡",
        "👑 KOF V2 ROYALTY 👑 KOF V2 ROYALTY 👑",
        "🚀 KOF V2 FLYING HIGH 🚀 KOF V2 🚀",
        "💀 KOF V2 SKULL CRUSHER 💀 KOF V2 💀",
        "🌟 KOF V2 SHINING STAR 🌟 KOF V2 🌟",
        "⚔️ KOF V2 WARRIOR ⚔️ KOF V2 WARRIOR ⚔️",
        "✨ KOF V2 MAGICAL ✨ KOF V2 MAGICAL ✨",
        "💎 KOF V2 DIAMOND 💎 KOF V2 DIAMOND 💎",
        "🔥 KOF V2 INFERNO 🔥 KOF V2 INFERNO 🔥",
        "⚡ KOF V2 THUNDER ⚡ KOF V2 THUNDER ⚡",
        "👑 KOF V2 LEGEND 👑 KOF V2 LEGEND 👑",
        "🚀 KOF V2 ROCKET 🚀 KOF V2 ROCKET 🚀",
        "💀 KOF V2 DEATH MODE 💀 KOF V2 DEATH 💀",
        "🌟 KOF V2 GALAXY 🌟 KOF V2 GALAXY 🌟",
        "⚔️ KOF V2 BATTLE READY ⚔️ KOF V2 ⚔️",
        "✨ KOF V2 SPARKLE ✨ KOF V2 SPARKLE ✨",
    }

    startBtn.MouseButton1Click:Connect(function()
        isSpamming = not isSpamming
        if isSpamming then
            sentCount, sentBurst = 0, 0
            sentLbl.Text = "SENT: 0"
            setStatus("RUNNING", Color3.fromRGB(74, 222, 128))
            startBtn.Text = "⏹ STOP SPAM"
            TweenService:Create(sBtnGrad, TweenInfo.new(0.25), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 80)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 100)),
                }
            }):Play()
        else
            setStatus("STOPPED", Color3.fromRGB(239, 68, 68))
            startBtn.Text = "▶ START SPAM"
            TweenService:Create(sBtnGrad, TweenInfo.new(0.25), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 240)),
                }
            }):Play()
        end
    end)

    task.spawn(function()
        while mainGui.Parent do
            if isSpamming then
                local customMsg = msgBox.Text or ""
                local customDelay = delayValue
                local tList = {}
                for _, box in ipairs(targetBoxes) do
                    local txt = string.match(box.Text or "", "^%s*(.-)%s*$")
                    if txt ~= "" then table.insert(tList, txt) end
                end
                local groups = {}
                for i = 1, #tList, 2 do
                    if tList[i + 1] then
                        table.insert(groups, "[" .. tList[i] .. "], [" .. tList[i + 1] .. "]")
                    else
                        table.insert(groups, "[" .. tList[i] .. "]")
                    end
                end
                for _, msg in ipairs(messages) do
                    if not isSpamming or not mainGui.Parent then break end
                    local target = ""
                    if #groups > 0 then
                        if tIdx > #groups then tIdx = 1 end
                        target = groups[tIdx]; tIdx = tIdx + 1
                    end
                    local pat = patterns[math.random(1, #patterns)]
                    local core = customMsg ~= "" and (customMsg .. " " .. msg) or msg
                    if target ~= "" then core = target .. " " .. core end
                    local final = pat .. "\n" .. core .. "\n" .. pat
                    if #final > 195 then
                        local allow = math.floor((190 - #core) / 2)
                        if allow > 2 then
                            local short = string.sub(pat, 1, allow)
                            final = short .. "\n" .. core .. "\n" .. short
                        else
                            final = string.sub(core, 1, 190)
                        end
                    end
                    pcall(function()
                        local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                        local tc = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                        if ev and ev:FindFirstChild("SayMessageRequest") then
                            ev.SayMessageRequest:FireServer(final, "All")
                        elseif tc then
                            tc:SendAsync(final)
                        end
                    end)
                    sentCount = sentCount + 1
                    sentLbl.Text = "SENT: " .. sentCount
                    if burstOn then
                        sentBurst = sentBurst + 1
                        if sentBurst >= 12 then
                            setStatus("COOLDOWN ⏳", Color3.fromRGB(250, 204, 21))
                            task.wait(3); sentBurst = 0
                            if isSpamming then setStatus("RUNNING (BURST)", Color3.fromRGB(74, 222, 128)) end
                        else
                            task.wait(customDelay)
                        end
                    else
                        task.wait(customDelay)
                    end
                end
            else
                task.wait(0.5)
            end
        end
    end)

    -- FULL DRAG
    local dragStart, startPos, isDragging = nil, nil, false
    dragLayer.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = i.Position
            startPos = window.Position
            TweenService:Create(wStroke, TweenInfo.new(0.15), {
                Color = Color3.fromRGB(200, 130, 255),
                Thickness = 2.5,
                Transparency = 0,
            }):Play()
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if isDragging and dragStart and (i.UserInputType == Enum.UserInputType.MouseMovement
           or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            if isDragging then
                TweenService:Create(wStroke, TweenInfo.new(0.2), {
                    Color = Color3.fromRGB(140, 80, 220),
                    Thickness = 2,
                    Transparency = 0.2,
                }):Play()
            end
            isDragging = false
            dragStart = nil
        end
    end)

    -- MINIMIZE
    local minimized = false
    local savedSize = UDim2.new(0, 600, 0, 520)
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            savedSize = window.Size
            TweenService:Create(window, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 600, 0, 82)
            }):Play()
            minBtn.Text = "□"
        else
            TweenService:Create(window, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = savedSize
            }):Play()
            minBtn.Text = "−"
        end
    end)

    -- CLOSE
    closeBtn.MouseButton1Click:Connect(function()
        isSpamming = false
        TweenService:Create(window, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        }):Play()
        TweenService:Create(dim, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.32)
        mainGui:Destroy()
    end)

    -- ANIMATION LOOP
    local bhT, diskT = 0, 0
    RunService.RenderStepped:Connect(function(dt)
        if not mainGui.Parent then return end
        bhT = bhT + dt; diskT = diskT + dt
        bhHolder.Position = UDim2.new(0.75, -140 + math.sin(bhT * 0.7) * 22, 0.6, -140 + math.cos(bhT * 0.55) * 22)
        bhGlow.ImageTransparency = 0.5 + math.sin(bhT * 1.8) * 0.1
        diskHolder.Rotation = diskT * 25
        hBH.Position = UDim2.new(0, 14, 0.5, -24 + math.sin(bhT * 2.8) * 2)
        hBHGlow.ImageTransparency = 0.3 + math.sin(bhT * 3) * 0.15
        tSt.Transparency = 0.2 + math.sin(bhT * 3.5) * 0.15
        if not isDragging then
            wStroke.Transparency = 0.15 + math.sin(bhT * 2) * 0.15
        end
        wGrad.Rotation = 45 + bhT * 8
        if isSpamming then
            statusDot.Size = UDim2.new(0, 10 + math.sin(bhT * 8) * 3, 0, 10 + math.sin(bhT * 8) * 3)
            statusDot.Position = UDim2.new(0, 14 - math.sin(bhT * 8) * 1.5, 0.5, -5 - math.sin(bhT * 8) * 1.5)
        end
    end)

    -- K TOGGLE
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.K and mainGui.Parent then
            window.Visible = not window.Visible
            dim.Visible = window.Visible
        end
    end)

    -- ENTRANCE
    switchTab("main")
    TweenService:Create(window, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 520),
        Position = UDim2.new(0.5, -300, 0.5, -260),
    }):Play()
end

------------------------------------------------------------
-- CLICK → AURA → OPEN GUI
------------------------------------------------------------
local clicked = false
local clickConn
clickConn = UserInputService.InputBegan:Connect(function(input)
    if clicked or not loadingDone then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
       and input.UserInputType ~= Enum.UserInputType.Touch then return end
    clicked = true
    if clickConn then clickConn:Disconnect() end

    playAuraMerge(loadingGui, function()
        for _, d in ipairs(bg:GetDescendants()) do
            pcall(function()
                if d:IsA("TextLabel") then
                    TweenService:Create(d, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
                elseif d:IsA("ImageLabel") then
                    TweenService:Create(d, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
                elseif d:IsA("Frame") and d.BackgroundTransparency < 1 then
                    TweenService:Create(d, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                elseif d:IsA("UIStroke") then
                    TweenService:Create(d, TweenInfo.new(0.5), {Transparency = 1}):Play()
                end
            end)
        end
        task.delay(0.55, function()
            if loadingGui.Parent then loadingGui:Destroy() end
            local ok, err = pcall(buildMainGui)
            if not ok then
                warn("[KOF V2] GUI build error: " .. tostring(err))
            end
        end)
    end)
end)

warn("[KOF V2] Script initialized. Waiting for loading screen...")