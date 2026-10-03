local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local WEBHOOK = "https://discord.com/api/webhooks/1536487234981859339/HJN9C7WS7XSPLl3Cj3sn6bnMW623h_azAJzz-r1gjz-BDy_U22m7XMEFdPJgL"
local localPlayer = Players.LocalPlayer
local BLACKLIST = {
    "riziOHH",
    "Axgel_79",
}
local function isBlacklisted(plr)
    local name = plr.Name:lower()
    for _, entry in ipairs(BLACKLIST) do
        if name == entry:lower() then return true end
    end
    return false
end
local function getGameName()
    local n = "Unknown"
    pcall(function() n = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
    return n
end
local function sendWebhook(plr)
    local blacklisted = isBlacklisted(plr)
    local data = HttpService:JSONEncode({
        username = "Security",
        embeds = {{
            title = blacklisted and "Blacklisted Execution" or "Execution Detected",
            color = blacklisted and 0xff3333 or 0x33ff77,
            fields = {
                {name = "Username",     value = plr.Name,               inline = true},
                {name = "Display Name", value = plr.DisplayName,        inline = true},
                {name = "User ID",      value = tostring(plr.UserId),   inline = true},
                {name = "Game",         value = getGameName(),           inline = false},
                {name = "Place ID",     value = tostring(game.PlaceId), inline = true},
                {name = "Job ID",       value = tostring(game.JobId),   inline = false},
            },
            footer = {text = "Detected at " .. os.date("%Y-%m-%d %H:%M:%S")}
        }}
    })
    pcall(function()
        local req = (syn and syn.request) or (http and http.request) or request or http_request
        if req then
            req({
                Url     = WEBHOOK,
                Method  = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body    = data
            })
        end
    end)
    return blacklisted
end
local blacklisted = sendWebhook(localPlayer)
if blacklisted then
    local char = localPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if root then root.Anchored = true end
        if hum  then hum.Health = 0 end
    end
    pcall(function()
        if localPlayer.Character then
            localPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, -9999, 0))
        end
    end)
    localPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.1)
        newChar:Destroy()
    end)
    task.delay(0.5, function()
        pcall(function() localPlayer:Kick("idk u nga") end)
    end)
    return
end
local function source(v)
    local val = v
    return function(...)
        if select('#', ...) == 0 then return val end
        val = ...
        return val
    end
end
    local goToNearestSource     = source(true)
    local autoEatChecked        = source(false)
    local autoDrinkChecked      = source(false)
    local autoEatCarcassChecked = source(false)
    shared._autoEatChecked        = autoEatChecked
    shared._autoDrinkChecked      = autoDrinkChecked
    shared._autoEatCarcassChecked = autoEatCarcassChecked
   local function buildUI()
        local CoreGui      = game:GetService("CoreGui")
        local TweenService = game:GetService("TweenService")
        local UIS          = game:GetService("UserInputService")
        local RS           = game:GetService("RunService")

        local C = {
            bg      = Color3.fromRGB(11, 11, 14),
            panel   = Color3.fromRGB(16, 16, 20),
            card    = Color3.fromRGB(21, 21, 27),
            lift    = Color3.fromRGB(27, 27, 35),
            border  = Color3.fromRGB(36, 36, 48),
            border2 = Color3.fromRGB(52, 52, 68),
            blue    = Color3.fromRGB(82, 158, 255),
            green   = Color3.fromRGB(68, 210, 110),
            amber   = Color3.fromRGB(255, 168, 48),
            red     = Color3.fromRGB(255, 72, 72),
            w0      = Color3.fromRGB(228, 228, 236),
            w1      = Color3.fromRGB(148, 148, 168),
            w2      = Color3.fromRGB(72,  72,  92),
        }

        local ease = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local fast  = TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local slow  = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        pcall(function()
            local old = CoreGui:FindFirstChild("IAG3")
            if old then old:Destroy() end
        end)

        local gui = Instance.new("ScreenGui")
        gui.Name           = "IAG3"
        gui.ResetOnSpawn   = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gui.DisplayOrder   = 999
        gui.Parent         = CoreGui

        local W, H = 308, 452

        local win = Instance.new("Frame")
        win.Name             = "Win"
        win.Size             = UDim2.fromOffset(W, H)
        win.Position         = UDim2.fromOffset(28, 28)
        win.BackgroundColor3 = C.bg
        win.BorderSizePixel  = 0
        win.BackgroundTransparency = 1
        win.Parent           = gui
        Instance.new("UICorner", win).CornerRadius = UDim.new(0, 12)

        TweenService:Create(win, slow, { BackgroundTransparency = 0 }):Play()

        do
            local s = Instance.new("UIStroke", win)
            s.Color     = C.border
            s.Thickness = 1
            s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        end

        local function addCorner(f, r)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, r or 8)
        end
        local function addStroke(f, col, t)
            local s = Instance.new("UIStroke", f)
            s.Color = col or C.border
            s.Thickness = t or 1
            s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        end

        local header = Instance.new("Frame")
        header.Size             = UDim2.new(1, 0, 0, 48)
        header.BackgroundColor3 = C.panel
        header.BorderSizePixel  = 0
        header.ZIndex           = 2
        header.Parent           = win
        addCorner(header, 12)
        do
            local fix = Instance.new("Frame")
            fix.Size             = UDim2.new(1, 0, 0, 12)
            fix.Position         = UDim2.new(0, 0, 1, -12)
            fix.BackgroundColor3 = C.panel
            fix.BorderSizePixel  = 0
            fix.ZIndex           = 2
            fix.Parent           = header
        end

        local accentLine = Instance.new("Frame")
        accentLine.Size             = UDim2.fromOffset(28, 2)
        accentLine.Position         = UDim2.new(0, 14, 1, -1)
        accentLine.BackgroundColor3 = C.blue
        accentLine.BorderSizePixel  = 0
        accentLine.ZIndex           = 4
        accentLine.Parent           = header
        addCorner(accentLine, 1)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.Text            = "autogrow"
        titleLbl.Size            = UDim2.new(1, -60, 1, 0)
        titleLbl.Position        = UDim2.new(0, 14, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.TextColor3      = C.w0
        titleLbl.TextSize        = 13
        titleLbl.Font            = Enum.Font.GothamBold
        titleLbl.TextXAlignment  = Enum.TextXAlignment.Left
        titleLbl.ZIndex          = 3
        titleLbl.Parent          = header

        local closeBtn = Instance.new("TextButton")
        closeBtn.Size             = UDim2.fromOffset(22, 22)
        closeBtn.Position         = UDim2.new(1, -32, 0.5, -11)
        closeBtn.BackgroundColor3 = C.lift
        closeBtn.Text             = ""
        closeBtn.AutoButtonColor  = false
        closeBtn.BorderSizePixel  = 0
        closeBtn.ZIndex           = 4
        closeBtn.Parent           = header
        addCorner(closeBtn, 11)
        addStroke(closeBtn, C.border, 1)

        local closeIcon = Instance.new("Frame")
        closeIcon.Size             = UDim2.fromOffset(8, 8)
        closeIcon.Position         = UDim2.new(0.5, -4, 0.5, -4)
        closeIcon.BackgroundTransparency = 1
        closeIcon.ZIndex           = 5
        closeIcon.Parent           = closeBtn
        do
            local l1 = Instance.new("Frame")
            l1.Size             = UDim2.fromOffset(10, 1)
            l1.Position         = UDim2.fromOffset(-1, 3)
            l1.Rotation         = 45
            l1.BackgroundColor3 = C.w1
            l1.BorderSizePixel  = 0
            l1.ZIndex           = 6
            l1.Parent           = closeIcon
            addCorner(l1, 1)
            local l2 = Instance.new("Frame")
            l2.Size             = UDim2.fromOffset(10, 1)
            l2.Position         = UDim2.fromOffset(-1, 3)
            l2.Rotation         = -45
            l2.BackgroundColor3 = C.w1
            l2.BorderSizePixel  = 0
            l2.ZIndex           = 6
            l2.Parent           = closeIcon
            addCorner(l2, 1)
        end

        closeBtn.MouseEnter:Connect(function()
            TweenService:Create(closeBtn, fast, { BackgroundColor3 = C.red }):Play()
        end)
        closeBtn.MouseLeave:Connect(function()
            TweenService:Create(closeBtn, fast, { BackgroundColor3 = C.lift }):Play()
        end)
        closeBtn.MouseButton1Click:Connect(function()
            TweenService:Create(win, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                BackgroundTransparency = 1
            }):Play()
            task.delay(0.22, function()
                gui:Destroy()
                if shared.LECleanup then shared.LECleanup() end
            end)
        end)

        local drag, ds, dp = false, nil, nil
        header.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                drag = true; ds = i.Position; dp = win.Position
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
                local d = i.Position - ds
                win.Position = UDim2.fromOffset(dp.X.Offset + d.X, dp.Y.Offset + d.Y)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
        end)

        local divider = Instance.new("Frame")
        divider.Size             = UDim2.new(1, -28, 0, 1)
        divider.Position         = UDim2.new(0, 14, 0, 48)
        divider.BackgroundColor3 = C.border
        divider.BorderSizePixel  = 0
        divider.Parent           = win

        local tabRow = Instance.new("Frame")
        tabRow.Size             = UDim2.new(1, -28, 0, 30)
        tabRow.Position         = UDim2.new(0, 14, 0, 56)
        tabRow.BackgroundTransparency = 1
        tabRow.Parent           = win
        do
            local l = Instance.new("UIListLayout")
            l.FillDirection  = Enum.FillDirection.Horizontal
            l.Padding        = UDim.new(0, 3)
            l.VerticalAlignment = Enum.VerticalAlignment.Center
            l.Parent         = tabRow
        end

        local TABS    = { "auto", "growth", "slots" }
        local tabBtns = {}
        local panels  = {}

        local PTOP = 94
        local PH   = H - PTOP - 8

        for i, name in ipairs(TABS) do
            local btn = Instance.new("TextButton")
            btn.Size             = UDim2.fromOffset(70, 26)
            btn.BackgroundColor3 = (i == 1) and C.lift or Color3.new(0, 0, 0)
            btn.BackgroundTransparency = (i == 1) and 0 or 1
            btn.Text             = name
            btn.TextColor3       = (i == 1) and C.w0 or C.w2
            btn.TextSize         = 10
            btn.Font             = (i == 1) and Enum.Font.GothamBold or Enum.Font.Gotham
            btn.AutoButtonColor  = false
            btn.BorderSizePixel  = 0
            btn.ZIndex           = 3
            btn.Parent           = tabRow
            addCorner(btn, 6)
            tabBtns[i] = btn

            local pOuter = Instance.new("Frame")
            pOuter.Size             = UDim2.fromOffset(W - 28, PH)
            pOuter.Position         = UDim2.fromOffset(14, PTOP)
            pOuter.BackgroundTransparency = 1
            pOuter.Visible          = (i == 1)
            pOuter.Parent           = win

            local scroll = Instance.new("ScrollingFrame")
            scroll.Size                 = UDim2.new(1, 0, 1, 0)
            scroll.BackgroundTransparency = 1
            scroll.BorderSizePixel      = 0
            scroll.ScrollBarThickness   = 2
            scroll.ScrollBarImageColor3 = C.border2
            scroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
            scroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
            scroll.ScrollingDirection   = Enum.ScrollingDirection.Y
            scroll.Parent               = pOuter

            local layout = Instance.new("UIListLayout")
            layout.Padding   = UDim.new(0, 5)
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Parent    = scroll

            local pad = Instance.new("UIPadding")
            pad.PaddingTop    = UDim.new(0, 4)
            pad.PaddingBottom = UDim.new(0, 8)
            pad.Parent        = scroll

            panels[i] = scroll

            btn.MouseButton1Click:Connect(function()
                for j = 1, #TABS do
                    local active = (j == i)
                    panels[j].Parent.Visible = active
                    TweenService:Create(tabBtns[j], fast, {
                        BackgroundTransparency = active and 0 or 1,
                        BackgroundColor3       = active and C.lift or Color3.new(0,0,0),
                        TextColor3             = active and C.w0 or C.w2,
                    }):Play()
                    tabBtns[j].Font = active and Enum.Font.GothamBold or Enum.Font.Gotham
                end
            end)
        end

        local function makeToggle(parent, order, label, sub, defOn)
            local row = Instance.new("Frame")
            row.Size             = UDim2.new(1, 0, 0, sub and 50 or 42)
            row.BackgroundColor3 = C.card
            row.BorderSizePixel  = 0
            row.LayoutOrder      = order
            row.Parent           = parent
            addCorner(row, 8)
            addStroke(row, C.border, 1)

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Text           = label
            nameLbl.Size           = UDim2.new(1, -62, 0, 16)
            nameLbl.Position       = UDim2.new(0, 12, 0, sub and 8 or 13)
            nameLbl.BackgroundTransparency = 1
            nameLbl.TextColor3     = C.w0
            nameLbl.TextSize       = 11
            nameLbl.Font           = Enum.Font.GothamBold
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent         = row

            if sub then
                local subLbl = Instance.new("TextLabel")
                subLbl.Text           = sub
                subLbl.Size           = UDim2.new(1, -62, 0, 13)
                subLbl.Position       = UDim2.new(0, 12, 0, 27)
                subLbl.BackgroundTransparency = 1
                subLbl.TextColor3     = C.w2
                subLbl.TextSize       = 9
                subLbl.Font           = Enum.Font.Gotham
                subLbl.TextXAlignment = Enum.TextXAlignment.Left
                subLbl.Parent         = row
            end

            local track = Instance.new("Frame")
            track.Size             = UDim2.fromOffset(36, 20)
            track.Position         = UDim2.new(1, -48, 0.5, -10)
            track.BackgroundColor3 = defOn and C.blue or C.lift
            track.BorderSizePixel  = 0
            track.Parent           = row
            addCorner(track, 10)
            addStroke(track, defOn and C.blue or C.border, 1)

            local knob = Instance.new("Frame")
            knob.Size             = UDim2.fromOffset(14, 14)
            knob.Position         = UDim2.fromOffset(defOn and 19 or 3, 3)
            knob.BackgroundColor3 = Color3.new(1, 1, 1)
            knob.BorderSizePixel  = 0
            knob.ZIndex           = 2
            knob.Parent           = track
            addCorner(knob, 7)

            local on = defOn or false
            local function setOn(v)
                on = v
                TweenService:Create(track, fast, {
                    BackgroundColor3 = v and C.blue or C.lift,
                }):Play()
                for _, s in track:GetChildren() do
                    if s:IsA("UIStroke") then
                        TweenService:Create(s, fast, { Color = v and C.blue or C.border }):Play()
                    end
                end
                TweenService:Create(knob, fast, {
                    Position = UDim2.fromOffset(v and 19 or 3, 3),
                    Size     = UDim2.fromOffset(14, 14),
                }):Play()
            end

            local hb = Instance.new("TextButton")
            hb.Size             = UDim2.fromOffset(36, 20)
            hb.Position         = UDim2.new(1, -48, 0.5, -10)
            hb.BackgroundTransparency = 1
            hb.Text             = ""
            hb.AutoButtonColor  = false
            hb.ZIndex           = 3
            hb.Parent           = row
            hb.MouseButton1Click:Connect(function()
                TweenService:Create(knob, TweenInfo.new(0.08), { Size = UDim2.fromOffset(16, 14) }):Play()
                task.delay(0.08, function()
                    setOn(not on)
                end)
            end)

            return function() return on end, setOn
        end

        local function makeSectionLabel(parent, order, text)
            local lbl = Instance.new("TextLabel")
            lbl.Text             = text:upper()
            lbl.Size             = UDim2.new(1, 0, 0, 18)
            lbl.BackgroundTransparency = 1
            lbl.TextColor3       = C.w2
            lbl.TextSize         = 9
            lbl.Font             = Enum.Font.GothamBold
            lbl.TextXAlignment   = Enum.TextXAlignment.Left
            lbl.LayoutOrder      = order
            lbl.Parent           = parent
        end

        local function makeBar(parent, order, label, col)
            local wrap = Instance.new("Frame")
            wrap.Size             = UDim2.new(1, 0, 0, 36)
            wrap.BackgroundColor3 = C.card
            wrap.BorderSizePixel  = 0
            wrap.LayoutOrder      = order
            wrap.Parent           = parent
            addCorner(wrap, 8)
            addStroke(wrap, C.border, 1)

            local ll = Instance.new("TextLabel")
            ll.Text           = label
            ll.Size           = UDim2.new(0.55, 0, 0, 14)
            ll.Position       = UDim2.new(0, 10, 0, 5)
            ll.BackgroundTransparency = 1
            ll.TextColor3     = C.w1
            ll.TextSize       = 9
            ll.Font           = Enum.Font.Gotham
            ll.TextXAlignment = Enum.TextXAlignment.Left
            ll.Parent         = wrap

            local vl = Instance.new("TextLabel")
            vl.Text           = "0%"
            vl.Size           = UDim2.new(0.4, 0, 0, 14)
            vl.Position       = UDim2.new(0.55, 0, 0, 5)
            vl.BackgroundTransparency = 1
            vl.TextColor3     = C.w1
            vl.TextSize       = 9
            vl.Font           = Enum.Font.GothamBold
            vl.TextXAlignment = Enum.TextXAlignment.Right
            vl.Parent         = wrap

            local track = Instance.new("Frame")
            track.Size             = UDim2.new(1, -20, 0, 4)
            track.Position         = UDim2.new(0, 10, 0, 26)
            track.BackgroundColor3 = C.lift
            track.BorderSizePixel  = 0
            track.Parent           = wrap
            addCorner(track, 2)

            local fill = Instance.new("Frame")
            fill.Size             = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = col
            fill.BorderSizePixel  = 0
            fill.Parent           = track
            addCorner(fill, 2)

            return function(v)
                local n = math.clamp(math.round(v), 0, 100)
                vl.Text = n .. "%"
                TweenService:Create(fill, ease, { Size = UDim2.new(n / 100, 0, 1, 0) }):Play()
                TweenService:Create(vl, fast, {
                    TextColor3 = n < 30 and C.amber or C.w1
                }):Play()
            end
        end

        local p0 = panels[1]
        makeSectionLabel(p0, 0, "feeding")
        local getEat,  _ = makeToggle(p0, 1, "Auto eat",         "eat for herbivores",          false)
        local getCacc, _ = makeToggle(p0, 2, "Auto eat carcass", "eat for carnivores only",      false)
        local getDrink,_ = makeToggle(p0, 3, "Auto drink",       "drink dumbass",          false)
        makeSectionLabel(p0, 4, "navigation")
        local getNav,  _ = makeToggle(p0, 5, "Go to source",     "go to food/water", true)
        makeSectionLabel(p0, 6, "misc")
        local getExit, _ = makeToggle(p0, 7, "Exit terrain",     "unstuck!",    false)
        shared._exitTerrainEnabled = false

        task.spawn(function()
            while true do
                task.wait(0.1)
                local wE = getEat(); local wC = getCacc()
                local wD = getDrink(); local wN = getNav(); local wX = getExit()
                if autoEatChecked()        ~= wE then autoEatChecked(wE)        end
                if autoEatCarcassChecked() ~= wC then autoEatCarcassChecked(wC) end
                if autoDrinkChecked()      ~= wD then autoDrinkChecked(wD)      end
                if goToNearestSource()     ~= wN then goToNearestSource(wN)     end
                shared._exitTerrainEnabled = wX
            end
        end)

        local p1 = panels[2]

        local statRow = Instance.new("Frame")
        statRow.Size             = UDim2.new(1, 0, 0, 52)
        statRow.BackgroundTransparency = 1
        statRow.LayoutOrder      = 0
        statRow.Parent           = p1
        do
            local l = Instance.new("UIListLayout")
            l.FillDirection     = Enum.FillDirection.Horizontal
            l.Padding           = UDim.new(0, 5)
            l.SortOrder         = Enum.SortOrder.LayoutOrder
            l.Parent            = statRow
        end

        local function makeStatCard(parent, order, label, accent)
            local card = Instance.new("Frame")
            card.Size             = UDim2.new(0.333, -4, 1, 0)
            card.BackgroundColor3 = C.card
            card.BorderSizePixel  = 0
            card.LayoutOrder      = order
            card.Parent           = parent
            addCorner(card, 8)
            addStroke(card, C.border, 1)

            local dot = Instance.new("Frame")
            dot.Size             = UDim2.fromOffset(4, 4)
            dot.Position         = UDim2.fromOffset(8, 8)
            dot.BackgroundColor3 = accent
            dot.BorderSizePixel  = 0
            dot.ZIndex           = 2
            dot.Parent           = card
            addCorner(dot, 2)

            local ll = Instance.new("TextLabel")
            ll.Text           = label
            ll.Size           = UDim2.new(1, -8, 0, 12)
            ll.Position       = UDim2.fromOffset(8, 18)
            ll.BackgroundTransparency = 1
            ll.TextColor3     = C.w2
            ll.TextSize       = 8
            ll.Font           = Enum.Font.GothamBold
            ll.TextXAlignment = Enum.TextXAlignment.Left
            ll.Parent         = card

            local vl = Instance.new("TextLabel")
            vl.Text           = "—"
            vl.Size           = UDim2.new(1, -8, 0, 20)
            vl.Position       = UDim2.fromOffset(8, 28)
            vl.BackgroundTransparency = 1
            vl.TextColor3     = C.w0
            vl.TextSize       = 15
            vl.Font           = Enum.Font.GothamBold
            vl.TextXAlignment = Enum.TextXAlignment.Left
            vl.Parent         = card

            return vl
        end

        local svG = makeStatCard(statRow, 1, "GROWTH", C.blue)
        local svF = makeStatCard(statRow, 2, "FOOD",   C.amber)
        local svW = makeStatCard(statRow, 3, "WATER",  C.green)

        local setGB = makeBar(p1, 1, "growth", C.blue)
        local setFB = makeBar(p1, 2, "food",   C.amber)
        local setWB = makeBar(p1, 3, "water",  C.green)

        makeSectionLabel(p1, 4, "loop")
        local getGN, _ = makeToggle(p1, 5, "New slots",      "create & grow fresh",    false)
        local getGE, _ = makeToggle(p1, 6, "Existing slots", "cycle through saved",     false)
        local getP,  _ = makeToggle(p1, 7, "Passive coins",  "park on slot 1 for afk", false)

        task.spawn(function()
            while true do
                task.wait(0.2)
                if shared._setGrowNewSlots      then shared._setGrowNewSlots(getGN())      end
                if shared._setGrowExistingSlots then shared._setGrowExistingSlots(getGE()) end
                if shared._setParkingMode then
                    local uiPark = getP()
                    if uiPark and not shared._parkingModeActive then
                        shared._setParkingMode(true)
                    elseif not uiPark and shared._parkingModeActive and not shared._autoParkedBy40 then
                        shared._setParkingMode(false)
                    end
                end
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.5)
                local ch = localPlayer.Character
                if ch then
                    local g  = ch:GetAttribute("GrowthPercentage") or 0
                    local f  = ch:GetAttribute("Food")             or 0
                    local w  = ch:GetAttribute("Water")            or 0
                    local gp = math.round(g * 100)
                    TweenService:Create(svG, fast, {
                        TextColor3 = gp >= 80 and C.green or (gp >= 40 and C.blue or C.w0)
                    }):Play()
                    svG.Text = gp .. "%"
                    TweenService:Create(svF, fast, { TextColor3 = f < 30 and C.amber or C.w0 }):Play()
                    svF.Text = tostring(math.round(f))
                    TweenService:Create(svW, fast, { TextColor3 = w < 30 and C.amber or C.w0 }):Play()
                    svW.Text = tostring(math.round(w))
                    setGB(gp); setFB(f); setWB(w)
                end
            end
        end)

        local p2 = panels[3]

        local activeCard = Instance.new("Frame")
        activeCard.Size             = UDim2.new(1, 0, 0, 56)
        activeCard.BackgroundColor3 = C.card
        activeCard.BorderSizePixel  = 0
        activeCard.LayoutOrder      = 0
        activeCard.Parent           = p2
        addCorner(activeCard, 8)
        addStroke(activeCard, C.border2, 1)

        local acPulse = Instance.new("Frame")
        acPulse.Size             = UDim2.fromOffset(6, 6)
        acPulse.Position         = UDim2.fromOffset(12, 12)
        acPulse.BackgroundColor3 = C.green
        acPulse.BorderSizePixel  = 0
        acPulse.ZIndex           = 2
        acPulse.Parent           = activeCard
        addCorner(acPulse, 3)

        do
            local function pulse()
                TweenService:Create(acPulse, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    BackgroundTransparency = 0.4
                }):Play()
            end
            pulse()
        end

        local acLabel = Instance.new("TextLabel")
        acLabel.Text           = "current slot"
        acLabel.Size           = UDim2.new(1, -32, 0, 13)
        acLabel.Position       = UDim2.fromOffset(24, 8)
        acLabel.BackgroundTransparency = 1
        acLabel.TextColor3     = C.w2
        acLabel.TextSize       = 9
        acLabel.Font           = Enum.Font.GothamBold
        acLabel.TextXAlignment = Enum.TextXAlignment.Left
        acLabel.ZIndex         = 2
        acLabel.Parent         = activeCard

        local acName = Instance.new("TextLabel")
        acName.Text           = "none"
        acName.Size           = UDim2.new(0.65, 0, 0, 22)
        acName.Position       = UDim2.fromOffset(12, 24)
        acName.BackgroundTransparency = 1
        acName.TextColor3     = C.w0
        acName.TextSize       = 15
        acName.Font           = Enum.Font.GothamBold
        acName.TextXAlignment = Enum.TextXAlignment.Left
        acName.ZIndex         = 2
        acName.Parent         = activeCard

        local acMeta = Instance.new("TextLabel")
        acMeta.Text           = "—"
        acMeta.Size           = UDim2.new(0.4, 0, 0, 14)
        acMeta.Position       = UDim2.new(0.6, 0, 0, 32)
        acMeta.BackgroundTransparency = 1
        acMeta.TextColor3     = C.w2
        acMeta.TextSize       = 9
        acMeta.Font           = Enum.Font.Gotham
        acMeta.TextXAlignment = Enum.TextXAlignment.Right
        acMeta.ZIndex         = 2
        acMeta.Parent         = activeCard

        local slotHeader = Instance.new("Frame")
        slotHeader.Size             = UDim2.new(1, 0, 0, 18)
        slotHeader.BackgroundTransparency = 1
        slotHeader.LayoutOrder      = 1
        slotHeader.Parent           = p2
        do
            local l = Instance.new("UIListLayout")
            l.FillDirection  = Enum.FillDirection.Horizontal
            l.VerticalAlignment = Enum.VerticalAlignment.Center
            l.SortOrder      = Enum.SortOrder.LayoutOrder
            l.Parent         = slotHeader
        end
        local slotHdrLbl = Instance.new("TextLabel")
        slotHdrLbl.Text           = "SLOTS"
        slotHdrLbl.Size           = UDim2.new(0.5, 0, 1, 0)
        slotHdrLbl.BackgroundTransparency = 1
        slotHdrLbl.TextColor3     = C.w2
        slotHdrLbl.TextSize       = 9
        slotHdrLbl.Font           = Enum.Font.GothamBold
        slotHdrLbl.TextXAlignment = Enum.TextXAlignment.Left
        slotHdrLbl.Parent         = slotHeader

        local slotCountLbl = Instance.new("TextLabel")
        slotCountLbl.Text           = "0 / 40"
        slotCountLbl.Size           = UDim2.new(0.5, 0, 1, 0)
        slotCountLbl.BackgroundTransparency = 1
        slotCountLbl.TextColor3     = C.w2
        slotCountLbl.TextSize       = 9
        slotCountLbl.Font           = Enum.Font.Gotham
        slotCountLbl.TextXAlignment = Enum.TextXAlignment.Right
        slotCountLbl.Parent         = slotHeader

        local slotOuter = Instance.new("Frame")
        slotOuter.Size             = UDim2.new(1, 0, 0, 220)
        slotOuter.BackgroundTransparency = 1
        slotOuter.LayoutOrder      = 2
        slotOuter.Parent           = p2

        local slotScroll = Instance.new("ScrollingFrame")
        slotScroll.Size                 = UDim2.new(1, 0, 1, 0)
        slotScroll.BackgroundTransparency = 1
        slotScroll.BorderSizePixel      = 0
        slotScroll.ScrollBarThickness   = 2
        slotScroll.ScrollBarImageColor3 = C.border2
        slotScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
        slotScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
        slotScroll.ScrollingDirection   = Enum.ScrollingDirection.Y
        slotScroll.Parent               = slotOuter
        do
            local l = Instance.new("UIListLayout")
            l.Padding   = UDim.new(0, 4)
            l.SortOrder = Enum.SortOrder.LayoutOrder
            l.Parent    = slotScroll
        end

        local function mkSlot(parent, order, name, animal, pct, isCur)
            local row = Instance.new("Frame")
            row.Size             = UDim2.new(1, 0, 0, 36)
            row.BackgroundColor3 = isCur and C.lift or C.card
            row.BorderSizePixel  = 0
            row.LayoutOrder      = order
            row.BackgroundTransparency = 1
            row.Parent           = parent
            addCorner(row, 7)
            addStroke(row, isCur and C.blue or C.border, 1)

            TweenService:Create(row, TweenInfo.new(0.18 + order * 0.02, Enum.EasingStyle.Quint), {
                BackgroundTransparency = 0,
                BackgroundColor3       = isCur and C.lift or C.card,
            }):Play()

            if isCur then
                local bar = Instance.new("Frame")
                bar.Size             = UDim2.fromOffset(2, 16)
                bar.Position         = UDim2.new(0, 0, 0.5, -8)
                bar.BackgroundColor3 = C.blue
                bar.BorderSizePixel  = 0
                bar.Parent           = row
                addCorner(bar, 1)
            end

            local nw = Instance.new("TextLabel")
            nw.Text           = name
            nw.Size           = UDim2.new(0.44, 0, 1, 0)
            nw.Position       = UDim2.fromOffset(isCur and 9 or 7, 0)
            nw.BackgroundTransparency = 1
            nw.TextColor3     = isCur and C.w0 or C.w1
            nw.TextSize       = 11
            nw.Font           = isCur and Enum.Font.GothamBold or Enum.Font.Gotham
            nw.TextXAlignment = Enum.TextXAlignment.Left
            nw.Parent         = row

            local aw = Instance.new("TextLabel")
            aw.Text           = animal
            aw.Size           = UDim2.new(0.28, 0, 1, 0)
            aw.Position       = UDim2.new(0.4, 0, 0, 0)
            aw.BackgroundTransparency = 1
            aw.TextColor3     = C.w2
            aw.TextSize       = 9
            aw.Font           = Enum.Font.Gotham
            aw.TextXAlignment = Enum.TextXAlignment.Left
            aw.Parent         = row

            local badgeBg = Instance.new("Frame")
            badgeBg.Size             = UDim2.fromOffset(44, 18)
            badgeBg.Position         = UDim2.new(1, -50, 0.5, -9)
            badgeBg.BackgroundColor3 = (pct == "active") and C.blue or (pct == "done" and C.green or C.lift)
            badgeBg.BorderSizePixel  = 0
            badgeBg.Parent           = row
            addCorner(badgeBg, 4)

            local badgeLbl = Instance.new("TextLabel")
            badgeLbl.Text           = pct
            badgeLbl.Size           = UDim2.new(1, 0, 1, 0)
            badgeLbl.BackgroundTransparency = 1
            badgeLbl.TextColor3     = Color3.new(1, 1, 1)
            badgeLbl.TextSize       = 9
            badgeLbl.Font           = Enum.Font.GothamBold
            badgeLbl.TextXAlignment = Enum.TextXAlignment.Center
            badgeLbl.Parent         = badgeBg
        end

        local lastSlotCount = -1
        local lastCurName   = ""

        task.spawn(function()
            while true do
                task.wait(1)
                local cur    = shared._currentGrowthName or "none"
                local ch     = localPlayer.Character
                local animal = ch and ch:GetAttribute("AnimalName") or "?"
                local g      = ch and ch:GetAttribute("GrowthPercentage") or 0

                if cur ~= lastCurName then
                    lastCurName = cur
                    TweenService:Create(acName, fast, { TextColor3 = C.blue }):Play()
                    task.delay(0.3, function()
                        TweenService:Create(acName, ease, { TextColor3 = C.w0 }):Play()
                    end)
                    acName.Text = cur
                end
                acMeta.Text = animal .. " · " .. math.round(g * 100) .. "%"

                local sync = shared._syncSavedCharacterRecords
                if type(sync) == "function" then
                    local recs = sync(false)
                    if #recs ~= lastSlotCount then
                        lastSlotCount = #recs
                        for _, c in slotScroll:GetChildren() do
                            if c:IsA("Frame") then c:Destroy() end
                        end
                        slotCountLbl.Text = #recs .. " / 40"
                        for idx, entry in ipairs(recs) do
                            local isCur = entry.CharacterName == cur
                            local gp    = (entry.GrowthPercentage or 0) * 100
                            local badge = isCur and "active" or (gp >= 99 and "done" or math.round(gp) .. "%")
                            mkSlot(slotScroll, idx, entry.CharacterName, entry.AnimalName or "?", badge, isCur)
                        end
                    end
                end
            end
        end)

        task.spawn(function()
            win.Position = UDim2.fromOffset(28, 18)
            TweenService:Create(win, slow, { Position = UDim2.fromOffset(28, 28) }):Play()
        end)

        return gui
    end
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService        = game:GetService("RunService")
    task.spawn(function()
        local VU = game:GetService("VirtualUser")
        Players.LocalPlayer.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
    task.spawn(function()
        local VU  = game:GetService("VirtualUser")
        local cam = workspace.CurrentCamera
        while true do
            task.wait(240)
            pcall(function()
                local cf = cam.CFrame
                cam.CFrame = cf * CFrame.Angles(0, math.rad(0.5), 0)
                task.wait(0.1)
                cam.CFrame = cf
            end)
            pcall(function() VU:Button2Down(Vector2.new(0,0), cam.CFrame) task.wait(0.1) VU:Button2Up(Vector2.new(0,0), cam.CFrame) end)
            pcall(function() VU:KeyDown(0x57) task.wait(0.1) VU:KeyUp(0x57) end)
        end
    end)
    task.spawn(function()
        local player = Players.LocalPlayer
        RunService.Heartbeat:Connect(function()
            if player.Character then
                pcall(function() player.Character:SetAttribute("Stamina", 100) end)
            end
        end)
    end)
    task.spawn(function()
        local Lighting = game:GetService("Lighting")
        RunService.Heartbeat:Connect(function()
            Lighting.ClockTime = 12
        end)
    end)
    local AskServerToSetSubStateRemoteFunction = ReplicatedStorage:WaitForChild('AskServerToSetSubStateRemoteFunction')
    local blockChangeSubState = false
    local function SetClientSubStateChangesEnabled(enabled)
        blockChangeSubState = not enabled
    end
    local function ChangeCharacterSubState(state)
        task.spawn(AskServerToSetSubStateRemoteFunction.InvokeServer, AskServerToSetSubStateRemoteFunction, state)
    end
    local Utils        = require(ReplicatedStorage:WaitForChild('AnimalGameFrameworkShared'):WaitForChild('Utils'))
    local AnimalConfig = require(ReplicatedStorage.Shared.AnimalConfig)
    local function CanStartEatDrink(p94, p95)
        if not p94 then return end
        if p94:GetAttribute('IsCarrying') then return end
        if not p95 and p94:GetAttribute('MovementDisabled') then return end
        if not p94:FindFirstChild('Head') then return end
        local v96 = p94:GetAttribute('AnimalType')
        local v97 = p94:GetAttribute('AnimalName')
        if not (v96 and v97 and p94:GetAttribute('AnimalAge')) then
            warn("Not spawned as animal, so we can't check eat/drink")
            return
        end
        local v98 = AnimalConfig[v96][v97]
        local v99 = Utils.CanEatDrink.DetectMeatGrassWater(p94, v98)
        return v98.EnableLeavesEating and Utils.DetectLeaves(p94)
            or (v98.EnableInsectEating and Utils.DetectInsects(p94) or v99)
    end
    local LerpTween = {}
    do
        function LerpTween:TweenPartCFrame(part, goalCFrame, duration, onComplete)
            duration = math.max(duration or 1, 0.03)
            assert(part and part:IsA('BasePart'))
            assert(goalCFrame and typeof(goalCFrame) == 'CFrame')
            local startCFrame = part.CFrame
            local startTime   = tick()
            local connection
            connection = RunService.PreRender:Connect(function()
                if not part or not part.Parent then connection:Disconnect() return end
                local alpha = math.min((tick() - startTime) / duration, 1)
                part.CFrame = startCFrame:lerp(goalCFrame, alpha)
                if alpha >= 1 then
                    connection:Disconnect()
                    part.CFrame = goalCFrame
                    if onComplete then onComplete() end
                end
            end)
            return connection
        end
    end
    local Animal = (function()
        local player         = Players.LocalPlayer
        local groundDirection = Vector3.new(0, -100, 0)
        local function RaycastAnimalGround()
            if not player.Character then return nil end
            local origin = player.Character:GetPivot().Position
            return workspace:Raycast(origin, groundDirection)
        end
        local A = {basicAttackCooldown=0.6, specialAttackCooldown=1.9}
        local AttackHandlerRemoteEvent = ReplicatedStorage.AttackHandlerRemoteEvent
        local SpecialAttackRemoteEvent = ReplicatedStorage.SpecialAttackRemoteEvent_RegularAttack
        function A.BasicAttack(h)
            AttackHandlerRemoteEvent:FireServer(h)
            if not player.Character then return end
            player.Character:SetAttribute('LastBasicAttack', tick())
        end
        function A.SpecialAttack(h)
            SpecialAttackRemoteEvent:FireServer(h)
            if not player.Character then return end
            player.Character:SetAttribute('LastSpecialAttack', tick())
        end
        function A.IsBasicAttackOnCooldown()
            if not player.Character then return false end
            local last = player.Character:GetAttribute('LastBasicAttack')
            return last and tick() - last < A.basicAttackCooldown
        end
        function A.IsSpecialAttackOnCooldown()
            if not player.Character then return false end
            local last = player.Character:GetAttribute('LastSpecialAttack')
            return last and tick() - last < A.specialAttackCooldown
        end
        function A.IsOnGrass()
            local r = RaycastAnimalGround()
            return r and r.Material == Enum.Material.Grass
        end
        function A.IsOnWater()
            local r = RaycastAnimalGround()
            return r and r.Material == Enum.Material.Water
        end
        local terrainCellSize = Vector3.new(4,4,4)
        function A.IsInsideTerrain()
            local character = player.Character
            if not character then return false end
            local root = character:FindFirstChild("HumanoidRootPart")
            if not root then return false end
            local position = root.Position
            if position.Magnitude == 0 then return false end
            local ok, result = pcall(function()
                local region = Region3.new(position, position + terrainCellSize):ExpandToGrid(4)
                local _, occupancies = workspace.Terrain:ReadVoxels(region, 4)
                return occupancies[1][1][1] > 0
            end)
            if not ok then return false end
            return result
        end
        local maxStudsPerSecond  = 80
        local activeTweenConnection, activeTweenPart
        local function cancelActiveTween(zeroVelocity)
            if activeTweenConnection then activeTweenConnection:Disconnect() activeTweenConnection = nil end
            if zeroVelocity and activeTweenPart and activeTweenPart.Parent then
                activeTweenPart.AssemblyLinearVelocity  = Vector3.zero
                activeTweenPart.AssemblyAngularVelocity = Vector3.zero
            end
            activeTweenPart = nil
            shared._animalTweening = false
        end
        function A.CancelTween(z) cancelActiveTween(z) end
        function A.IsTweening() return activeTweenConnection ~= nil end
        function A.TweenTo(cframe)
            local character = player.Character
            if not character then return end
            local root = character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local duration = (cframe.Position - root.Position).Magnitude / maxStudsPerSecond
            cancelActiveTween(true)
            local connection
            connection = LerpTween:TweenPartCFrame(root, cframe, duration, function()
                if activeTweenConnection == connection then
                    activeTweenConnection = nil; activeTweenPart = nil; shared._animalTweening = false
                end
            end)
            activeTweenConnection = connection; activeTweenPart = root; shared._animalTweening = true
            return duration
        end
        function A.TweenToAsync(cframe)
            local d = A.TweenTo(cframe)
            if d then task.wait(d) end
        end
        return A
    end)()
    local SegmentCircle = {}
    function SegmentCircle.GenerateCirclePoints(center, radius, resolution)
        local circumference = 2 * math.pi * radius
        local numPoints     = math.max(3, math.floor(circumference / resolution))
        local angleStep     = (2 * math.pi) / numPoints
        local points        = {}
        for i = 0, numPoints - 1 do
            local angle = i * angleStep
            table.insert(points, Vector3.new(
                center.X + radius * math.cos(angle),
                center.Y,
                center.Z + radius * math.sin(angle)))
        end
        return points, numPoints
    end
    local grassResolution   = 4
    local grassHeightOffset = Vector3.new(0, 40, 0)
    local grassRayDirection = Vector3.new(0, -80, 0)
    local Grass             = Enum.Material.Grass
    local grassRayParams    = RaycastParams.new()
    grassRayParams.FilterType                   = Enum.RaycastFilterType.Include
    grassRayParams.FilterDescendantsInstances   = {workspace.Terrain}
    local grassStartingRadius = 6
    local grassMaxRadius      = grassStartingRadius * 8
    local function FindNearestGrass(at, radius)
        local points = SegmentCircle.GenerateCirclePoints(at + grassHeightOffset, radius, grassResolution)
        for _, v in points do
            local result = workspace:Raycast(v, grassRayDirection, grassRayParams)
            if result and result.Material == Grass then return result.Position end
        end
        if radius == grassMaxRadius then return end
        return FindNearestGrass(at, radius * 2)
    end
    local waterResolution   = 12
    local waterHeightOffset = Vector3.new(0, 80, 0)
    local waterRayDirection = Vector3.new(0, -160, 0)
    local Water             = Enum.Material.Water
    local waterRayParams    = RaycastParams.new()
    waterRayParams.FilterType                   = Enum.RaycastFilterType.Include
    waterRayParams.FilterDescendantsInstances   = {workspace.Terrain}
    local waterStartingRadius = 12
    local waterMaxRadius      = 384
    local function FindNearestWaterShore(at, radius)
        local points = SegmentCircle.GenerateCirclePoints(at + waterHeightOffset, radius, waterResolution)
        local bestPosition, bestDistance = nil, math.huge
        for _, v in points do
            local result = workspace:Raycast(v, waterRayDirection, waterRayParams)
            if result and result.Material == Water then
                local flatDir  = Vector3.new(result.Position.X - at.X, 0, result.Position.Z - at.Z)
                local flatDist = flatDir.Magnitude
                local shore    = result.Position
                if flatDist > 0 then shore = result.Position - flatDir.Unit * math.min(2, flatDist) end
                if flatDist < bestDistance then bestDistance = flatDist; bestPosition = shore end
            end
        end
        if bestPosition then return bestPosition end
        if radius >= waterMaxRadius then return end
        return FindNearestWaterShore(at, math.min(radius * 2, waterMaxRadius))
    end
    local function getWaterVerticalGoal(rootPosition)
        local waterPart = workspace:FindFirstChild("MainWaterPart")
        if waterPart and waterPart:IsA("BasePart") then
            return CFrame.new(rootPosition.X, waterPart.Position.Y + 0.5, rootPosition.Z)
        end
        local wp = FindNearestWaterShore(rootPosition, waterStartingRadius)
        if wp then return CFrame.new(rootPosition.X, wp.Y + 0.5, rootPosition.Z) end
    end
    local CARNIVORES = {Lion=true,Tiger=true,Cheetah=true,Crocodile=true,Leopard=true,["T-Rex"]=true,TRex=true}
    local function findEatRemote()
        local names = {
            "StartEatingCarcassesRemotEvent","StartEatingCarcassRemoteEvent",
            "EatCarcassRemoteEvent","CarcassEatRemoteEvent","StartEatingDeadAnimalRemoteEvent",
        }
        for _, name in names do
            local r = ReplicatedStorage:FindFirstChild(name, true)
            if r then return r end
        end
        return nil
    end
    local function findCarcassStorage()
        local candidates = {
            "CarcassesStorageModel","CarcassStorage","Carcasses",
            "DeadAnimals","DeadAnimalStorage","CarcassModel",
            "DeadDinosaurs","DinosaurCarcasses","MeatStorage",
        }
        for _, name in candidates do
            local found = workspace:FindFirstChild(name)
            if found then return found end
        end
        for _, child in workspace:GetChildren() do
            if child:IsA("Model") or child:IsA("Folder") then
                for _, desc in child:GetChildren() do
                    if desc:IsA("Model") and desc:FindFirstChild("HumanoidRootPart") then return child end
                end
            end
        end
        for _, desc in workspace:GetDescendants() do
            if desc:IsA("Model") and desc:FindFirstChild("HumanoidRootPart") then
                local n = desc.Name:lower()
                if n:find("carcass") or n:find("dead") or n:find("meat") then return desc.Parent end
            end
        end
        return nil
    end
    local function getCarcassRoot(c)
        return c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart", true)
    end
    local carcassEatBusy = false
    local lastEatEndTime = 0
    local EAT_COOLDOWN   = 6
    local TP_TOLERANCE   = 12
    local subStateRF     = ReplicatedStorage:WaitForChild("AskServerToSetSubStateRemoteFunction", 10)
    local RAGDOLL_STATES = {
        [Enum.HumanoidStateType.Physics]=true,
        [Enum.HumanoidStateType.FallingDown]=true,
        [Enum.HumanoidStateType.Ragdoll]=true,
        [Enum.HumanoidStateType.Freefall]=true,
        [Enum.HumanoidStateType.GettingUp]=true,
    }
    local function ragdollTeleportToPos(character, targetPos, maxAttempts)
        maxAttempts = maxAttempts or 6
        for attempt = 1, maxAttempts do
            local root = character:FindFirstChild("HumanoidRootPart")
            local hum  = character:FindFirstChild("Humanoid")
            if not root or not hum then task.wait(1) continue end
            Animal.CancelTween(true)
            root.Anchored = false
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            for _ = 1, 25 do
                if character:FindFirstChild("HumanoidRootPart") then
                    character:SetPrimaryPartCFrame(CFrame.new(targetPos))
                end
                task.wait()
            end
            task.wait(1)
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            for _ = 1, 10 do character:SetAttribute("MovementDisabled", false) task.wait(0.1) end
            local r = character:FindFirstChild("HumanoidRootPart")
            if r then
                local dist = (r.Position - targetPos).Magnitude
                if dist <= TP_TOLERANCE then return true end
                warn(string.format("[CarcassEat] Too far %.1f studs, retrying", dist))
            end
        end
        warn("[CarcassEat] TP failed after "..maxAttempts.." attempts")
        return false
    end
    local player = Players.LocalPlayer
    local function carcassWhileChecked()
        if carcassEatBusy then return end
        if (tick() - lastEatEndTime) < EAT_COOLDOWN then return end
        if shared._inGrowthReset then return end
        local character = player.Character
        if not character then return end
        local curWater = character:GetAttribute("Water") or 100
        if curWater <= 30 then character:SetAttribute('_drinkingToFull', true) return false end
        local growth = character:GetAttribute("GrowthPercentage") or 0
        if growth >= 1 then return false end
        local animalName = character:GetAttribute("AnimalName") or ""
        if not CARNIVORES[animalName] then return false end
        local food = character:GetAttribute("Food") or 0
        if food >= 100 then return false end
        local eatRemote = findEatRemote()
        if not eatRemote then warn("[CarcassEat] No eat remote found") return false end
        local carcassStorage = findCarcassStorage()
        if not carcassStorage then warn("[CarcassEat] No carcass storage") return false end
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local nearest, nearestDist = nil, math.huge
        local MAX_RANGE = 2500
        for _, c in carcassStorage:GetDescendants() do
            if c:IsA("Model") and c:FindFirstChild("HumanoidRootPart") then
                local r = getCarcassRoot(c)
                if r then
                    local dist = (root.Position - r.Position).Magnitude
                    if dist < nearestDist and dist < MAX_RANGE then nearest = c; nearestDist = dist end
                end
            end
        end
        for _, desc in workspace:GetDescendants() do
            if desc:IsA("Model") and desc:FindFirstChild("HumanoidRootPart") then
                local n = desc.Name:lower()
                if (n:find("carcass") or n:find("dead")) and desc.Parent ~= carcassStorage then
                    local r = getCarcassRoot(desc)
                    if r then
                        local dist = (root.Position - r.Position).Magnitude
                        if dist < nearestDist and dist < MAX_RANGE then nearest = desc; nearestDist = dist end
                    end
                end
            end
        end
        if not nearest then return false end
        local cRoot = getCarcassRoot(nearest)
        if not cRoot then return false end
        carcassEatBusy = true
        shared._inCarcassEat = true
        print("[CarcassEat] Target:", nearest.Name, "| dist:", math.floor(nearestDist), "| food:", food)
        character:SetAttribute('_drinkingToFull', false)
        Animal.CancelTween(true)
        local standPos = Vector3.new(cRoot.Position.X, cRoot.Position.Y + 2, cRoot.Position.Z)
        ragdollTeleportToPos(character, standPos)
        task.wait(0.4)
        local anchorRoot = character:FindFirstChild("HumanoidRootPart")
        if anchorRoot then anchorRoot.Anchored = true end
        local hum = character:FindFirstChild("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) task.wait(0.2) end
        SetClientSubStateChangesEnabled(false)
        pcall(function() subStateRF:InvokeServer("Eating") end)
        task.wait(0.3)
        pcall(function() eatRemote:FireServer(nearest) end)
        local startFood     = character:GetAttribute("Food") or 0
        local anchorReleased = false
        local foodRose       = false
        local releaseDeadline = tick() + 5
        while not anchorReleased do
            task.wait(0.15)
            local curChar = player.Character
            if not curChar or curChar ~= character then break end
            local curHum  = curChar:FindFirstChildOfClass("Humanoid")
            local curFood = curChar:GetAttribute("Food") or 0
            if curFood > startFood then foodRose = true end
            pcall(function() eatRemote:FireServer(nearest) end)
            if curHum and RAGDOLL_STATES[curHum:GetState()] then curHum:ChangeState(Enum.HumanoidStateType.GettingUp) end
            if curHum and foodRose and not RAGDOLL_STATES[curHum:GetState()] then
                local relRoot = curChar:FindFirstChild("HumanoidRootPart")
                if relRoot then
                    Animal.CancelTween(true)
                    relRoot.AssemblyLinearVelocity  = Vector3.zero
                    relRoot.AssemblyAngularVelocity = Vector3.zero
                    relRoot.Anchored = false
                end
                anchorReleased = true
            elseif tick() > releaseDeadline then
                local relRoot = curChar:FindFirstChild("HumanoidRootPart")
                if relRoot then
                    Animal.CancelTween(true)
                    relRoot.AssemblyLinearVelocity  = Vector3.zero
                    relRoot.AssemblyAngularVelocity = Vector3.zero
                    relRoot.Anchored = false
                end
                anchorReleased = true
                warn("[CarcassEat] Safety anchor release")
            end
        end
        local lastFood2  = character:GetAttribute("Food") or 0
        local stallTicks = 0
        local MAX_STALL  = 6
        while true do
            task.wait(0.5)
            local curChar = player.Character
            if not curChar or curChar ~= character then break end
            local curFood = curChar:GetAttribute("Food") or 0
            if curFood >= 100 then print("[CarcassEat] Full") break end
            if curFood > lastFood2 then
                lastFood2 = curFood; stallTicks = 0
                pcall(function() eatRemote:FireServer(nearest) end)
            else
                stallTicks = stallTicks + 1
                if stallTicks >= MAX_STALL then print("[CarcassEat] Stalled at", curFood) break end
            end
            if not nearest.Parent then print("[CarcassEat] Carcass gone") break end
        end
        SetClientSubStateChangesEnabled(true)
        task.wait(0.5)
        local safetyRoot = character:FindFirstChild("HumanoidRootPart")
        if safetyRoot and safetyRoot.Anchored then
            Animal.CancelTween(true)
            safetyRoot.AssemblyLinearVelocity  = Vector3.zero
            safetyRoot.AssemblyAngularVelocity = Vector3.zero
            safetyRoot.Anchored = false
        end
        if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
        for _ = 1, 5 do character:SetAttribute("MovementDisabled", false) task.wait(0.1) end
        shared._inCarcassEat = false
        lastEatEndTime       = tick()
        carcassEatBusy       = false
    end
    local lastDrinkMoveAt     = 0
    local DRINK_MOVE_COOLDOWN = 4
    local eatDrinkBusy        = false
    task.spawn(function()
        while true do
            task.wait()
            if not autoEatChecked() then continue end
            if eatDrinkBusy then continue end
            local character = player.Character
            if not character then continue end
            if shared._inGrowthReset then continue end
            if shared._inCarcassEat  then continue end
            local animalName = character:GetAttribute("AnimalName") or ""
            if CARNIVORES[animalName] then continue end
            if character:GetAttribute('_drinkingToFull') then continue end
            if (character:GetAttribute('Food') or 0) > 100 then continue end
            local ingestionAvaliable = CanStartEatDrink(character)
            if ingestionAvaliable == 'Eat' then
                SetClientSubStateChangesEnabled(false)
                ChangeCharacterSubState('Eating')
            elseif goToNearestSource() then
                local root = character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                if Animal.IsTweening() then task.wait(0.5) continue end
                local grassPosition = FindNearestGrass(root.Position, grassStartingRadius)
                if not grassPosition then task.wait(0.5) continue end
                local dist = (root.Position - grassPosition).Magnitude
                if dist < 3 then task.wait(1) continue end
                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid then continue end
                local goalPosition = grassPosition + Vector3.new(0, humanoid.HipHeight, 0)
                local direction    = goalPosition - root.Position
                local travelTime = math.max(dist / 24, 0.5)
                Animal.TweenTo(CFrame.lookAlong(goalPosition - direction.Unit, direction))
                task.wait(travelTime + 1.5)
                local ing = CanStartEatDrink(character)
                if ing == 'Eat' then
                    SetClientSubStateChangesEnabled(false)
                    ChangeCharacterSubState('Eating')
                    task.wait(1)
                end
            end
        end
    end)
    task.spawn(function()
        while true do
            task.wait()
            if not autoEatCarcassChecked() then continue end
            carcassWhileChecked()
        end
    end)
    task.spawn(function()
        local DRINK_TIMEOUT = 20
        while true do
            task.wait(0.1)
            if not autoDrinkChecked() then
                eatDrinkBusy = false
                continue
            end
            local character = player.Character
            if not character then eatDrinkBusy = false continue end
            if shared._inGrowthReset then character:SetAttribute('_drinkingToFull', false) eatDrinkBusy = false continue end
            if shared._inCarcassEat  then character:SetAttribute('_drinkingToFull', false) eatDrinkBusy = false continue end
            local growth = character:GetAttribute("GrowthPercentage") or 0
            if shared._parkingModeActive then
                character:SetAttribute('_drinkingToFull', false)
                eatDrinkBusy = false
                local killRoot = character:FindFirstChild("HumanoidRootPart")
                if killRoot and killRoot.Anchored then
                    killRoot.Anchored                = false
                    killRoot.AssemblyLinearVelocity  = Vector3.zero
                    killRoot.AssemblyAngularVelocity = Vector3.zero
                end
                continue
            end
            if growth >= 1 then
                character:SetAttribute('_drinkingToFull', false)
                eatDrinkBusy = false
                continue
            end
            local water = character:GetAttribute('Water') or 0
            if water < 100 then
                character:SetAttribute('_drinkingToFull', true)
            end
            if water >= 100 then
                if not character:GetAttribute('_drinkingToFull') then continue end
                character:SetAttribute('_drinkingToFull', false)
                SetClientSubStateChangesEnabled(true)
                Animal.CancelTween(true)
                local root = character:FindFirstChild("HumanoidRootPart")
                local hum  = character:FindFirstChild("Humanoid")
                if root then
                    root.Anchored = false
                    root.AssemblyLinearVelocity  = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end
                if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
                eatDrinkBusy = false
                continue
            end
            if not character:GetAttribute('_drinkingToFull') then continue end
            if eatDrinkBusy then continue end
            local ingestionAvaliable = CanStartEatDrink(character, true)
            if ingestionAvaliable == 'Eat' then ingestionAvaliable = nil end
            if ingestionAvaliable == 'Drink' then
                Animal.CancelTween(true)
                SetClientSubStateChangesEnabled(false)
                ChangeCharacterSubState('Drinking')
            elseif goToNearestSource() then
                local root     = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                if not root then continue end
                if root.Anchored then root.Anchored = false task.wait(0.1) end
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
                local waterGoal = getWaterVerticalGoal(root.Position)
                if not waterGoal then continue end
                local liftedGoal = CFrame.new(waterGoal.Position.X, waterGoal.Position.Y + 0.5, waterGoal.Position.Z)
                local dist = (liftedGoal.Position - root.Position).Magnitude
                if dist > 4 and tick() - lastDrinkMoveAt >= DRINK_MOVE_COOLDOWN then
                    lastDrinkMoveAt = tick()
                    eatDrinkBusy    = true
                    local ok, err = pcall(function()
                        root.Anchored = true
                        for _ = 1, 20 do
                            if not character or not character.Parent then return end
                            if character:FindFirstChild("HumanoidRootPart") then
                                character:SetPrimaryPartCFrame(liftedGoal)
                            end
                            task.wait()
                        end
                        local holdDeadline = tick() + DRINK_TIMEOUT
                        while tick() < holdDeadline do
                            task.wait(0.2)
                            local ch2 = player.Character
                            if not ch2 or ch2 ~= character then break end
                            local w = ch2:GetAttribute("Water") or 0
                            if w >= 100 then break end
                            local ing = CanStartEatDrink(ch2, true)
                            if ing == "Drink" then
                                SetClientSubStateChangesEnabled(false)
                                ChangeCharacterSubState("Drinking")
                            end
                            local r2 = ch2:FindFirstChild("HumanoidRootPart")
                            if r2 and r2.Anchored then r2.CFrame = liftedGoal end
                        end
                    end)
                    if not ok then warn("[AutoDrink] pcall error:", err) end
                    local r3 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if r3 then
                        r3.AssemblyLinearVelocity  = Vector3.zero
                        r3.AssemblyAngularVelocity = Vector3.zero
                        r3.Anchored = false
                    end
                    local hum2 = player.Character and player.Character:FindFirstChild("Humanoid")
                    if hum2 then hum2:ChangeState(Enum.HumanoidStateType.GettingUp) end
                    SetClientSubStateChangesEnabled(true)
                    task.wait(0.5)
                    eatDrinkBusy = false
                end
            end
        end
    end)
    task.spawn(function()
        local lionTerrainStreak    = 0
        local LION_TERRAIN_REQUIRED = 5
        while true do
            task.wait()
            if not shared._exitTerrainEnabled then lionTerrainStreak = 0 continue end
            local character = player.Character
            if not character then continue end
            local root = character:FindFirstChild("HumanoidRootPart")
            if not root then continue end
            if shared._animalTweening then lionTerrainStreak = 0 continue end
            local animalName     = character:GetAttribute("AnimalName") or ""
            local isLionOrTiger  = (animalName == "Lion" or animalName == "Tiger")
            if Animal.IsInsideTerrain() then
                if isLionOrTiger then
                    lionTerrainStreak = lionTerrainStreak + 1
                    if lionTerrainStreak < LION_TERRAIN_REQUIRED then continue end
                    lionTerrainStreak = 0
                    root.CFrame = CFrame.new(root.Position + Vector3.new(0, 8, 0))
                else
                    lionTerrainStreak = 0
                    root.CFrame = CFrame.new(root.Position + Vector3.new(0, 4, 0))
                end
            else
                lionTerrainStreak = 0
            end
        end
    end)
    task.spawn(function()
        local RS      = ReplicatedStorage
        local CoreGui = game:GetService("CoreGui")
        local GAME_CONFIGS = {
            [6174994284] = {
                name="SavannahLife", expectedAnimal="Elephant",
                growSpawn=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                warSpawn=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                safePos=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                dangerY=-100,
                babySpawnArgs={Elephant="Elephant",Lion="Lion",Giraffe="Giraffe",Hippo="Hippo",Rhino="Rhino",Impala="Impala"},
            },
            [18214855317] = {
                name="SavannahLife", expectedAnimal="Elephant",
                growSpawn=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                warSpawn=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                safePos=Vector3.new(-6320.87890625,3.2288663387298584,3982.267333984375),
                dangerY=-100,
                babySpawnArgs={Elephant="Elephant",Lion="Lion",Giraffe="Giraffe",Hippo="Hippo",Rhino="Rhino",Impala="Impala"},
            },
            [9237322219] = {
                name="JungleLife", expectedAnimal="Gorilla",
                growSpawn=Vector3.new(1166.835,24.751,-358.321),
                warSpawn=Vector3.new(1166.835,24.751,-358.321),
                safePos=Vector3.new(1166.835,24.751,-358.321),
                dangerY=-100, babySpawnArgs={Gorilla="Gorilla"},
            },
            [75541741887441] = {
                name="DinosaurLife", expectedAnimal="T-Rex",
                growSpawn=Vector3.new(-26.318,59.041,190.665),
                warSpawn=Vector3.new(-26.318,59.041,190.665),
                safePos=Vector3.new(-26.318,59.041,190.665),
                dangerY=-100, babySpawnArgs={["T-Rex"]="T-Rex",TRex="TRex"},
            },
        }
        local function detectConfigByAnimal()
            local deadline = tick() + 15
            while tick() < deadline do
                local ch = player.Character
                if ch then
                    local animal = ch:GetAttribute("AnimalName")
                    if animal and animal ~= "" then
                        local JUNGLE   = {Gorilla=true,Chimpanzee=true,Leopard=true,Mandrill=true}
                        local SAVANNAH = {Elephant=true,Lion=true,Giraffe=true,Hippo=true,Rhino=true,Impala=true,Zebra=true,Cheetah=true,Hyena=true,Wildbeest=true}
                        local DINO     = {["T-Rex"]=true,TRex=true}
                        if JUNGLE[animal]   then return GAME_CONFIGS[9237322219] end
                        if SAVANNAH[animal] then return GAME_CONFIGS[18214855317] end
                        if DINO[animal]     then return GAME_CONFIGS[75541741887441] end
                        warn("[GrowthLoop] Unknown animal: "..tostring(animal))
                        return nil
                    end
                end
                task.wait(0.5)
            end
            warn("[GrowthLoop] Animal-detection timed out")
            return nil
        end
        local gameConfig = GAME_CONFIGS[game.GameId]
        if not gameConfig then
            warn("[GrowthLoop] GameId not recognised, detecting by animal")
            gameConfig = detectConfigByAnimal()
            if not gameConfig then
                warn("[GrowthLoop] Detection failed, defaulting to SavannahLife")
                gameConfig = GAME_CONFIGS[18214855317]
            end
        end
        shared._growthGameName = gameConfig.name
        print("[GrowthLoop] Detected game: "..gameConfig.name)
        local growNewSlots      = false
        local growExistingSlots = false
        local MAX_SLOTS              = 40
        local slotsGrownThisCycle    = 0
        local allExistingGrown       = false
        local parkingMode            = false
        shared._parkingModeActive    = false
        local function setParkingModeState(state)
            parkingMode = state
            shared._parkingModeActive = state
        end
        shared._setGrowNewSlots = function(state)
            growNewSlots = state
            print("[GrowthLoop] Grow new slots:", state)
        end
        shared._setGrowExistingSlots = function(state)
            growExistingSlots = state
            print("[GrowthLoop] Grow existing slots:", state)
        end
        local pendingParkMode = false
        shared._setParkingMode = function(state)
            setParkingModeState(state)
            if not state then shared._autoParkedBy40 = false end
            print("[GrowthLoop] Parking mode:", state)
            if state then
                pendingParkMode = true
                if shared._runParkingMode then pendingParkMode = false task.spawn(shared._runParkingMode) end
            else
                pendingParkMode = false
            end
        end
        local existingSlots     = {}
        local originalSlotCount = 0
        local trackedSlots      = {}
        local trackedSlotLookup = {}
        local existingSlotIndex = 1
        local function findSlotIndexByName(name, pool)
            if not name then return nil end
            pool = pool or trackedSlots
            for i, v in ipairs(pool) do if v == name then return i end end
            return nil
        end
        local function getTrackedSlotTotal() return math.min(#trackedSlots, MAX_SLOTS) end
        local function trackSlotName(name)
            if not name then return false end
            if trackedSlotLookup[name] then return false end
            if #trackedSlots >= MAX_SLOTS then warn("[GrowthLoop] Tracked slot list at max, skipping:", name) return false end
            table.insert(trackedSlots, name)
            trackedSlotLookup[name] = true
            return true
        end
        local getUniqueName
        local removeName
        do
            local ALLOWED_EXISTING_ANIMALS_BY_GAME = {
                SavannahLife = {Elephant=true,Lion=true,Giraffe=true,Hippo=true,Rhino=true,Impala=true,Zebra=true,Cheetah=true,Hyena=true,Wildbeest=true},
                JungleLife   = {Gorilla=true,Chimpanzee=true,Leopard=true,Mandrill=true,Tiger=true,Lion=true},
                DinosaurLife = {["T-Rex"]=true},
            }
            local savedSlotRecords              = {}
            local lastSavedCharacterRefresh     = 0
            local SAVE_REFRESH_INTERVAL         = 1
            local warnedMissingSavedCharactersAPI  = false
            local warnedSavedCharactersReadFailed  = false
            existingSlots = {}; originalSlotCount = 0; trackedSlots = {}; trackedSlotLookup = {}; existingSlotIndex = 1
            local function isPlayerDataReplication(candidate)
                return type(candidate) == "table" and type(candidate.GetKeyData) == "function"
            end
            local function resolvePlayerDataReplication()
                local cached = shared._playerDataReplication
                if isPlayerDataReplication(cached) then return cached end
                local directCandidates = {shared.PlayerDataReplication, _G.PlayerDataReplication}
                if type(getgenv) == "function" then
                    local ok, env = pcall(getgenv)
                    if ok and type(env) == "table" then table.insert(directCandidates, env.PlayerDataReplication) end
                end
                for _, candidate in ipairs(directCandidates) do
                    if isPlayerDataReplication(candidate) then shared._playerDataReplication = candidate return candidate end
                end
                local searchRoots = {RS, player:FindFirstChild("PlayerScripts"), player:FindFirstChild("PlayerGui")}
                for _, searchRoot in ipairs(searchRoots) do
                    if searchRoot then
                        local moduleScript = searchRoot:FindFirstChild("PlayerDataReplication", true)
                        if moduleScript and moduleScript:IsA("ModuleScript") then
                            local ok, result = pcall(require, moduleScript)
                            if ok and isPlayerDataReplication(result) then shared._playerDataReplication = result return result end
                        end
                    end
                end
                return nil
            end
            local function findSavedCharactersMenu()
                local cached = shared._savedCharactersMenu
                if typeof(cached) == "Instance" and cached.Parent then return cached end
                local playerGui = player:FindFirstChildOfClass("PlayerGui")
                local menu = (playerGui and playerGui:FindFirstChild("SavedCharactersMenu", true))
                    or CoreGui:FindFirstChild("SavedCharactersMenu", true)
                if menu then shared._savedCharactersMenu = menu end
                return menu
            end
            local function setSelectedSavedCharacterName(name)
                if type(name) ~= "string" or name == "" then return end
                local menu = findSavedCharactersMenu()
                if menu then pcall(function() menu:SetAttribute("UniqueCharacterName", name) end) end
            end
            local function rebuildTrackedFromRecords(records)
                trackedSlots = {}; trackedSlotLookup = {}
                for _, entry in ipairs(records) do
                    local name = entry.CharacterName
                    if type(name) == "string" and name ~= "" and not trackedSlotLookup[name] then
                        table.insert(trackedSlots, name)
                        trackedSlotLookup[name] = true
                    end
                end
            end
            local function syncSavedCharacterRecords(force)
                local now = tick()
                if not force and (now - lastSavedCharacterRefresh) < SAVE_REFRESH_INTERVAL then return savedSlotRecords end
                lastSavedCharacterRefresh = now
                local replication = resolvePlayerDataReplication()
                if not replication then
                    if not warnedMissingSavedCharactersAPI then warnedMissingSavedCharactersAPI = true warn("[GrowthLoop] PlayerDataReplication not found") end
                    return savedSlotRecords
                end
                local ok, rawList = pcall(function() return replication.GetKeyData("SavedCharacters") end)
                if not ok or type(rawList) ~= "table" then
                    if not warnedSavedCharactersReadFailed then warnedSavedCharactersReadFailed = true warn("[GrowthLoop] Failed to read SavedCharacters") end
                    return savedSlotRecords
                end
                warnedSavedCharactersReadFailed = false
                local allowedAnimals = ALLOWED_EXISTING_ANIMALS_BY_GAME[gameConfig.name]
                local nextRecords = {}; local nextNames = {}; local seen = {}
                for _, entry in ipairs(rawList) do
                    if type(entry) == "table" then
                        local charName   = entry.CharacterName
                        local animalName = entry.AnimalName
                        if type(charName) == "string" and charName ~= ""
                            and type(animalName) == "string" and animalName ~= ""
                            and (not allowedAnimals or allowedAnimals[animalName])
                            and not seen[charName]
                        then
                            table.insert(nextRecords, entry)
                            table.insert(nextNames, charName)
                            seen[charName] = true
                            if #nextRecords >= MAX_SLOTS then break end
                        end
                    end
                end
                savedSlotRecords = nextRecords
                existingSlots    = nextNames
                rebuildTrackedFromRecords(nextRecords)
                if #existingSlots == 0 or existingSlotIndex > #existingSlots then existingSlotIndex = 1 end
                if originalSlotCount == 0 and #existingSlots > 0 then originalSlotCount = #existingSlots end
                return savedSlotRecords
            end
            local function findSavedCharacterRecordByName(name, records)
                if type(name) ~= "string" or name == "" then return nil end
                records = records or syncSavedCharacterRecords()
                for _, entry in ipairs(records) do if entry.CharacterName == name then return entry end end
                return nil
            end
            local function getFirstExistingSlotRecord()
                local records = syncSavedCharacterRecords(true)
                return records[1]
            end
            local function getNextExistingSlotRecord()
                local records = syncSavedCharacterRecords(true)
                if #records == 0 then return nil, nil, 0 end
                local idx
                local currentIdx = findSlotIndexByName(shared._currentGrowthName, existingSlots)
                if currentIdx then idx = (currentIdx % #records) + 1
                else
                    if existingSlotIndex < 1 or existingSlotIndex > #records then existingSlotIndex = 1 end
                    idx = existingSlotIndex
                end
                local entry = records[idx]
                existingSlotIndex = (idx % #records) + 1
                return entry, idx, #records
            end
            local function sanitizeNameSeed(text)
                text = tostring(text or ""):gsub("[^%w]+", "")
                if text == "" then text = "Slot" end
                return string.sub(text, 1, 18)
            end
            local newSlotNamePool = {
                "Jack","John","Evian","Aiman","Adam","Alex","Ben","Sam","Max","Leo",
                "Noah","Liam","Omar","Zain","Ali","Ryan","Ethan","Mason","Dylan","Lucas",
                "Harry","Jacob","Henry","Isaac","Yusuf","Amir","Rehan","Arman","Daniel","David",
                "Aaron","Oscar","Toby","Kian","Kai","Jay","Sean","Chris","Kevin","Mark",
            }
            getUniqueName = function(animal)
                local usedNames = {}
                for _, entry in ipairs(syncSavedCharacterRecords(true)) do
                    if type(entry.CharacterName) == "string" and entry.CharacterName ~= "" then
                        usedNames[entry.CharacterName] = true
                    end
                end
                if animal == "Tiger" or animal == "Elephant" then
                    for _, candidate in ipairs(newSlotNamePool) do
                        if not usedNames[candidate] then return candidate end
                    end
                end
                local base = sanitizeNameSeed(shared._currentGrowthName or animal or gameConfig.expectedAnimal or "Slot")
                for i = 1, 999 do
                    local candidate = string.format("%s%d", base, i)
                    if not usedNames[candidate] then return candidate end
                end
                return string.format("%s%d", base, math.floor(os.clock() * 1000))
            end
            removeName = function(name) return nil end
            shared._syncSavedCharacterRecords      = syncSavedCharacterRecords
            shared._findSavedCharacterRecordByName = findSavedCharacterRecordByName
            shared._getFirstExistingSlotRecord     = getFirstExistingSlotRecord
            shared._getNextExistingSlotRecord      = getNextExistingSlotRecord
            shared._setSelectedSavedCharacterName  = setSelectedSavedCharacterName
            syncSavedCharacterRecords(true)
            if originalSlotCount == 0 then warn("[GrowthLoop] WARNING: No valid slots found for", gameConfig.name) end
        end
        local isLooping = false
        local loopToken = 0
        local function forceUnlockGrowthLoop(reason)
            loopToken = loopToken + 1
            isLooping = false
            shared._inGrowthReset = false
            warn("[GrowthLoop] Force-unlocked: "..tostring(reason))
        end
        local function withLock(fn)
            if isLooping then return false end
            isLooping = true; loopToken = loopToken + 1
            local myToken = loopToken
            shared._inGrowthReset = true
            local ok, err = pcall(fn)
            if loopToken == myToken then shared._inGrowthReset = false; isLooping = false end
            if not ok then warn("[GrowthLoop] Error:", err) end
            return ok
        end
        local currentGrowthName = nil
        shared._currentGrowthName = nil
        local currentAnimalName = nil
        local currentGender     = nil
        local currentSkin       = nil
        local function waitForAttribute(character, attrName, timeout)
            timeout = timeout or 10
            local waited = 0
            while waited < timeout do
                local val = character:GetAttribute(attrName)
                if val ~= nil then return val end
                task.wait(0.2); waited = waited + 0.2
            end
            return nil
        end
        local function getSlotInfo(character)
            local animal = character:GetAttribute("AnimalName") or currentAnimalName or "Elephant"
            local gender = character:GetAttribute("Gender")     or currentGender or "Female"
            local skin   = character:GetAttribute("Skin")       or currentSkin or "Default"
            return animal, gender, skin
        end
        local function extractMotherName(result)
            if type(result) == "string" and result ~= "" then return result end
            if type(result) ~= "table" then return nil end
            for _, value in ipairs(result) do
                if type(value) == "string" and value ~= "" then return value end
                if type(value) == "table" then
                    local name = value.PlayerName or value.Name or value.DisplayName or value.UserName or value.Username
                    if type(name) == "string" and name ~= "" then return name end
                end
            end
            for _, value in pairs(result) do
                if type(value) == "string" and value ~= "" then return value end
                if type(value) == "table" then
                    local name = value.PlayerName or value.Name or value.DisplayName or value.UserName or value.Username
                    if type(name) == "string" and name ~= "" then return name end
                end
            end
            return nil
        end
        local function isBabySavedCharacter(entry)
            if type(entry) ~= "table" then return false end
            local growth = entry.GrowthPercentage
            return type(growth) == "number" and growth <= 0.01
        end
        local function requestBabyMotherName(entry)
            local remote = RS:FindFirstChild("BabySpawnsRequestMotherNamesRemoteFunction")
            if not remote or type(entry) ~= "table" then return nil end
            local animal = entry.AnimalName
            if type(animal) ~= "string" or animal == "" then return nil end
            local requestArg = gameConfig.babySpawnArgs[animal] or animal
            local ok, result = pcall(function() return remote:InvokeServer(requestArg) end)
            if not ok then warn("[GrowthLoop] Baby mother request failed for:", animal) return nil end
            local motherName = extractMotherName(result)
            if motherName then print("[GrowthLoop] Baby mother:", motherName) end
            return motherName
        end
        local function trackCurrentCharacter()
            local character = player.Character
            if not character then return end
            local name = waitForAttribute(character, "CharacterName", 8)
            if name then
                currentGrowthName = name
                shared._currentGrowthName = name
                trackSlotName(name)
                currentAnimalName, currentGender, currentSkin = getSlotInfo(character)
                print("[GrowthLoop] Now tracking:", currentGrowthName, "| Animal:", currentAnimalName, "| Gender:", currentGender)
            else
                warn("[GrowthLoop] Timed out waiting for CharacterName")
            end
        end
        local function spawnAndSetup(slotEntryOrName)
            local syncSavedCharacterRecords      = shared._syncSavedCharacterRecords
            local findSavedCharacterRecordByName = shared._findSavedCharacterRecordByName
            local setSelectedSavedCharacterName  = shared._setSelectedSavedCharacterName
            local entry    = slotEntryOrName
            local charName
            if type(slotEntryOrName) == "table" then charName = slotEntryOrName.CharacterName
            else
                charName = slotEntryOrName
                if type(findSavedCharacterRecordByName) == "function" then
                    local records = type(syncSavedCharacterRecords) == "function" and syncSavedCharacterRecords(true) or nil
                    entry = findSavedCharacterRecordByName(charName, records)
                end
            end
            if type(charName) ~= "string" or charName == "" then warn("[GrowthLoop] spawnAndSetup called without valid CharacterName") return false end
            if type(entry) ~= "table" then entry = {CharacterName = charName} end
            if type(setSelectedSavedCharacterName) == "function" then setSelectedSavedCharacterName(charName) end
            local motherName = isBabySavedCharacter(entry) and requestBabyMotherName(entry) or nil
            local spawnOk, spawnErr = pcall(function()
                if motherName then RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName, motherName)
                else RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName) end
            end)
            if not spawnOk then warn("[GrowthLoop] SpawnAsCharacter failed:", spawnErr) return false end
            local waited = 0; local spawned = false
            while waited < 10 do
                task.wait(0.2); waited = waited + 0.2
                local ch = player.Character
                if ch and ch:FindFirstChild("HumanoidRootPart") then spawned = true break end
            end
            if not spawned then warn("[GrowthLoop] HumanoidRootPart never appeared for:", charName) return false end
            trackSlotName(charName)
            if type(syncSavedCharacterRecords) == "function" then syncSavedCharacterRecords(true) end
            local FOOD_TYPE_BY_ANIMAL = {Elephant="Grass",Lion="Meat",Giraffe="Grass",Hippo="Grass",Rhino="Grass",Gorilla="Grass",Crocodile="Meat",["T-Rex"]="Meat"}
            local ch       = player.Character
            local animal   = ch and ch:GetAttribute("AnimalName") or "Elephant"
            local foodType = FOOD_TYPE_BY_ANIMAL[animal] or "Grass"
            pcall(function()
                pcall(function() RS.AnimalGameFrameworkShared.Utils.CanEatDrink.SetFoodTypeRemoteEvent:FireServer(foodType) end)
                pcall(function() RS.VegetationEatingRemoteEvent:FireServer() end)
                print("[GrowthLoop] Set food type:", foodType, "for:", animal)
            end)
            task.wait(0.5)
            pcall(function()
                RS.SaveCharacterStatsRemoteEvent:FireServer(charName, "Oxygen", 100)
                RS.SaveCharacterStatsRemoteEvent:FireServer(charName, "Stamina", 100)
            end)
            return true
        end
        local WAR_SPAWN  = gameConfig.warSpawn
        local GROW_SPAWN = gameConfig.growSpawn
        shared._growSpawn = GROW_SPAWN
        local function confirmedTP(character, targetPos, label, maxAttempts)
            maxAttempts = maxAttempts or 6
            for attempt = 1, maxAttempts do
                local root = character:FindFirstChild("HumanoidRootPart")
                local hum  = character:FindFirstChild("Humanoid")
                if not root or not hum then warn("[GrowthLoop] ["..label.."] No root/hum on attempt "..attempt) task.wait(1)
                else
                    root.Anchored = false
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                    for _ = 1, 25 do
                        if character and character:FindFirstChild("HumanoidRootPart") then character:SetPrimaryPartCFrame(CFrame.new(targetPos)) end
                        task.wait()
                    end
                    task.wait(1)
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    for _ = 1, 10 do character:SetAttribute("MovementDisabled", false) task.wait(0.1) end
                    local r = character:FindFirstChild("HumanoidRootPart")
                    if r then
                        local dist = (r.Position - targetPos).Magnitude
                        print(string.format("[GrowthLoop] [%s] TP attempt %d dist: %.1f studs", label, attempt, dist))
                        if dist <= TP_TOLERANCE then print("[GrowthLoop] ["..label.."] TP confirmed") return true
                        else warn("[GrowthLoop] ["..label.."] Too far, retrying") end
                    end
                end
            end
            warn("[GrowthLoop] ["..label.."] Failed after "..maxAttempts.." attempts")
            return false
        end
        local function teleportAndEnable(newChar, charName)
            local charWait = 0
            while charWait < 15 do
                task.wait(0.2); charWait = charWait + 0.2
                local ch = player.Character
                if ch and ch:FindFirstChild("HumanoidRootPart") then
                    local cname = ch:GetAttribute("CharacterName")
                    if cname == charName then newChar = ch break
                    elseif charWait >= 5 and cname ~= nil then warn("[GrowthLoop] Name mismatch") newChar = ch break
                    elseif charWait >= 8 then warn("[GrowthLoop] CharacterName never loaded") newChar = ch break end
                end
            end
            if not newChar then warn("[GrowthLoop] Character never appeared") return end
            task.wait(1.5)
            local ch = player.Character
            if ch then newChar = ch end
            local animal, gender, skin = getSlotInfo(newChar)
            currentAnimalName = animal; currentGender = gender; currentSkin = skin
            print("[GrowthLoop] Slot info Animal:", animal, "| Gender:", gender, "| Skin:", skin)
            confirmedTP(newChar, GROW_SPAWN, "GrowSpawn")
            print("[GrowthLoop] Waiting 7s for character to settle...")
            if shared._autoDrinkChecked then shared._autoDrinkChecked(false) end
            if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end
            if shared._autoEatChecked then shared._autoEatChecked(false) end
            local settleChar = player.Character
            if settleChar then
                settleChar:SetAttribute('_drinkingToFull', false)
                local settleRoot = settleChar:FindFirstChild("HumanoidRootPart")
                if settleRoot then
                    settleRoot.Anchored                = false
                    settleRoot.AssemblyLinearVelocity  = Vector3.zero
                    settleRoot.AssemblyAngularVelocity = Vector3.zero
                end
            end
            task.wait(7)
            local ch2 = player.Character
            local isCarnivore = false
            if ch2 then
                local an = ch2:GetAttribute("AnimalName") or ""
                local CARNIVORES2 = {Lion=true,Tiger=true,Cheetah=true,Crocodile=true,Leopard=true,["T-Rex"]=true}
                isCarnivore = CARNIVORES2[an] == true
            end
            local function toggleEatDrink(state, lbl)
                if not isCarnivore then
                    if shared._autoEatChecked then shared._autoEatChecked(state) end
                else
                    if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(state) end
                end
                if shared._autoDrinkChecked then shared._autoDrinkChecked(state) end
                print("[GrowthLoop] Auto "..(isCarnivore and "carcass/drink" or "eat/drink").." "..lbl)
            end
            toggleEatDrink(false, "OFF (pass 1)"); task.wait(1)
            toggleEatDrink(true,  "ON  (pass 1)"); task.wait(1)
            toggleEatDrink(false, "OFF (pass 2)"); task.wait(1)
            toggleEatDrink(true,  "ON  (pass 2) grow loop active")
        end
        local function teleportToWarSpawn()
            local ch = player.Character
            if not ch then return end
            local root = ch:FindFirstChild("HumanoidRootPart")
            local hum  = ch:FindFirstChild("Humanoid")
            if not root or not hum then return end
            print("[GrowthLoop] 100% grown, teleporting to war spawn")
            confirmedTP(ch, WAR_SPAWN, "WarSpawn")
            print("[GrowthLoop] War spawn TP done")
        end
        local function resetToMenu()
            pcall(function() RS.CustomCharacterResetRemoteFunction:InvokeServer() end)
            task.wait(2)
        end
        local function doGrowthReset()
            withLock(function()
                if shared._autoEatChecked then shared._autoEatChecked(false) end
                if shared._autoDrinkChecked then shared._autoDrinkChecked(false) end
                print("[GrowthLoop] Auto eat/drink OFF, starting growth reset")
                local character  = player.Character
                if not character then return end
                local animalName, gender, skin = getSlotInfo(character)
                local newName    = getUniqueName(animalName)
                print("[GrowthLoop] Full grown! Creating new slot:", newName, "| Animal:", animalName, "| Gender:", gender)
                teleportToWarSpawn()
                resetToMenu()
                local createOk, createErr = pcall(function()
                    RS.CreateNewCharacterRemoteFunction:InvokeServer(newName, animalName, gender, skin)
                end)
                if not createOk then warn("[GrowthLoop] CreateNewCharacter failed:", createErr) removeName(newName) return end
                task.wait(2)
                local spawnOk = spawnAndSetup({CharacterName=newName, AnimalName=animalName, GrowthPercentage=0})
                if not spawnOk then warn("[GrowthLoop] Spawn failed:", newName) removeName(newName) return end
                teleportAndEnable(nil, newName)
                currentGrowthName = newName; shared._currentGrowthName = newName
                currentAnimalName = animalName; currentGender = gender; currentSkin = skin
                local added = trackSlotName(newName)
                print("[GrowthLoop] Now growing:", newName, "| Total slots:", getTrackedSlotTotal(), "| Added:", added)
            end)
        end
        local doExistingSlotCycle
        local doParkOnSlotOne
        doExistingSlotCycle = function()
            withLock(function()
                if shared._autoEatChecked then shared._autoEatChecked(false) end
                if shared._autoDrinkChecked then shared._autoDrinkChecked(false) end
                if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end
                print("[GrowthLoop] Auto eat/drink OFF, starting slot cycle")
                local getNextExistingSlotRecord = shared._getNextExistingSlotRecord
                local entry, idx, total = type(getNextExistingSlotRecord) == "function" and getNextExistingSlotRecord() or nil
                if not entry then warn("[GrowthLoop] [Existing] No valid slots for", gameConfig.name) return end
                local slotName = entry.CharacterName

                if slotName == currentGrowthName then
                    local records = shared._syncSavedCharacterRecords and shared._syncSavedCharacterRecords(true) or {}
                    local skipped = false
                    for _, rec in ipairs(records) do
                        if rec.CharacterName ~= currentGrowthName then
                            local g = rec.GrowthPercentage or 0
                            if g < 1 then
                                entry = rec
                                slotName = rec.CharacterName
                                skipped = true
                                break
                            end
                        end
                    end
                    if not skipped then
                        print("[GrowthLoop] [Existing] All slots are current or 100%, nothing to cycle")
                        return
                    end
                end

                print("[GrowthLoop] [Existing] Moving to slot", idx, "/", total, ":", slotName, "| Animal:", tostring(entry.AnimalName))

                teleportToWarSpawn()
                resetToMenu()
                task.wait(1)

                local spawnOk = spawnAndSetup(entry)
                if not spawnOk then warn("[GrowthLoop] [Existing] Failed to spawn:", slotName) return end
                task.wait(1)

                local ch = player.Character
                if ch then
                    local growth = waitForAttribute(ch, "GrowthPercentage", 8)
                    if growth and growth >= 1 then
                        print("[GrowthLoop] [Existing] Slot", slotName, "already 100%, skipping")
                        return
                    end
                    local animal, gender = getSlotInfo(ch)
                    print("[GrowthLoop] [Existing] Slot:", slotName, "| Animal:", animal, "| Gender:", gender)
                end

                teleportAndEnable(nil, slotName)
                currentGrowthName = slotName
                shared._currentGrowthName = slotName
                print("[GrowthLoop] [Existing] Now growing:", slotName)
            end)
        end
               doParkOnSlotOne = function()
            local getFirstExistingSlotRecord = shared._getFirstExistingSlotRecord
            local slotOneEntry = type(getFirstExistingSlotRecord) == "function" and getFirstExistingSlotRecord() or nil
            local slotOne      = slotOneEntry and slotOneEntry.CharacterName
            if not slotOne then warn("[GrowthLoop] [Park] No slot 1") return end
            withLock(function()
                local ch     = player.Character
                local growth = ch and ch:GetAttribute("GrowthPercentage")
                if growth and growth < 1 and not shared._parkingModeActive then
                    print(string.format("[GrowthLoop] [Park] Not full (%.0f%%), growing existing first", growth*100))
                    setParkingModeState(false); growExistingSlots = true
                    task.spawn(function() doExistingSlotCycle() end)
                    return
                end
                print("[GrowthLoop] [Park] Parking on slot 1:", slotOne)
                if shared._autoEatChecked        then shared._autoEatChecked(false)        end
                if shared._autoDrinkChecked      then shared._autoDrinkChecked(false)      end
                if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end

                resetToMenu(); task.wait(1)
                local spawnOk = false
                for attempt = 1, 3 do
                    spawnOk = spawnAndSetup(slotOneEntry or slotOne)
                    if spawnOk then break end
                    warn("[GrowthLoop] [Park] Spawn attempt "..attempt.." failed"); task.wait(2)
                end
                if not spawnOk then warn("[GrowthLoop] [Park] All attempts failed") return end
                teleportAndEnable(nil, slotOne)
                currentGrowthName         = slotOne
                shared._currentGrowthName = slotOne

                task.wait(2)
                local parkedChar = player.Character
                if parkedChar then
                    local parkedGrowth = parkedChar:GetAttribute("GrowthPercentage") or 0
                    if parkedGrowth >= 0.999 then
                        if shared._autoEatChecked        then shared._autoEatChecked(false)        end
                        if shared._autoDrinkChecked      then shared._autoDrinkChecked(false)      end
                        if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end
                        parkedChar:SetAttribute('_drinkingToFull', false)
                        local parkedRoot = parkedChar:FindFirstChild("HumanoidRootPart")
                        if parkedRoot then
                            parkedRoot.Anchored                 = false
                            parkedRoot.AssemblyLinearVelocity   = Vector3.zero
                            parkedRoot.AssemblyAngularVelocity  = Vector3.zero
                        end
                        print("[GrowthLoop] [Park] Slot 1 is 100% — all feeding OFF, passive AFK active")
                    end
                end

                print("[GrowthLoop] [Park] Parked on "..slotOne)
            end)
        end
        shared._runParkingMode = doParkOnSlotOne
        if pendingParkMode then pendingParkMode = false task.spawn(function() doParkOnSlotOne() end) end
        local function doDeathRecovery()
            if not currentGrowthName then return end
            withLock(function()
                if parkingMode then
                    print("[GrowthLoop] Death in parking mode, recovering slot 1")
                    task.wait(2); task.spawn(doParkOnSlotOne)
                    return
                end
                print("[GrowthLoop] Death! Returning to:", currentGrowthName)
                task.wait(2)
                local ok = spawnAndSetup(currentGrowthName)
                if not ok then warn("[GrowthLoop] Death recovery failed for:", currentGrowthName) end
            end)
        end
        task.spawn(trackCurrentCharacter)
        local lastGrowth       = 0
        local growthCheckReady = false
        local function armGrowthCheck(character)
            growthCheckReady = false; lastGrowth = 0
            task.spawn(function()
                local val = waitForAttribute(character, "GrowthPercentage", 15)
                if val ~= nil then
                    lastGrowth       = (val >= 1) and 0 or val
                    growthCheckReady = true
                else
                    warn("[GrowthLoop] GrowthPercentage never appeared")
                end
            end)
        end
        task.spawn(function()
            local ch = player.Character
            if ch then armGrowthCheck(ch) end
        end)
        RunService.Heartbeat:Connect(function()
            if isLooping then return end
            if not growthCheckReady then return end
            if shared._inCarcassEat then return end
            local character = player.Character
            if not character then return end
            local growth = character:GetAttribute("GrowthPercentage")
            if not growth then return end
                        if growth >= 0.999 and lastGrowth >= 0.85 then
                local bothOn = growExistingSlots and growNewSlots
                if parkingMode then return end
                if bothOn then
                    if not allExistingGrown then
                        slotsGrownThisCycle = slotsGrownThisCycle + 1
                        print("[GrowthLoop] [Smart] Original slot grown:", slotsGrownThisCycle, "/", originalSlotCount)
                        if slotsGrownThisCycle >= originalSlotCount then
                            allExistingGrown    = true
                            slotsGrownThisCycle = 0
                            print("[GrowthLoop] [Smart] All original slots grown, switching to new")
                        end
                        task.spawn(doExistingSlotCycle)
                    elseif getTrackedSlotTotal() < MAX_SLOTS then
                        print("[GrowthLoop] [Smart] Creating new slot ("..getTrackedSlotTotal().."/"..MAX_SLOTS..")")
                        task.spawn(doGrowthReset)
                    else
                        growNewSlots      = false
                        growExistingSlots = false
                        setParkingModeState(true)
                        shared._parkingModeActive = true
                        shared._autoParkedBy40    = true
                        print("[GrowthLoop] [Smart] 40/40 slots grown — entering passive coin mode")
                        task.spawn(doParkOnSlotOne)
                    end
                elseif growExistingSlots then
                    task.spawn(doExistingSlotCycle)
                elseif growNewSlots then
                    task.spawn(doGrowthReset)
                end
                return
            end
            local hum = character:FindFirstChild("Humanoid")
            if hum and hum.Health <= 0 and not isLooping then
                lastGrowth = growth; task.spawn(doDeathRecovery); return
            end
            lastGrowth = growth
        end)
        player.CharacterAdded:Connect(function(character)
            lastGrowth = 0; growthCheckReady = false
            armGrowthCheck(character)
            task.spawn(trackCurrentCharacter)
        end)
        task.spawn(function()
            local stuckTimer         = 0
            local STUCK_THRESHOLD    = 90
            local parkStuckTimer     = 0
            local PARK_STUCK_THRESHOLD = 90
            while true do
                task.wait(15)
                local ch        = player.Character
                local hasRoot   = ch and ch:FindFirstChild("HumanoidRootPart") ~= nil
                local hasGrowth = ch and ch:GetAttribute("GrowthPercentage") ~= nil
                if parkingMode then
                    if not hasRoot or not hasGrowth then
                        parkStuckTimer = parkStuckTimer + 15
                        warn(string.format("[Watchdog] [Park] No character for %ds", parkStuckTimer))
                        if parkStuckTimer >= PARK_STUCK_THRESHOLD then
                            parkStuckTimer = 0
                            if isLooping then forceUnlockGrowthLoop("parking menu watchdog") end
                            task.spawn(doParkOnSlotOne)
                        end
                    else parkStuckTimer = 0 end
                    continue
                end
                local anyModeOn = growExistingSlots or growNewSlots
                if not anyModeOn then stuckTimer = 0 continue end
                if not hasRoot or not hasGrowth then
                    stuckTimer = stuckTimer + 15
                    warn(string.format("[Watchdog] No character for %ds", stuckTimer))
                    if stuckTimer >= STUCK_THRESHOLD then
                        stuckTimer = 0
                        if isLooping then forceUnlockGrowthLoop("menu watchdog") end
                        local getFirstExistingSlotRecord = shared._getFirstExistingSlotRecord
                        local fallbackEntry  = type(getFirstExistingSlotRecord) == "function" and getFirstExistingSlotRecord() or nil
                        local recoverSlot    = currentGrowthName or (fallbackEntry and fallbackEntry.CharacterName)
                        warn("[Watchdog] Recovering:", tostring(recoverSlot))
                        withLock(function()
                            if shared._autoEatChecked  then shared._autoEatChecked(false)  end
                            if shared._autoDrinkChecked then shared._autoDrinkChecked(false) end
                            local spawnOk = spawnAndSetup(recoverSlot)
                            if not spawnOk then warn("[Watchdog] spawnAndSetup failed") return end
                            task.wait(1)
                            local newCh = player.Character
                            if newCh then
                                local g      = waitForAttribute(newCh, "GrowthPercentage", 8)
                                local animal, gender, skin = getSlotInfo(newCh)
                                currentAnimalName = animal; currentGender = gender; currentSkin = skin
                                if g and g >= 0.999 then
                                    print("[Watchdog] Recovered slot already 100%")
                                    if growExistingSlots then task.spawn(doExistingSlotCycle)
                                    elseif growNewSlots then task.spawn(doGrowthReset) end
                                    return
                                end
                                task.wait(1)
                            end
                            teleportAndEnable(nil, recoverSlot)
                            currentGrowthName = recoverSlot; shared._currentGrowthName = recoverSlot
                            print("[Watchdog] Recovery complete:", tostring(recoverSlot))
                        end)
                    end
                else stuckTimer = 0 end
            end
        end)
        task.spawn(function()
            local LOW_THRESHOLD = 40
            local RECHECK_WAIT  = 15
            local inCycle       = false
            while true do
                task.wait(5)
                if isLooping or inCycle then continue end
                if parkingMode or shared._parkingModeActive then continue end
                local ch = player.Character
                if not ch then continue end
                local animalName = ch:GetAttribute("AnimalName") or ""
                if animalName ~= "Lion" and animalName ~= "Tiger" then continue end
                local food  = ch:GetAttribute("Food")
                local water = ch:GetAttribute("Water")
                if not food or not water then continue end
                local carcassOn = shared._autoEatCarcassChecked ~= nil
                local drinkOn   = shared._autoDrinkChecked ~= nil
                if not carcassOn and not drinkOn then continue end
                if food <= LOW_THRESHOLD or water <= LOW_THRESHOLD then
                    inCycle = true
                    warn(string.format("[EatDrinkWatchdog] [%s] Low, cycling", animalName))
                    if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end
                    if shared._autoDrinkChecked      then shared._autoDrinkChecked(false)      end
                    task.wait(1)
                    if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(true)  end
                    if shared._autoDrinkChecked      then shared._autoDrinkChecked(true)       end
                    print("[EatDrinkWatchdog] Cycled ON, waiting "..RECHECK_WAIT.."s")
                    task.wait(RECHECK_WAIT)
                    local ch2    = player.Character
                    local food2  = ch2 and ch2:GetAttribute("Food")
                    local water2 = ch2 and ch2:GetAttribute("Water")
                    if food2 and water2 then
                        if food2 <= LOW_THRESHOLD or water2 <= LOW_THRESHOLD then
                            warn("[EatDrinkWatchdog] Still low, cycling again")
                            if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(false) end
                            if shared._autoDrinkChecked      then shared._autoDrinkChecked(false)      end
                            task.wait(1)
                            if shared._autoEatCarcassChecked then shared._autoEatCarcassChecked(true)  end
                            if shared._autoDrinkChecked      then shared._autoDrinkChecked(true)       end
                        else
                            print(string.format("[EatDrinkWatchdog] Recovered Food:%.1f Water:%.1f", food2, water2))
                        end
                    end
                    inCycle = false
                end
            end
        end)
        print("[GrowthLoop] Auto growth loop started.")
    end)
    task.spawn(function()
        local GAME_SAFETY = {
            [18214855317]    = {dangerY=-100, safePos=Vector3.new(-6245.2, 10.0, 4664.3)},
            [6174994284]     = {dangerY=-100, safePos=Vector3.new(-6245.2, 10.0, 4664.3)},
            [9237322219]     = {dangerY=-100, safePos=Vector3.new(1166.835, 24.751, -358.321)},
            [75541741887441] = {dangerY=-100, safePos=Vector3.new(-26.318, 59.041, 190.665)},
        }
        local safeCfg  = GAME_SAFETY[game.GameId] or {dangerY=-100, safePos=Vector3.new(-6245.2, 10.0, 4664.3)}
        local DANGER_Y = safeCfg.dangerY
        local SAFE_POS = safeCfg.safePos
        RunService.Heartbeat:Connect(function()
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if root.Position.Y < DANGER_Y then
                print("[SafetyNet] Fell through map, teleporting back")
                char:SetPrimaryPartCFrame(CFrame.new(SAFE_POS))
            end
        end)
    end)
if not game:IsLoaded() then game.Loaded:Wait() end
buildUI()
