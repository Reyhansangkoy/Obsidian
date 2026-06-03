local ObsidianLib = {}
function ObsidianLib:CreateTheme(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ObsidianEngineUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 620, 0, 440)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -220)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 60, 1, -20)
    Sidebar.Position = UDim2.new(0, 10, 0, 10)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = MainFrame
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 12)
    SidebarLayout.Parent = Sidebar
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -90, 1, -20)
    ContentContainer.Position = UDim2.new(0, 80, 0, 10)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame
    local Window = {}
    local isFirstPage = true
    local allTabButtons = {}
    function Window:addPage(pageName, iconId)
        local PageScroll = Instance.new("ScrollingFrame")
        PageScroll.Size = UDim2.new(1, 0, 1, 0)
        PageScroll.BackgroundTransparency = 1
        PageScroll.ScrollBarThickness = 2
        PageScroll.Visible = isFirstPage
        PageScroll.Parent = ContentContainer
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 10)
        PageLayout.Parent = PageScroll
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)
        local TabBtn = Instance.new("ImageButton")
        TabBtn.Size = UDim2.new(0, 36, 0, 36)
        TabBtn.BackgroundColor3 = isFirstPage and Color3.fromRGB(90, 40, 160) or Color3.fromRGB(22, 22, 26)
        TabBtn.Image = iconId or "rbxassetid://6031225818"
        TabBtn.Parent = Sidebar
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn
        table.insert(allTabButtons, {Button = TabBtn, Page = PageScroll})
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(allTabButtons) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            end
            PageScroll.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 160)
        end)
        isFirstPage = false
        local Page = {}
        function Page:newSection(sectionName)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 30)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
            SectionFrame.Parent = PageScroll
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Padding = UDim.new(0, 6)
            SectionLayout.Parent = SectionFrame
            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, SectionLayout.AbsoluteContentSize.Y + 10)
            end)
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Size = UDim2.new(1, 0, 0, 24)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = "  " .. sectionName:upper()
            SectionTitle.TextColor3 = Color3.fromRGB(150, 120, 220)
            SectionTitle.Font = Enum.Font.SourceSansBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = SectionFrame
            local Section = {}
            function Section:newToggle(name, default, callback)
                local Tgl = Instance.new("TextButton")
                Tgl.Size = UDim2.new(1, -16, 0, 30)
                Tgl.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
                Tgl.Text = "  " .. name
                Tgl.TextColor3 = Color3.fromRGB(230, 230, 230)
                Tgl.TextXAlignment = Enum.TextXAlignment.Left
                Tgl.Parent = SectionFrame
                Tgl.MouseButton1Click:Connect(function() task.spawn(callback) end)
            end
            function Section:newSlider(name, max, min, callback)
                local Sld = Instance.new("Frame")
                Sld.Size = UDim2.new(1, -16, 0, 40)
                Sld.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
                Sld.Parent = SectionFrame
                local Lbl = Instance.new("TextLabel")
                Lbl.Size = UDim2.new(1, 0, 0, 20)
                Lbl.Text = "  " .. name
                Lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
                Lbl.BackgroundTransparency = 1
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Parent = Sld
            end
            function Section:newButton(name, callback)
                local Btn = Instance.new("TextButton")
                Btn.Size = UDim2.new(1, -16, 0, 30)
                Btn.BackgroundColor3 = Color3.fromRGB(90, 40, 160)
                Btn.Text = name
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.Parent = SectionFrame
                Btn.MouseButton1Click:Connect(function() task.spawn(callback) end)
            end
            return Section
        end
        return Page
    end
    return Window
end
getgenv().ObsidianLib = ObsidianLib
return ObsidianLib
