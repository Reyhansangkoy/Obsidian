-- File: source.lua (Di dalam repo Obsidian Lu)
local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    print("=======================================")
    print("Executing UI Engine for: " .. hubName)
    print("=======================================")
    
    -- Bikin Base ScreenGui langsung ke PlayerGui biar pasti muncul
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ObsidianUI_Fixed"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame (Background Kotak Cheat)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Bisa digeser pake mouse
    MainFrame.Parent = ScreenGui

    -- UI Corner biar pinggirannya bulat estetik
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    -- Title Bar Hub
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -20, 0, 45)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = hubName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    -- Container Scroll Menu
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Size = UDim2.new(1, -30, 1, -65)
    Container.Position = UDim2.new(0, 15, 0, 50)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 5
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Container

    -- Auto memanjang kalau fiturnya banyak
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    end)

    local Window = {}
    
    function Window:addPage(pageName, iconId)
        local Page = {}
        
        function Page:newSection(sectionName)
            -- Label Header per Kategori (Survivor, Killer, dll)
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Name = sectionName .. "Header"
            SectionLabel.Size = UDim2.new(1, 0, 0, 30)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = "========= " .. sectionName:upper() .. " ========="
            SectionLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            SectionLabel.TextSize = 13
            SectionLabel.Font = Enum.Font.SourceSansBold
            SectionLabel.Parent = Container

            local Section = {}
            
            -- 1. TOMBOL TOGGLE AKTIF
            function Section:newToggle(toggleName, default, callback)
                local enabled = default
                
                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(1, 0, 0, 32)
                ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 130, 50) or Color3.fromRGB(45, 45, 45)
                ToggleBtn.Text = "   " .. toggleName .. " [" .. (enabled and "ON" or "OFF") .. "]"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 14
                ToggleBtn.Font = Enum.Font.SourceSans
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.Parent = Container
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 5)
                BtnCorner.Parent = ToggleBtn

                ToggleBtn.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 130, 50) or Color3.fromRGB(45, 45, 45)
                    ToggleBtn.Text = "   " .. toggleName .. " [" .. (enabled and "ON" or "OFF") .. "]"
                    task.spawn(function() callback(enabled) end)
                end)
            end
            
            -- 2. TOMBOL SLIDER AKTIF
            function Section:newSlider(sliderName, max, min, callback)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 42)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                SliderFrame.Parent = Container
                
                local FrameCorner = Instance.new("UICorner")
                FrameCorner.CornerRadius = UDim.new(0, 5)
                FrameCorner.Parent = SliderFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -110, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = sliderName .. " (Min: " .. min .. " - Max: " .. max .. ")"
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 13
                Label.Font = Enum.Font.SourceSans
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = SliderFrame
                
                local ActionBtn = Instance.new("TextButton")
                ActionBtn.Size = UDim2.new(0, 85, 0, 24)
                ActionBtn.Position = UDim2.new(1, -95, 0, 9)
                ActionBtn.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
                ActionBtn.Text = "Set Max Value"
                ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ActionBtn.TextSize = 11
                ActionBtn.Font = Enum.Font.SourceSansBold
                ActionBtn.Parent = SliderFrame
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                ActionBtn.UICorner.Parent = ActionBtn
                
                ActionBtn.MouseButton1Click:Connect(function()
                    task.spawn(function() callback(max) end)
                end)
            end
            
            -- 3. TOMBOL DROPDOWN AKTIF
            function Section:newDropdown(dropdownName, listTable, callback)
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                DropdownFrame.Parent = Container
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
                DropdownFrame.UICorner.Parent = DropdownFrame

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0, 150, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = dropdownName
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = DropdownFrame

                local SelectBtn = Instance.new("TextButton")
                SelectBtn.Size = UDim2.new(0, 130, 0, 26)
                SelectBtn.Position = UDim2.new(1, -140, 0, 6)
                SelectBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                SelectBtn.Text = listTable[1] or "None"
                SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                SelectBtn.Font = Enum.Font.SourceSansBold
                SelectBtn.Parent = DropdownFrame
                
                Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
                SelectBtn.UICorner.Parent = SelectBtn

                SelectBtn.MouseButton1Click:Connect(function()
                    task.spawn(function() callback(SelectBtn.Text) end)
                end)
            end
            
            -- 4. TOMBOL BUTTON AKTIF
            function Section:newButton(buttonName, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 32)
                Button.BackgroundColor3 = Color3.fromRGB(85, 40, 145) -- Obsidian Purple
                Button.Text = buttonName
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14
                Button.Font = Enum.Font.SourceSansBold
                Button.Parent = Container
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 5)
                BtnCorner.Parent = Button

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
