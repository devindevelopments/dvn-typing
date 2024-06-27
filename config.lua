Config = {}

--[[
    In order to work you need to include this two events.

    # Chat opening

    TriggerEvent("dvn-typing:input", true)

    # Chat closing

    TriggerEvent("dvn-typing:input", false)
]]

-- Chat Resource Name

Config.ResourceName = "chat"

-- Text Customization

Config.Height = 1 -- Default
Config.Colour = { r = 255, g = 127, b = 80, a = 255 }
Config.Text = "[...]"
Config.Distance = 5
Config.Scale = 0.65
Config.TextFont = 0