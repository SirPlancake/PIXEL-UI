if IsValid(PIXEL.DemoPanel) then
    PIXEL.DemoPanel:Remove()
    PIXEL.DemoPanel = nil
end

local function openDemo()
    if IsValid(PIXEL.DemoPanel) then
        PIXEL.DemoPanel:Remove()
        PIXEL.DemoPanel = nil
    end

    PIXEL.DemoPanel = vgui.Create("PIXEL.Frame")
    PIXEL.DemoPanel:SetSize(ScrH() * .5, ScrH() * .5)
    PIXEL.DemoPanel:SetSizable(true)
    PIXEL.DemoPanel:SetTitle("PIXEL Demo")
    PIXEL.DemoPanel:Center()
    PIXEL.DemoPanel:MakePopup()

    local scrollPanel = vgui.Create("PIXEL.ScrollPanel", PIXEL.DemoPanel)
    scrollPanel:Dock(FILL)

    local avatarHolder = vgui.Create("Panel", scrollPanel)
    local avatar = vgui.Create("PIXEL.Avatar", avatarHolder)

    local buttonHolder = vgui.Create("Panel", scrollPanel)
    local buttonFuncs = {
        {
            name = "Message",
            func = function(s)
                Derma_Message("This is a test message", "Test Message")
            end
        },
        {
            name = "Query",
            func = function(s)
                Derma_Query("Test Query", "This is a test query",
                    "Thanks", function() end,
                    "Sure", function() end,
                    "Close", function() end
                )
            end
        },
        {
            name = "String Request",
            func = function(s)
                Derma_StringRequest(
                    "Test String Request",
                    "This is a test string request",
                    "Placeholder text!",
                    function(text) chat.AddText(text) end,
                    function(text) chat.AddText("Cancelled") end
                )
            end
        }
    }

    local buttons = {}
    for k,v in ipairs(buttonFuncs) do
        buttons[k] = vgui.Create("PIXEL.TextButton", buttonHolder)
        buttons[k]:SetText(v.name)
        buttons[k].DoClick = v.func
    end

    local checkboxHolder = vgui.Create("Panel", scrollPanel)
    local checkbox = vgui.Create("PIXEL.Checkbox", checkboxHolder)
    local label = vgui.Create("PIXEL.Label", checkboxHolder)
    label:SetText("Click me!")

    local colorPicker = vgui.Create("PIXEL.ColorPicker", scrollPanel)

    local comboboxHolder = vgui.Create("Panel", scrollPanel)
    local combobox = vgui.Create("PIXEL.ComboBox", comboboxHolder)

    combobox:SetValue("Select a fruit")
    combobox:AddChoice("Apple")
    combobox:AddChoice("Banana")
    combobox:AddChoice("Orange")
    combobox:AddChoice("Mango")

    local navbar = vgui.Create("PIXEL.Navbar", scrollPanel)
    navbar:AddItem("home", "Home", function() end)
    navbar:AddItem("dashboard", "Dashboard", function() end)
    navbar:AddItem("settings", "Settings", function() end)

    local slider = vgui.Create("PIXEL.Slider", scrollPanel)

    local validatedEntry = vgui.Create("PIXEL.ValidatedTextEntry", scrollPanel)

    function validatedEntry:IsTextValid(text)
        if text == "Test123" then
            return false, "No capital letters!"
        end

        if text == "1" then
            return false, "Must be more than a single digit!"
        end

        return true
    end

    local sidebarHolder = vgui.Create("Panel", scrollPanel)
    local sidebar = vgui.Create("PIXEL.Sidebar", sidebarHolder)
    sidebar:AddItem("home", "Home", "zxvcWUB", function() end)
    sidebar:AddItem("dashboard", "Dashboard", "3Q5t1GJ", function() end)
    sidebar:AddItem("settings", "Settings", "uoUTfzd", function() end)
    sidebar:AddItem("something", "No icon lol", nil, function() end)

    function scrollPanel:LayoutContent(w, h)
        self:GetCanvas():DockPadding(PIXEL.Scale(10), PIXEL.Scale(10), 0, PIXEL.Scale(10))

        avatarHolder:SetTall(PIXEL.Scale(200))
        avatarHolder:Dock(TOP)
        avatarHolder:DockMargin(0, 0, 0, PIXEL.Scale(15))

        avatar:SetPlayer(LocalPlayer(), PIXEL.Scale(200))
        avatar:SetSize(PIXEL.Scale(200), PIXEL.Scale(200))
        avatar:SetMaskSize(PIXEL.Scale(100))
        avatar:Dock(LEFT)

        buttonHolder:Dock(TOP)
        buttonHolder:SizeToChildren(false, true)
        buttonHolder:DockMargin(0, 0, 0, PIXEL.Scale(15))

        for k,v in ipairs(buttons) do
            v:SizeToText()
            v:Dock(LEFT)
            v:DockMargin(0, 0, PIXEL.Scale(6), 0)
        end

        checkboxHolder:Dock(TOP)
        checkbox:Dock(LEFT)
        checkbox:DockMargin(0, 0, PIXEL.Scale(6), 0)

        label:Dock(LEFT)
        label:SetTall(select(2, label:CalculateSize()))
        label:CenterVertical()

        checkboxHolder:SizeToChildren(false, true)
        checkboxHolder:DockMargin(0, 0, 0, PIXEL.Scale(15))

        colorPicker:Dock(TOP)
        colorPicker:SetSize(PIXEL.Scale(150), PIXEL.Scale(150))

        combobox:Dock(LEFT)
        comboboxHolder:Dock(TOP)
        comboboxHolder:SizeToChildren(false, true)
        comboboxHolder:DockMargin(0, 0, 0, PIXEL.Scale(15))

        navbar:SetTall(PIXEL.Scale(50))
        navbar:Dock(TOP)
        navbar:DockMargin(0, 0, PIXEL.Scale(15), PIXEL.Scale(15))

        slider:SetTall(PIXEL.Scale(8))
        slider:Dock(TOP)
        slider:DockMargin(0, 0, PIXEL.Scale(15), PIXEL.Scale(15))

        validatedEntry:Dock(TOP)
        validatedEntry:DockMargin(0, 0, PIXEL.Scale(15), PIXEL.Scale(15))

        sidebarHolder:Dock(TOP)
        sidebar:Dock(LEFT)
        sidebar:SetSize(PIXEL.Scale(200), PIXEL.Scale(600))

        sidebarHolder:SizeToChildren(false, true)
    end
end

concommand.Add("pixelui_demo", openDemo)