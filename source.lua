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
            
            -- 1. Fungsi Toggle yang udah Lu punya
            function Section:newToggle(toggleName, default, callback)
                print("Toggle created: " .. toggleName)
                -- Logika toggle asli (bikin UI pas digeser/diklik) nanti masuk sini
            end
            
            -- 2. TAMBAHIN INI: Fungsi Slider biar yanzhub kagak crash
            function Section:newSlider(sliderName, max, min, callback)
                print("Slider created: " .. sliderName .. " (Max: " .. max .. ", Min: " .. min .. ")")
                -- Logika slider asli (bikin UI bar slider) nanti masuk sini
            end
            
            return Section
        end
        
        return Page
    end
    
    return Window
end

-- Supaya bisa di-source langsung lewat loadstring
return ObsidianLib
