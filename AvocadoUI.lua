SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI



function SetFramePosition()
    local FrameScale = 1

    local PlayerFrameCoords = { x = -300, y = 108 }
    local PetFrameCoords = { x = -24, y = 64 }
    local TargetFrameCoords = { x = PlayerFrameCoords.x + 92, y = PlayerFrameCoords.y - 42 }
    local FocusFrameCoords = { x = -TargetFrameCoords.x + 32, y = TargetFrameCoords.y }
    local TrinketCoords = { x = 86, y = 25 }

    local PlayerUnitFrame = CreateFrame('Frame')
    PlayerUnitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    
    PlayerUnitFrame:SetScript("OnEvent", function(self, event, ...)
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", PlayerFrameCoords.x, PlayerFrameCoords.y)
        PlayerFrame:SetScale(FrameScale)
        PlayerName:SetFont(PlayerName:GetFont(), 14, 'OUTLINE')

        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("CENTER", UIParent, "CENTER", TargetFrameCoords.x, TargetFrameCoords.y)
        TargetFrame:SetScale(FrameScale)

        FocusFrame:ClearAllPoints()
        FocusFrame:SetPoint("CENTER", UIParent, "CENTER", FocusFrameCoords.x, FocusFrameCoords.y)
        FocusFrame:SetScale(FrameScale)

        TrinketMenu_MainFrame:ClearAllPoints()
        TrinketMenu_MainFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", TrinketCoords.x, TrinketCoords.y)
        TrinketMenu_MainFrame:SetScale(FrameScale)

        PetFrame:ClearAllPoints()
        PetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", PetFrameCoords.x, PetFrameCoords.y)
        PetFrame:SetScale(FrameScale)
    end)
end

-- Hide texture and MicroButton
function HideTextureAndMicroButton()
    -- Texture
    MainMenuMaxLevelBar0:Hide()
    MainMenuMaxLevelBar1:Hide()
    MainMenuMaxLevelBar2:Hide()
    MainMenuMaxLevelBar3:Hide()
    MainMenuBarTexture0:Hide()
    MainMenuBarTexture1:Hide()
    MainMenuBarTexture2:Hide()
    MainMenuBarTexture3:Hide()
    MainMenuBarLeftEndCap:Hide()
    MainMenuBarRightEndCap:Hide()

    -- MicroButton
    ActionBarUpButton:Hide()
    ActionBarDownButton:Hide()
    MainMenuBarPageNumber:Hide()
    CharacterMicroButton:Hide()
    AchievementMicroButton:Hide()
    SpellbookMicroButton:Hide()
    TalentMicroButton:Hide()
    TalentMicroButton:HookScript("OnShow",function(self) self:Hide() end)
    QuestLogMicroButton:Hide()
    SocialsMicroButton:Hide()
    PVPMicroButton:Hide()
    LFGMicroButton:Hide()
    LFGMicroButton:HookScript("OnShow",function(self) self:Hide() end)
    MainMenuMicroButton:Hide()
    HelpMicroButton:Hide()
    MainMenuBarPerformanceBarFrame:Hide()
    KeyRingButton:Hide()
    KeyRingButton:HookScript("OnShow",function(self) self:Hide() end)

    MainMenuBarBackpackButton:Hide()
    CharacterBag0Slot:Hide()
    CharacterBag1Slot:Hide()
    CharacterBag2Slot:Hide()
    CharacterBag3Slot:Hide()
end

function SetFont()
    for i = 1, NUM_CHAT_WINDOWS do
        local chat = _G['ChatFrame'..i]
        local font, size = chat:GetFont()
        chat:SetFont(font, size, "THINOUTLINE")
    end
end

function SetActionBar()
    MainMenuExpBar:ClearAllPoints()
    MainMenuExpBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0)

    ReputationWatchBar.StatusBar:ClearAllPoints()
    ReputationWatchBar.StatusBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 0)
    ReputationWatchBar.OverlayFrame.Text:Hide()

    -- MainBar Pos
    MainMenuBar:ClearAllPoints()
    MainMenuBar:SetPoint("BOTTOM", UIParent, "BOTTOM", -272, -100)

    ActionButton1:ClearAllPoints()
    ActionButton1:SetPoint("BOTTOMLEFT", MainMenuBar, "TOP", 24, 80)

    -- BottomLeftBar Pos
    MultiBarBottomLeftButton1:ClearAllPoints()
    MultiBarBottomLeftButton1:SetPoint("BOTTOM", ActionButton1, "TOP", 0, 12)

    -- BottomRightBar Pos
    MultiBarBottomRightButton1:ClearAllPoints()
    MultiBarBottomRightButton1:SetPoint("BOTTOM", MultiBarBottomLeftButton1, "TOP", 0, 12)

    StanceButton1:ClearAllPoints()
    StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 10)

    PetActionButton1:ClearAllPoints()
    PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarBottomLeftButton1, "TOPRIGHT", 120, 10)
end

-- Arena Nameplate Number
function SetArenaNameplateNumber()
    local U = UnitIsUnit
    hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
        if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
            for i = 1, 5 do
                if U(F.unit, "arena"..i) then
                    F.name:SetText(i)
                    F.name:SetScale(1.6)
                    F.name:SetTextColor(1, 1, 0)
                    break
                end
            end
        end
    end)
end


-- Class Icon
function SetClassIcon()
    UICC = "Interface\\TargetingFrame\\UI-Classes-Circles";
    hooksecurefunc("UnitFramePortrait_Update", function(self)
        if self.portrait then
            if UnitIsPlayer(self.unit) then
                local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
                if t then
                    self.portrait:SetTexture(UICC)
                    self.portrait:SetTexCoord(unpack(t))
                end
                else
                    self.portrait:SetTexCoord(0,1,0,1)
                end
            end
        end)
end

-- Combat Icon
function SetCombatIcon()
    AD = "Interface\\Icons\\ABILITY_DUALWIELD"
    IconSize = 32

    local z = CreateFrame("Frame")
    z:SetParent(TargetFrame)
    z:SetPoint("Right", TargetFrame, 8, 8)
    z:SetSize(IconSize, IconSize)
    z.t = z:CreateTexture(nil, BORDER)
    z.t:SetAllPoints()
    z.t:SetTexture(AD)
    z:Hide()

    local function FrameOnUpdate(self)
        if UnitAffectingCombat("target") then
            self:Show()
        else
            self:Hide()
        end
    end

    local g = CreateFrame("Frame")
    g:SetScript("OnUpdate", function(self) FrameOnUpdate(z) end)

    local y = CreateFrame("Frame")
    y:SetParent(FocusFrame)
    y:SetPoint("Left", FocusFrame, -32, 8)
    y:SetSize(IconSize, IconSize)
    y.t = y:CreateTexture(nil, BORDER)
    y.t:SetAllPoints()
    y.t:SetTexture(AD)
    y:Hide()

    local function FrameOnUpdate(self)
        if UnitAffectingCombat("focus") then
            self:Show()
        else
            self:Hide()
        end
    end
    local h = CreateFrame("Frame")
    h:SetScript("OnUpdate", function(self) FrameOnUpdate(y) end)
end


function ReplaceHotKeyText()
    local gsub = string.gsub

    local function HotkeyReplace(button)
        local text = button.HotKey and button.HotKey:GetText()
        if not text then return end

        text = gsub(text, "(鼠标按键5)", "Mouse Button 5")
        text = gsub(text, "(鼠标按键4)", "Mouse Button 4")
        text = gsub(text, "(鼠标中键)", "Middle Button")
        text = gsub(text, "(鼠标滚轮向上滚动)", "Mouse Wheel Up")
        text = gsub(text, "(鼠标滚轮向下滚动)", "Mouse Wheel Down")

        button.HotKey:SetText(text)
    end

    local function SetButtonFont(button)
        if button.HotKey then
            button.HotKey:SetFont(button.Name:GetFont(), 13, 'OUTLINE')
        end

        if button.Name then
            button.Name:SetFont(button.Name:GetFont(), 12, 'OUTLINE')
        end
    end

    local frame = CreateFrame('Frame')
    frame:RegisterEvent('PLAYER_LOGIN')
    frame:SetScript('OnEvent', function()
        frame:UnregisterEvent('PLAYER_LOGIN')

        local isShadowlands = not not ActionBarActionEventsFrameMixin

        -- process old buttons
        -- action bar
        for _, button in ipairs(ActionBarButtonEventsFrame.frames) do
            SetButtonFont(button)
            HotkeyReplace(button)
            if isShadowlands then
                hooksecurefunc(button, 'UpdateHotkeys', HotkeyReplace)
            end
        end
        -- pet action bar
        for i = 1, 10 do
            local button = _G['PetActionButton' .. i]
            SetButtonFont(button)
            button.HotKey:SetPoint('TOPRIGHT', 2, 0)
            HotkeyReplace(button)
        end

        -- action bar
        if isShadowlands then
            -- 9.0 and later
            hooksecurefunc(ActionBarButtonEventsFrame, 'RegisterFrame', function(_, button)
                SetButtonFont(button)
                hooksecurefunc(button, 'UpdateHotkeys', HotkeyReplace)
            end)    
        else
            -- 8.3.7
            hooksecurefunc('ActionBarButtonEventsFrame_RegisterFrame', SetButtonFont)
            hooksecurefunc('ActionButton_UpdateHotkeys', HotkeyReplace)
        end
        -- pet action bar
        hooksecurefunc('PetActionButton_SetHotkeys', HotkeyReplace)
    end)
end

function Init()
    HideTextureAndMicroButton()
    SetFramePosition()
    SetActionBar()
    SetFont()
    SetClassIcon()
    -- SetCombatIcon()
    SetArenaNameplateNumber()
    ReplaceHotKeyText()
end

Init()


-- local ArenaFrameCoords = { x = 0, y = 0, padding = 50 }
-- ArenaEnemyFrameX = 8

-- LoadAddOn("Blizzard_ArenaUI")
-- ArenaEnemyFrame1:ClearAllPoints()
-- ArenaEnemyFrame2:ClearAllPoints()
-- ArenaEnemyFrame3:ClearAllPoints()
-- ArenaEnemyFrame4:ClearAllPoints()
-- ArenaEnemyFrame5:ClearAllPoints()

-- ArenaEnemyFrame1:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", ArenaEnemyFrameX, 160)
-- ArenaEnemyFrame2:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", ArenaEnemyFrameX, 110)
-- ArenaEnemyFrame3:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", ArenaEnemyFrameX, 60)
-- ArenaEnemyFrame4:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", ArenaEnemyFrameX, 10)
-- ArenaEnemyFrame5:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", ArenaEnemyFrameX, -40)

-- ArenaEnemyFrame1:SetScale(FrameScale)
-- ArenaEnemyFrame2:SetScale(FrameScale)
-- ArenaEnemyFrame3:SetScale(FrameScale)
-- ArenaEnemyFrame4:SetScale(FrameScale)
-- ArenaEnemyFrame5:SetScale(FrameScale)
-- ArenaEnemyFrame1CastingBar:Show()
-- ArenaEnemyFrame2CastingBar:Show()
-- ArenaEnemyFrame3CastingBar:Show()
-- ArenaEnemyFrame4CastingBar:Show()
-- ArenaEnemyFrame5CastingBar:Show()

-- ArenaEnemyFrames:Show()
-- ArenaEnemyFrame1:Hide()
-- ArenaEnemyFrame2:Hide()
-- ArenaEnemyFrame3:Hide()

-- ArenaEnemyFrame1.SetPoint = function() end
-- ArenaEnemyFrame2.SetPoint = function() end
-- ArenaEnemyFrame3.SetPoint = function() end
-- ArenaEnemyFrame4.SetPoint = function() end
-- ArenaEnemyFrame5.SetPoint = function() end

TotemFrameTotem1:ClearAllPoints()
TotemFrameTotem1:SetPoint("CENTER", UIParent, "CENTER", -48, -72)

TotemFrameScale = 1.3
TotemFrameTotem1:SetScale(TotemFrameScale)
TotemFrameTotem2:SetScale(TotemFrameScale)
TotemFrameTotem3:SetScale(TotemFrameScale)
TotemFrameTotem4:SetScale(TotemFrameScale)