--[[ KOF HEAVY SPAM | Mobile/Executor Build ]]

print("[KOF] === SCRIPT START ===")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera

local _wait = (task and task.wait) or wait
local _spawn = (task and task.spawn) or spawn
local _delay = (task and task.delay) or delay

-- ============ SAFE PLAYERGUI ============
local PlayerGui
pcall(function()
    PlayerGui = Player:FindFirstChild("PlayerGui") or Player:WaitForChild("PlayerGui", 15)
end)
if not PlayerGui then
    PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
end
if not PlayerGui then
    warn("[KOF] ❌ No PlayerGui")
    return
end
print("[KOF] PlayerGui OK")

-- ============ CLEANUP ============
for _, n in ipairs({"ARHHANLoading","ARHHANGui","KOFLoading","KOFGui","ARHHANError"}) do
    pcall(function()
        local o = PlayerGui:FindFirstChild(n)
        if o then o:Destroy() end
    end)
end

-- ============ STATE ============
local mainGuiRef = nil
local isSpammingRef = false
local sentCountRef = 0

-- ============ HEAVY KOF SPAM MESSAGES ============
local kofPatterns = {
    "(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)",
    "o_O|o_O|o_O|o_O|o_O|o_O|o_O|o_O|",
    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
    "______________________________________",
    "--------------------------------------",
    "☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆",
}

local kofMessages = {
    "🔥 KOF ON TOP 🔥 KOF ON TOP 🔥 KOF ON TOP 🔥",
    "⚡ KOF GOD MODE ⚡ KOF GOD MODE ⚡ KOF ⚡",
    "👑 KOF UNSTOPPABLE 👑 KOF UNSTOPPABLE 👑",
    "🚀 KOF TAKEOVER 🚀 KOF TAKEOVER 🚀 KOF 🚀",
    "💀 KOF OWNS SERVER 💀 KOF OWNS SERVER 💀",
    "🌟 KOF BEST SPAMMER 🌟 KOF BEST SPAMMER 🌟",
    "⚔️ KOF SUPREMACY ⚔️ KOF SUPREMACY ⚔️ KOF ⚔️",
    "✨ KOF VERIFIED ✨ KOF VERIFIED ✨ KOF ✨",
    "💎 KOF PREMIUM 💎 KOF PREMIUM 💎 KOF 💎",
    "🔥 KOF FIRE MODE 🔥 KOF FIRE MODE 🔥 KOF 🔥",
    "⚡ KOF LIGHTNING ⚡ KOF LIGHTNING ⚡ KOF ⚡",
    "👑 KOF IS KING 👑 KOF IS KING 👑 KOF 👑",
    "🚀 KOF HIGH SPEED 🚀 KOF HIGH SPEED 🚀",
    "💀 KOF BEAST MODE 💀 KOF BEAST MODE 💀",
    "🌟 KOF SHINING 🌟 KOF SHINING 🌟 KOF 🌟",
    "⚔️ KOF WARRIOR ⚔️ KOF WARRIOR ⚔️ KOF ⚔️",
    "✨ KOF MAGIC ✨ KOF MAGIC ✨ KOF ✨",
    "💎 KOF DIAMOND 💎 KOF DIAMOND 💎 KOF 💎",
    "🔥 KOF INFERNO 🔥 KOF INFERNO 🔥 KOF 🔥",
    "⚡ KOF THUNDER ⚡ KOF THUNDER ⚡ KOF ⚡",
    "👑 KOF LEGEND 👑 KOF LEGEND 👑 KOF 👑",
    "🚀 KOF ROCKET 🚀 KOF ROCKET 🚀 KOF 🚀",
    "💀 KOF DEATH MODE 💀 KOF DEATH MODE 💀",
    "🌟 KOF GALAXY 🌟 KOF GALAXY 🌟 KOF 🌟",
    "⚔️ KOF BATTLE ⚔️ KOF BATTLE ⚔️ KOF ⚔️",
    "✨ KOF SPARKLE ✨ KOF SPARKLE ✨ KOF ✨",
    "💎 KOF ROYAL 💎 KOF ROYAL 💎 KOF 💎",
    "🔥 KOF BLAZE 🔥 KOF BLAZE 🔥 KOF 🔥",
    "⚡ KOF STORM ⚡ KOF STORM ⚡ KOF ⚡",
    "👑 KOF EMPEROR 👑 KOF EMPEROR 👑 KOF 👑",
    "KOF KOF KOF KOF KOF KOF KOF KOF KOF KOF",
    "KOF IS UNBEATABLE KOF IS UNBEATABLE KOF",
    "🔥🔥🔥 KOF 🔥🔥🔥 KOF 🔥🔥🔥 KOF 🔥🔥🔥",
    "⚡⚡⚡ KOF ⚡⚡⚡ KOF ⚡⚡⚡ KOF ⚡⚡⚡",
    "KOF THE BEST KOF THE BEST KOF THE BEST KOF",
    "KOF KING KOF KING KOF KING KOF KING KOF",
}

-- ============ BUILD MAIN GUI ============
local function buildMainGui()
    print("[KOF] buildMainGui() called")
    
    local ok, err = pcall(function()
        local vp = Camera.ViewportSize
        print("[KOF] Viewport: " .. vp.X .. "x" .. vp.Y)
        
        local wW = math.min(560, math.floor(vp.X * 0.92))
        local wH = math.min(560, math.floor(vp.Y * 0.85))
        if wW < 280 then wW = vp.X end
        if wH < 380 then wH = vp.Y end
        
        local mainGui = Instance.new("ScreenGui")
        mainGui.Name = "KOFGui"
        mainGui.IgnoreGuiInset = true
        mainGui.ResetOnSpawn = false
        mainGui.DisplayOrder = 500
        mainGui.Parent = PlayerGui
        mainGuiRef = mainGui
        
        local dim = Instance.new("Frame")
        dim.Size = UDim2.new(1, 0, 1, 0)
        dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        dim.BackgroundTransparency = 0.5
        dim.BorderSizePixel = 0
        dim.Parent = mainGui
        
        local window = Instance.new("Frame")
        window.Size = UDim2.new(0, wW, 0, wH)
        window.Position = UDim2.new(0.5, -math.floor(wW/2), 0.5, -math.floor(wH/2))
        window.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
        window.BorderSizePixel = 0
        window.ClipsDescendants = true
        window.Parent = mainGui
        Instance.new("UICorner", window).CornerRadius = UDim.new(0, 16)
        local wStroke = Instance.new("UIStroke", window)
        wStroke.Color = Color3.fromRGB(255, 80, 100)
        wStroke.Thickness = 2
        
        -- Header
        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 76)
        header.BackgroundColor3 = Color3.fromRGB(35, 8, 20)
        header.BorderSizePixel = 0
        header.Parent = window
        Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -120, 0, 30)
        title.Position = UDim2.new(0, 16, 0, 8)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBlack
        title.Text = "KOF SPAM"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 24
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = header
        local tSt = Instance.new("UIStroke", title)
        tSt.Color = Color3.fromRGB(255, 80, 100)
        tSt.Thickness = 1.5
        tSt.Transparency = 0.2
        
        local sub = Instance.new("TextLabel")
        sub.Size = UDim2.new(1, -120, 0, 22)
        sub.Position = UDim2.new(0, 16, 0, 42)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.GothamBold
        sub.Text = "🔥 KOF HEAVY SPAM 🔥"
        sub.TextColor3 = Color3.fromRGB(255, 150, 150)
        sub.TextSize = 12
        sub.TextXAlignment = Enum.TextXAlignment.Left
        sub.Parent = header
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 46, 0, 46)
        closeBtn.Position = UDim2.new(1, -56, 0.5, -23)
        closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
        closeBtn.Text = "✕"
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize = 22
        closeBtn.BorderSizePixel = 0
        closeBtn.Parent = header
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
        
        -- Content
        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, -20, 1, -96)
        content.Position = UDim2.new(0, 10, 0, 86)
        content.BackgroundColor3 = Color3.fromRGB(18, 10, 32)
        content.BackgroundTransparency = 0.1
        content.BorderSizePixel = 0
        content.ScrollBarThickness = 8
        content.ScrollBarImageColor3 = Color3.fromRGB(255, 80, 100)
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.Parent = window
        Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)
        
        local cList = Instance.new("UIListLayout", content)
        cList.Padding = UDim.new(0, 10)
        cList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            content.CanvasSize = UDim2.new(0, 0, 0, cList.AbsoluteContentSize.Y + 20)
        end)
        local cPad = Instance.new("UIPadding", content)
        cPad.PaddingTop = UDim.new(0, 10)
        cPad.PaddingLeft = UDim.new(0, 8)
        cPad.PaddingRight = UDim.new(0, 8)
        cPad.PaddingBottom = UDim.new(0, 10)
        
        -- Prefix input
        local msgCard = Instance.new("Frame")
        msgCard.Size = UDim2.new(1, 0, 0, 88)
        msgCard.BackgroundColor3 = Color3.fromRGB(28, 18, 48)
        msgCard.BorderSizePixel = 0
        msgCard.Parent = content
        Instance.new("UICorner", msgCard).CornerRadius = UDim.new(0, 10)
        
        local msgLbl = Instance.new("TextLabel")
        msgLbl.Size = UDim2.new(1, -24, 0, 22)
        msgLbl.Position = UDim2.new(0, 12, 0, 6)
        msgLbl.BackgroundTransparency = 1
        msgLbl.Font = Enum.Font.GothamBold
        msgLbl.Text = "CUSTOM PREFIX (optional)"
        msgLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
        msgLbl.TextSize = 12
        msgLbl.TextXAlignment = Enum.TextXAlignment.Left
        msgLbl.Parent = msgCard
        
        local msgBox = Instance.new("TextBox")
        msgBox.Size = UDim2.new(1, -24, 0, 44)
        msgBox.Position = UDim2.new(0, 12, 0, 36)
        msgBox.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
        msgBox.Font = Enum.Font.Gotham
        msgBox.Text = ""
        msgBox.PlaceholderText = "Type prefix (blank = none)..."
        msgBox.PlaceholderColor3 = Color3.fromRGB(100, 90, 130)
        msgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        msgBox.TextSize = 15
        msgBox.TextXAlignment = Enum.TextXAlignment.Left
        msgBox.ClearTextOnFocus = false
        msgBox.Parent = msgCard
        Instance.new("UICorner", msgBox).CornerRadius = UDim.new(0, 6)
        local mPad = Instance.new("UIPadding", msgBox)
        mPad.PaddingLeft = UDim.new(0, 10)
        
        -- Speed selector
        local speedCard = Instance.new("Frame")
        speedCard.Size = UDim2.new(1, 0, 0, 120)
        speedCard.BackgroundColor3 = Color3.fromRGB(28, 18, 48)
        speedCard.BorderSizePixel = 0
        speedCard.Parent = content
        Instance.new("UICorner", speedCard).CornerRadius = UDim.new(0, 10)
        
        local speedLbl = Instance.new("TextLabel")
        speedLbl.Size = UDim2.new(1, -24, 0, 22)
        speedLbl.Position = UDim2.new(0, 12, 0, 6)
        speedLbl.BackgroundTransparency = 1
        speedLbl.Font = Enum.Font.GothamBold
        speedLbl.Text = "SPEED: NORMAL (0.5s)"
        speedLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
        speedLbl.TextSize = 12
        speedLbl.TextXAlignment = Enum.TextXAlignment.Left
        speedLbl.Parent = speedCard
        
        local speedValue = 0.5
        local speedBtns = {}
        local function makeSpeedBtn(label, value, x)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(0, 100, 0, 34)
            b.Position = UDim2.new(0, 12 + x * 108, 0, 34)
            b.BackgroundColor3 = Color3.fromRGB(45, 25, 60)
            b.Font = Enum.Font.GothamBold
            b.Text = label
            b.TextColor3 = Color3.fromRGB(200, 180, 255)
            b.TextSize = 12
            b.BorderSizePixel = 0
            b.Parent = speedCard
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            speedBtns[value] = b
            b.MouseButton1Click:Connect(function()
                speedValue = value
                for v, btn in pairs(speedBtns) do
                    if v == value then
                        btn.BackgroundColor3 = Color3.fromRGB(255, 80, 100)
                        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        btn.BackgroundColor3 = Color3.fromRGB(45, 25, 60)
                        btn.TextColor3 = Color3.fromRGB(200, 180, 255)
                    end
                end
                speedLbl.Text = "SPEED: " .. label .. " (" .. value .. "s)"
            end)
        end
        makeSpeedBtn("TURBO", 0.1, 0)
        makeSpeedBtn("FAST", 0.25, 1)
        makeSpeedBtn("NORMAL", 0.5, 2)
        makeSpeedBtn("SLOW", 1.0, 3)
        
        speedBtns[0.5].BackgroundColor3 = Color3.fromRGB(255, 80, 100)
        speedBtns[0.5].TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local speedHint = Instance.new("TextLabel")
        speedHint.Size = UDim2.new(1, -24, 0, 20)
        speedHint.Position = UDim2.new(0, 12, 0, 80)
        speedHint.BackgroundTransparency = 1
        speedHint.Font = Enum.Font.Gotham
        speedHint.Text = "TURBO = 10 msg/sec • Roblox rate limit: 20 msg/min"
        speedHint.TextColor3 = Color3.fromRGB(150, 130, 180)
        speedHint.TextSize = 10
        speedHint.TextXAlignment = Enum.TextXAlignment.Left
        speedHint.Parent = speedCard
        
        -- Start button
        local startBtn = Instance.new("TextButton")
        startBtn.Size = UDim2.new(1, 0, 0, 70)
        startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
        startBtn.Text = "▶ START KOF SPAM"
        startBtn.Font = Enum.Font.GothamBlack
        startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        startBtn.TextSize = 20
        startBtn.BorderSizePixel = 0
        startBtn.Parent = content
        Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 12)
        
        -- Status card
        local statusCard = Instance.new("Frame")
        statusCard.Size = UDim2.new(1, 0, 0, 60)
        statusCard.BackgroundColor3 = Color3.fromRGB(28, 18, 48)
        statusCard.BorderSizePixel = 0
        statusCard.Parent = content
        Instance.new("UICorner", statusCard).CornerRadius = UDim.new(0, 10)
        
        local statusLbl = Instance.new("TextLabel")
        statusLbl.Size = UDim2.new(1, -24, 0, 24)
        statusLbl.Position = UDim2.new(0, 16, 0, 6)
        statusLbl.BackgroundTransparency = 1
        statusLbl.Font = Enum.Font.GothamBold
        statusLbl.Text = "STOPPED"
        statusLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
        statusLbl.TextSize = 14
        statusLbl.TextXAlignment = Enum.TextXAlignment.Left
        statusLbl.Parent = statusCard
        
        local sentLbl = Instance.new("TextLabel")
        sentLbl.Size = UDim2.new(1, -24, 0, 22)
        sentLbl.Position = UDim2.new(0, 16, 0, 32)
        sentLbl.BackgroundTransparency = 1
        sentLbl.Font = Enum.Font.Gotham
        sentLbl.Text = "SENT: 0"
        sentLbl.TextColor3 = Color3.fromRGB(200, 130, 200)
        sentLbl.TextSize = 12
        sentLbl.TextXAlignment = Enum.TextXAlignment.Left
        sentLbl.Parent = statusCard
        
        -- Start button click
        startBtn.MouseButton1Click:Connect(function()
            isSpammingRef = not isSpammingRef
            if isSpammingRef then
                statusLbl.Text = "🔥 RUNNING - KOF HEAVY SPAM"
                statusLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
                startBtn.Text = "⏹ STOP SPAM"
                startBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
            else
                statusLbl.Text = "STOPPED"
                statusLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
                startBtn.Text = "▶ START KOF SPAM"
                startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
            end
        end)
        
        -- Spam loop (heavy)
        _spawn(function()
            local idx = 1
            while mainGui.Parent do
                if isSpammingRef then
                    local msg = kofMessages[idx]
                    local prefix = msgBox.Text or ""
                    local core = prefix ~= "" and (prefix .. " " .. msg) or msg
                    local pat = kofPatterns[math.random(1, #kofPatterns)]
                    local final = pat .. "\n" .. core .. "\n" .. pat
                    if #final > 195 then
                        local allowed = math.floor((190 - #core) / 2)
                        if allowed > 2 then
                            local short = string.sub(pat, 1, allowed)
                            final = short .. "\n" .. core .. "\n" .. short
                        else
                            final = string.sub(core, 1, 190)
                        end
                    end
                    
                    pcall(function()
                        local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                        if ev and ev:FindFirstChild("SayMessageRequest") then
                            ev.SayMessageRequest:FireServer(final, "All")
                        else
                            local tcs = game:GetService("TextChatService")
                            local tc = tcs.TextChannels:FindFirstChild("RBXGeneral")
                            if tc then tc:SendAsync(final) end
                        end
                    end)
                    
                    sentCountRef = sentCountRef + 1
                    sentLbl.Text = "SENT: " .. sentCountRef
                    idx = idx + 1
                    if idx > #kofMessages then idx = 1 end
                    _wait(speedValue)
                else
                    _wait(0.3)
                end
            end
        end)
        
        -- Close
        closeBtn.MouseButton1Click:Connect(function()
            isSpammingRef = false
            if mainGui.Parent then mainGui:Destroy() end
        end)
        
        -- Drag
        local dragStart, startPos, dragging = nil, nil, false
        header.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
               or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = i.Position
                startPos = window.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and dragStart and (i.UserInputType == Enum.UserInputType.MouseMovement
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
                dragging = false
                dragStart = nil
            end
        end)
        
        print("[KOF] ✅✅✅ GUI BUILD COMPLETE ✅✅✅")
        print("[KOF] Window: " .. tostring(window.AbsolutePosition) .. " size: " .. tostring(window.AbsoluteSize))
    end)
    
    if not ok then
        print("[KOF] ❌ BUILD ERROR: " .. tostring(err))
        pcall(function()
            local errGui = Instance.new("ScreenGui")
            errGui.Name = "ARHHANError"
            errGui.ResetOnSpawn = false
            errGui.Parent = PlayerGui
            local ef = Instance.new("Frame")
            ef.Size = UDim2.new(0.9, 0, 0.4, 0)
            ef.Position = UDim2.new(0.05, 0, 0.3, 0)
            ef.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
            ef.BorderSizePixel = 0
            ef.Parent = errGui
            Instance.new("UICorner", ef).CornerRadius = UDim.new(0, 12)
            local el = Instance.new("TextLabel")
            el.Size = UDim2.new(1, -20, 1, -20)
            el.Position = UDim2.new(0, 10, 0, 10)
            el.BackgroundTransparency = 1
            el.Font = Enum.Font.Gotham
            el.Text = "KOF GUI ERROR:\n\n" .. tostring(err) .. "\n\nCheck console (F9)"
            el.TextColor3 = Color3.fromRGB(255, 200, 200)
            el.TextSize = 14
            el.TextWrapped = true
            el.Parent = ef
            _delay(15, function() if errGui.Parent then errGui:Destroy() end end)
        end)
    end
end

-- ============ LOADING SCREEN ============
print("[KOF] Building loading screen...")

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "KOFLoading"
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false
loadingGui.DisplayOrder = 99999
loadingGui.Parent = PlayerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local loadTitle = Instance.new("TextLabel")
loadTitle.Size = UDim2.new(1, -40, 0, 100)
loadTitle.Position = UDim2.new(0, 20, 0.28, 0)
loadTitle.BackgroundTransparency = 1
loadTitle.Font = Enum.Font.GothamBlack
loadTitle.Text = "KOF"
loadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadTitle.TextSize = 72
loadTitle.Parent = bg
local lStroke = Instance.new("UIStroke", loadTitle)
lStroke.Color = Color3.fromRGB(255, 80, 100)
lStroke.Thickness = 3
lStroke.Transparency = 0.2

local loadSub = Instance.new("TextLabel")
loadSub.Size = UDim2.new(1, -40, 0, 28)
loadSub.Position = UDim2.new(0, 20, 0.42, 0)
loadSub.BackgroundTransparency = 1
loadSub.Font = Enum.Font.GothamBold
loadSub.Text = "🔥 HEAVY SPAM EDITION 🔥"
loadSub.TextColor3 = Color3.fromRGB(255, 150, 150)
loadSub.TextSize = 16
loadSub.Parent = bg

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(1, -40, 0, 30)
loadText.Position = UDim2.new(0, 20, 0.6, 0)
loadText.BackgroundTransparency = 1
loadText.Font = Enum.Font.GothamBold
loadText.Text = "LOADING..."
loadText.TextColor3 = Color3.fromRGB(200, 180, 255)
loadText.TextSize = 18
loadText.Parent = bg

local pBar = Instance.new("Frame")
pBar.Size = UDim2.new(0.7, 0, 0, 12)
pBar.Position = UDim2.new(0.5, 0, 0.7, 0)
pBar.AnchorPoint = Vector2.new(0.5, 0)
pBar.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
pBar.BorderSizePixel = 0
pBar.Parent = bg
Instance.new("UICorner", pBar).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 100)
pFill.BorderSizePixel = 0
pFill.Parent = pBar
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)

print("[KOF] Loading screen built ✓")

-- ============ TRANSITION ============
local transitioned = false
local function transition()
    if transitioned then return end
    transitioned = true
    print("[KOF] === TRANSITION START ===")
    if loadingGui.Parent then loadingGui:Destroy() end
    buildMainGui()
    print("[KOF] === TRANSITION END ===")
end

_spawn(function()
    for i = 1, 50 do
        _wait(0.025)
        pFill.Size = UDim2.new(i / 50, 0, 1, 0)
    end
    loadText.Text = "READY ✅"
    _wait(0.25)
    transition()
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        transition()
    end
end)

_delay(4, function()
    if not transitioned then
        print("[KOF] ⚠️ HARD TIMEOUT")
        transition()
    end
end)

print("[KOF] === SCRIPT READY ===")