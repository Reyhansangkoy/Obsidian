local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ObsidianEngineUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 620, 0, 440)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -220)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -90, 1, -20)
    ContentContainer.Position = UDim2.new(0, 80, 0, 10)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local Window = {}
    function Window:addPage(pageName, iconId)
        local PageScroll = Instance.new("ScrollingFrame")
        PageScroll.Size = UDim2.new(1, 0, 1, 0)
        PageScroll.BackgroundTransparency = 1
        PageScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
        PageScroll.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 10)
        PageLayout.Parent = PageScroll

        local Page = {}
        function Page:newSection(sectionName)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 100)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
            SectionFrame.Parent = PageScroll
            
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionFrame

            local Section = {}
            function Section:newToggle(name, default, callback)
                local Tgl = Instance.new("TextButton")
                Tgl.Size = UDim2.new(1, 0, 0, 30)
                Tgl.Text = name
                Tgl.Parent = SectionFrame
                Tgl.MouseButton1Click:Connect(function() callback(not default) end)
            end

            -- INI FUNGSI YANG HILANG TADI --
            function Section:newSlider(sliderName, max, min, callback)
                local Sld = Instance.new("TextButton")
                Sld.Size = UDim2.new(1, 0, 0, 40)
                Sld.Text = sliderName .. " [Slider]"
                Sld.Parent = SectionFrame
                Sld.MouseButton1Click:Connect(function() callback(max) end)
            end

            function Section:newButton(name, callback)
                local Btn = Instance.new("TextButton")
                Btn.Size = UDim2.new(1, 0, 0, 30)
                Btn.Text = name
                Btn.Parent = SectionFrame
                Btn.MouseButton1Click:Connect(callback)
            end
            return Section
        end
        return Page
    end
    return Window
end

return ObsidianLib
