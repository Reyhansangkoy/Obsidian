-- File: source.lua (Simpan di repositori GitHub Obsidian Lu)
local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    -- 1. Base GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Obsidian_Engine_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- 2. Main Window
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 580, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 9)
    MainCorner.Parent = MainFrame

    -- Stroke / Garis Pinggir UI (Obsidian Purple Accent)
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(90, 40, 160)
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame

    -- 3. Top Bar (Title)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -30, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = hubName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Tombol Close UI (Silang)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 7)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Parent = TopBar
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- 4. Sidebar (Tempat Menu Kategori / Tabs)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 140, 1, -55)
    Sidebar.Position = UDim2.new(0, 10, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = MainFrame

    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    Sidebar.UICorner.Parent = Sidebar

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 4)
    SidebarLayout.Parent = Sidebar

    -- 5. Container Utama Tempat Fitur Konten
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -170, 1, -55)
    ContentFrame.Position = UDim2.new(0, 160, 0, 45)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    ContentFrame.UICorner.Parent = ContentFrame

    local Window = {}
    local isFirstPage = true

    function Window:addPage(pageName, iconId)
        -- Bikin halaman scroll frame penampung konten fitur
        local PageScroll = Instance.new("ScrollingFrame")
        PageScroll.Name = pageName .. "Page"
        PageScroll.Size = UDim2.new(1, -16, 1, -16)
        PageScroll.Position = UDim2.new(0, 8, 0, 8)
        PageScroll.BackgroundTransparency = 1
        PageScroll.ScrollBarThickness = 4
        PageScroll.ScrollBarImageColor3 = Color3.fromRGB(90, 40, 160)
        PageScroll.Visible = isFirstPage -- Halaman pertama otomatis kebuka
        PageScroll.Parent = ContentFrame

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = PageScroll

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        -- Bikin Tombol Pindah Tab di Sidebar
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -10, 0, 32)
        TabBtn.Position = UDim2.new(0, 5, 0, 0)
        TabBtn.BackgroundColor3 = isFirstPage and Color3.fromRGB(90, 40, 160) or Color3.fromRGB(25, 25, 28)
        TabBtn.Text = pageName
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.SourceSansBold
        TabBtn.TextSize = 13
        TabBtn.Parent = Sidebar

        Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
        TabBtn.UICorner.Parent = TabBtn

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(ContentFrame:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            for _, b in pairs(Sidebar:GetChildren()) do
                if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(255, 255, 255) and Color3.fromRGB(25, 25, 28) end
            end
            PageScroll.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 160)
        end)

        isFirstPage = false
        local Page = {}

        function Page:newSection(sectionName)
            -- Label Judul Section Pemisah Fitur
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, 0, 0, 20)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = "  " .. sectionName:upper()
            SectionLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
            SectionLabel.TextSize = 12
            SectionLabel.Font = Enum.Font.SourceSansBold
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = PageScroll

            local Section = {}

            -- 1. MODEL COMPONENT: TOGGLE
            function Section:newToggle(toggleName, default, callback)
                local state = default

                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                ToggleFrame.Text = ""
                ToggleFrame.Parent = PageScroll
                Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
                ToggleFrame.UICorner.Parent = ToggleFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -60, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = toggleName
                Label.TextColor3 = Color3.fromRGB(230, 230, 230)
                Label.TextSize = 13
                Label.Font = Enum.Font.SourceSans
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = ToggleFrame

                local Indicator = Instance.new("Frame")
                Indicator.Size = UDim2.new(0, 35, 0, 18)
                Indicator.Position = UDim2.new(1, -47, 0.5, -9)
                Indicator.BackgroundColor3 = state and Color3.fromRGB(90, 40, 160) or Color3.fromRGB(50, 50, 55)
                Indicator.Parent = ToggleFrame
                Instance.new("UICorner").CornerRadius = UDim.new(0, 9)
                Indicator.UICorner.Parent = Indicator

                ToggleFrame.MouseButton1Click:Connect(function()
                    state = not state
                    Indicator.BackgroundColor3 = state and Color3.fromRGB(90, 40, 160) or Color3.fromRGB(50, 50, 55)
                    task.spawn(function() callback(state) end)
                end)
            end

            -- 2. MODEL COMPONENT: SLIDER
            function Section:newSlider(sliderName, max, min, callback)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 45)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                SliderFrame.Parent = PageScroll
                Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
                SliderFrame.UICorner.Parent = SliderFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -110, 0, 22)
                Label.Position = UDim2.new(0, 12, 0, 2)
                Label.BackgroundTransparency = 1
                Label.Text = sliderName .. " (" .. min .. " - " .. max .. ")"
                Label.TextColor3 = Color3.fromRGB(230, 230, 230)
                Label.TextSize = 13
                Label.Font = Enum.Font.SourceSans
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = SliderFrame

                local SetBtn = Instance.new("TextButton")
                SetBtn.Size = UDim2.new(0, 80, 0, 24)
                SetBtn.Position = UDim2.new(1, -92, 0, 10)
                SetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                SetBtn.Text = "Set Max"
                SetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                SetBtn.TextSize = 12
                SetBtn.Font = Enum.Font.SourceSansBold
                SetBtn.Parent = SliderFrame
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                SetBtn.UICorner.Parent = SetBtn

                SetBtn.MouseButton1Click:Connect(function()
                    task.spawn(function() callback(max) end)
                end)
            end

            -- 3. MODEL COMPONENT: DROPDOWN
            function Section:newDropdown(dropdownName, listTable, callback)
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                DropdownFrame.Parent = PageScroll
                Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
                DropdownFrame.UICorner.Parent = DropdownFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0, 150, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = dropdownName
                Label.TextColor3 = Color3.fromRGB(230, 230, 230)
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = DropdownFrame

                local SelectBtn = Instance.new("TextButton")
                SelectBtn.Size = UDim2.new(0, 120, 0, 24)
                SelectBtn.Position = UDim2.new(1, -132, 0, 7)
                SelectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                SelectBtn.Text = listTable[1] or "None"
                SelectBtn.TextColor3 = Color3.fromRGB(90, 170, 255)
                SelectBtn.Font = Enum.Font.SourceSansBold
                SelectBtn.TextSize = 12
                SelectBtn.Parent = DropdownFrame
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                SelectBtn.UICorner.Parent = SelectBtn

                SelectBtn.MouseButton1Click:Connect(function()
                    task.spawn(function() callback(SelectBtn.Text) end)
                end)
            end

            -- 4. MODEL COMPONENT: BUTTON
            function Section:newButton(buttonName, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 34)
                Button.BackgroundColor3 = Color3.fromRGB(90, 40, 160)
                Button.Text = buttonName
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 13
                Button.Font = Enum.Font.SourceSansBold
                Button.Parent = PageScroll
                Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
                Button.UICorner.Parent = Button

                Button.MouseButton1Click:Connect(function()
                    task.spawn(callback)
                end)
            end

            return Section
        end

        return Page
    end

    return Window
end

return ObsidianLib
