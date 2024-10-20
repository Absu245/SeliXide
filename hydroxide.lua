local CoreGui = game:GetService("CoreGui")
local UserInput = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
task.spawn(function() --yeah anti adonis
local g = getinfo or debug.getinfo
local d = false
local h = {}

local x, y

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local a = rawget(v, "Detected")
        local b = rawget(v, "Kill")
    
        if typeof(a) == "function" and not x then
            x = a
            
            local o; o = hookfunction(x, function(c, f, n)
                if c ~= "_" then
                    if d then
                        warn(`Adonis AntiCheat flagged\nMethod: {c}\nInfo: {f}`)
                    end
                end
                
                return true
            end)

            table.insert(h, x)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
            y = b
            local o; o = hookfunction(y, function(f)
                if d then
                    warn(`Adonis AntiCheat tried to kill (fallback): {f}`)
                end
            end)

            table.insert(h, y)
        end
    end
end

local o; o = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local a, f = ...

    if x and a == x then
        if d then
            warn(`zins | adonis bypassed`)
        end

        return coroutine.yield(coroutine.running())
    end
    
    return o(...)
end))

setthreadidentity(7)
end)
local oldmodule = getloadedmodules
getloadedmodules = function(...)
return oldmodule(true)
end
local init = loadstring(game:HttpGet('https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua'))
init()
local Interface = import("rbxassetid://11389137937")

if oh.Cache["ui/main"] then
	return Interface
end

import("ui/controls/TabSelector")
local MessageBox, MessageType = import("ui/controls/MessageBox")

local RemoteSpy
local ClosureSpy
local ScriptScanner
local ModuleScanner
local UpvalueScanner
local ConstantScanner

xpcall(function()
	RemoteSpy = import("ui/modules/RemoteSpy")
	ClosureSpy = import("ui/modules/ClosureSpy")
	ScriptScanner = import("ui/modules/ScriptScanner")
	ModuleScanner = import("ui/modules/ModuleScanner")
	UpvalueScanner = import("ui/modules/UpvalueScanner")
	ConstantScanner = import("ui/modules/ConstantScanner")
end, function(err)
	local message
	if err:find("valid member") then
		message = "The UI has updated, please rejoin and restart. If you get this message more than once, screenshot this message and report it in the Hydroxide server.\n\n" .. err
	else
		message = "Report this error in Hydroxide's server:\n\n" .. err
	end

	MessageBox.Show("An error has occurred", message, MessageType.OK, function()
		Interface:Destroy() 
	end)
end)

local constants = {
	opened = UDim2.new(0.5, -325, 0.5, -175),
	closed = UDim2.new(0.5, -325, 0, -400),
	reveal = UDim2.new(0.5, -15, 0, 20),
	conceal = UDim2.new(0.5, -15, 0, -75)
}

local Open = Interface.Open
local Base = Interface.Base
local Drag = Base.Drag
local Status = Base.Status
local Collapse = Drag.Collapse

function oh.setStatus(text)
	Status.Text = '• Status: ' .. text
end

function oh.getStatus()
	return Status.Text:gsub('• Status: ', '')
end

local dragging
local dragStart
local startPos

Drag.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local dragEnded 

		dragging = true
		dragStart = input.Position
		startPos = Base.Position

		dragEnded = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				dragEnded:Disconnect()
			end
		end)
	end
end)

oh.Events.Drag = UserInput.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		Base.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

Open.MouseButton1Click:Connect(function()
	Open:TweenPosition(constants.conceal, "Out", "Quad", 0.15)
	Base:TweenPosition(constants.opened, "Out", "Quad", 0.15)
end)

Collapse.MouseButton1Click:Connect(function()
	Base:TweenPosition(constants.closed, "Out", "Quad", 0.15)
	Open:TweenPosition(constants.reveal, "Out", "Quad", 0.15)
end)

Interface.Name = HttpService:GenerateGUID(false)
Interface.ScreenInsets = 'None'
Interface.Base.Drag.Title.Text = "SeliXide Secured c.1"
Interface.Base.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Open.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Open.Icon.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.Body.Pages.Home.Logo.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.MessageBox.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.Body.Pages.Home.Title.Text = 'Welcome to SeliXide Secured'
Interface.Base.Body.Pages.RemoteSpy.Logs.Results.Clip.Content.ScrollBarImageColor3 = Color3.fromRGB(0, 42, 255)
Interface.Base.Body.Pages.Home.Slogan.RichText = true
Interface.Base.Body.Pages.Home.Slogan.Text = 'Hydroxide version but SeliXide, fully optimized for seliware and bug fixes! (by nvmdog)'
Interface.Parent = CoreGui
return Interface
