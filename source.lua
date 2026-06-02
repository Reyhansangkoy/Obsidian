-- File: source.lua (Di dalam repo Obsidian Lu)
local ObsidianLib = {}

function ObsidianLib:CreateTheme(hubName)
    print("Loading UI for: " .. hubName)
    
    local Window = {}
    
    function Window:addPage(pageName, iconId)
        print("Page created: " .. pageName)
        local Page = {}
        
        function Page:newSection(sectionName)
            print("Section created: " .. sectionName)
            local Section = {}
            
            function Section:newToggle(toggleName, default, callback)
                print("Toggle created: " .. toggleName)
                -- Logika toggle Lu di sini
            end
            
            return Section
        end
        
        return Page
    end
    
    return Window
end

-- INI YANG PALING PENTING! Jangan sampe lupa biar bisa di-source langsung
return ObsidianLib
