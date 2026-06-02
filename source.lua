local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PanduStyle_UI"
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Window
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    -- Sidebar (Tempat Icon)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 50, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 10)
    SidebarCorner.Parent = Sidebar

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 15)
    SidebarLayout.Parent = Sidebar

    -- TopBar & Search
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, -60, 0, 40)
    TopBar.Position = UDim2.new(0, 60, 0, 10)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = MainFrame

    local SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBar"
    SearchBox.Size = UDim2.new(1, -20, 0, 25)
    SearchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    SearchBox.Text = "Search..."
    SearchBox.TextColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.TextSize = 14
    SearchBox.Font = Enum.Font.SourceSans
    SearchBox.Parent = TopBar

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 6)
    SearchCorner.Parent = SearchBox

    -- Container for Pages
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "Content"
    ContentContainer.Size = UDim2.new(1, -70, 1, -60)
    ContentContainer.Position = UDim2.new(0, 60, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local Window = {}
    local isFirst = true

    function Window:addPage(name, iconId)
        local PageFrame = Instance.new("ScrollingFrame")
        PageFrame.Name = name .. "Page"
        PageFrame.Size = UDim2.new(1, 0, 1, 0)
        PageFrame.BackgroundTransparency = 1
        PageFrame.ScrollBarThickness = 2
        PageFrame.Visible = isFirst
        PageFrame.Parent = ContentContainer

        local UIGrid = Instance.new("UIGridLayout")
        UIGrid.CellSize = UDim2.new(0.48, 0, 0, 200) -- Biar jadi 2 Kolom kayak Pandu Hub
        UIGrid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
        UIGrid.Parent = PageFrame

        -- Tab Button di Sidebar
        local TabBtn = Instance.new("ImageButton")
        TabBtn.Size = UDim2.new(0, 30, 0, 30)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Image = iconId or "rbxassetid://6031225818" -- Default icon
        TabBtn.ImageColor3 = isFirst and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(200, 200, 200)
        TabBtn.Parent = Sidebar

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(ContentContainer:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            PageFrame.Visible = true
        end)

        isFirst = false
        local Page = {}

        function Page:newSection(title)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            SectionFrame.Parent = PageFrame
            
            local SCorner = Instance.new("UICorner")
            SCorner.CornerRadius = UDim.new(0, 8)
            SCorner.Parent = SectionFrame

            local STitle = Instance.new("TextLabel")
            STitle.Size = UDim2.new(1, 0, 0, 25)
            STitle.Text = "  " .. title
            STitle.TextColor3 = Color3.fromRGB(150, 100, 255)
            STitle.TextXAlignment = Enum.TextXAlignment.Left
            STitle.BackgroundTransparency = 1
            STitle.Font = Enum.Font.SourceSansBold
            STitle.Parent = SectionFrame

            local SLayout = Instance.new("UIListLayout")
            SLayout.Padding = UDim.new(0, 5)
            SLayout.Parent = SectionFrame

            -- Disini lu bisa tambahin fungsi Toggle/Slider (sama kayak script sebelumnya)
            local Section = {}
            function Section:newToggle(name, default, callback)
                local Tgl = Instance.new("TextButton")
                Tgl.Size = UDim2.new(1, -10, 0, 30)
                Tgl.Text = "  " .. name
                Tgl.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                Tgl.TextColor3 = Color3.fromRGB(255, 255, 255)
                Tgl.TextXAlignment = Enum.TextXAlignment.Left
                Tgl.Parent = SectionFrame
                -- Logic toggle disini...
            end
            return Section
        end
        return Page
    end
    return Window
end

getgenv().ObsidianLib = ObsidianLib
return ObsidianLib
