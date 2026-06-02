-- File: source.lua (Di dalam repo Obsidian Lu)
local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    -- Bikin Base ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ObsidianUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Lindungi GUI dari deteksi dasar (jika executor mendukung)
    if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
    ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame (Background)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Biar UI bisa digeser-geser di layar
    MainFrame.Parent = ScreenGui

    -- UI Corner biar pinggirannya smooth rounded
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    -- Title Bar
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -20, 0, 40)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = hubName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    -- Container Utama untuk Konten (Scrolling)
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Size = UDim2.new(1, -30, 1, -60)
    Container.Position = UDim2.new(0, 15, 0, 45)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 4
    Container.CanvasSize = UDim2.new(0, 0, 0, 0) -- Otomatis memanjang kebawah
    Container.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Container

    -- Auto-adjust ukuran panjang container berdasarkan banyaknya item
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
    end)

    local Window = {}
    
    function Window:addPage(pageName, iconId)
        local Page = {}
        
        function Page:newSection(sectionName)
            -- Bikin Visual Label Header Section
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Name = sectionName .. "Header"
            SectionLabel.Size = UDim2.new(1, 0, 0, 25)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = "--- " .. sectionName:upper() .. " ---"
            SectionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            SectionLabel.TextSize = 14
            SectionLabel.Font = Enum.Font.SourceSansBold
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = Container

            local Section = {}
            
            -- 1. VISUAL TOGGLE
            function Section:newToggle(toggleName, default, callback)
                local enabled = default
                
                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(1, 0, 0, 30)
                ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(45, 125, 45) or Color3.fromRGB(40, 40, 40)
                ToggleBtn.Text = "  " .. toggleName .. " [" .. (enabled and "ON" or "OFF") .. "]"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 14
                ToggleBtn.Font = Enum.Font.SourceSans
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.Parent = Container
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                ToggleBtn.UICorner.Parent = ToggleBtn

                ToggleBtn.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(45, 125, 45) or Color3.fromRGB(40, 40, 40)
                    ToggleBtn.Text = "  " .. toggleName .. " [" .. (enabled and "ON" or "OFF") .. "]"
                    task.spawn(function() callback(enabled) end)
                end)
            end
            
            -- 2. VISUAL SLIDER
            function Section:newSlider(sliderName, max, min, callback)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 40)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                SliderFrame.Parent = Container
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                SliderFrame.UICorner.Parent = SliderFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -20, 0, 20)
                Label.Position = UDim2.new(0, 10, 0, 2)
                Label.BackgroundTransparency = 1
                Label.Text = sliderName .. " (Min: " .. min .. " - Max: " .. max .. ")"
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 12
                Label.Font = Enum.Font.SourceSans
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = SliderFrame
                
                -- Klik tombol simulasi value mentok kanan aja untuk contoh basic slider
                local ActionBtn = Instance.new("TextButton")
                ActionBtn.Size = UDim2.new(0, 80, 0, 16)
                ActionBtn.Position = UDim2.new(1, -90, 0, 12)
                ActionBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                ActionBtn.Text = "Set Max"
                ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ActionBtn.TextSize = 11
                ActionBtn.Parent = SliderFrame
                
                ActionBtn.MouseButton1Click:Connect(function()
                    task.spawn(function() callback(max) end)
                end)
            end
            
            -- 3. VISUAL DROPDOWN
            function Section:newDropdown(dropdownName, listTable, callback)
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                DropdownFrame.Parent = Container
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                DropdownFrame.UICorner.Parent = DropdownFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0, 150, 1, 0)
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = dropdownName
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = DropdownFrame

                -- Tombol milih item pertama di daftar array-nya
                local SelectBtn = Instance.new("TextButton")
                SelectBtn.Size = UDim2.new(0, 120, 0, 25)
                SelectBtn.Position = UDim2.new(1, -130, 0, 5)
                SelectBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                SelectBtn.Text = listTable[1] or "None"
                SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                SelectBtn.Parent = DropdownFrame

                SelectBtn.MouseButton1Click:Connect(function()
                    -- Simulasi klik langsung milih option pertama
                    task.spawn(function() callback(SelectBtn.Text) end)
                end)
            end
            
            -- 4. VISUAL BUTTON
            function Section:newButton(buttonName, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.BackgroundColor3 = Color3.fromRGB(70, 30, 130) -- Ungu Obsidian
                Button.Text = buttonName
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14
                Button.Font = Enum.Font.SourceSansBold
                Button.Parent = Container
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
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
