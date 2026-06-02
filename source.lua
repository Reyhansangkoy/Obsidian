-- File: source.lua (Di dalam repo Obsidian Lu)
local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    print("=======================================")
    print("Loading UI Engine for: " .. hubName)
    print("=======================================")
    
    local Window = {}
    
    function Window:addPage(pageName, iconId)
        print("Page created: [" .. pageName .. "]")
        local Page = {}
        
        function Page:newSection(sectionName)
            print("  -> Section created: " .. sectionName)
            local Section = {}
            
            -- 1. FUNGSI TOGGLE
            function Section:newToggle(toggleName, default, callback)
                print("     [Toggle] " .. toggleName .. " (Default: " .. tostring(default) .. ")")
                task.spawn(function() callback(default) end)
            end
            
            -- 2. FUNGSI SLIDER
            function Section:newSlider(sliderName, max, min, callback)
                print("     [Slider] " .. sliderName .. " (Min: " .. min .. ", Max: " .. max .. ")")
            end
            
            -- 3. FUNGSI DROPDOWN
            function Section:newDropdown(dropdownName, listTable, callback)
                local itemsString = table.concat(listTable, ", ")
                print("     [Dropdown] " .. dropdownName .. " (Items: [" .. itemsString .. "])")
            end
            
            -- 4. FUNGSI BUTTON
            function Section:newButton(buttonName, callback)
                print("     [Button] " .. buttonName .. " registered.")
            end
            
            return Section
        end
        
        return Page
    end
    
    return Window
end

return ObsidianLib
