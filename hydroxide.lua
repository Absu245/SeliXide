local CoreGui = game:GetService("CoreGui")
local UserInput = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
if getexecutorname() ~= 'Seliware' then
warn('! SCRIPT SPECIALLY MADE ONLY FOR SELIWARE !')
return
end
if bypass_adonis then
task.spawn(function()
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
end
local oldmodule = getloadedmodules
getloadedmodules = function(...)
return oldmodule(true)
end
--INIT
local environment = assert(getgenv, "<OH> ~ Your exploit is not supported")()

if oh then
    oh.Exit()
end

local web = true
local user = "Upbolt" -- change if you're using a fork
local branch = "revision"
local importCache = {}

local function hasMethods(methods)
    for name in pairs(methods) do
        if not environment[name] then
            return false
        end
    end

    return true
end

local function useMethods(module)
    for name, method in pairs(module) do
        if method then
            environment[name] = method
        end
    end
end

if Window and PROTOSMASHER_LOADED then
    getgenv().get_script_function = nil
end

local globalMethods = {
    checkCaller = checkcaller,
    newCClosure = newcclosure,
    hookFunction = hookfunction or detour_function,
    getGc = getgc or get_gc_objects,
    getInfo = debug.getinfo or getinfo,
    getSenv = getsenv,
    getMenv = getmenv or getsenv,
    getContext = getthreadcontext or get_thread_context or (syn and syn.get_thread_identity),
    getConnections = get_signal_cons or getconnections,
    getScriptClosure = getscriptclosure or get_script_function,
    getNamecallMethod = getnamecallmethod or get_namecall_method,
    getCallingScript = getcallingscript or get_calling_script,
    getLoadedModules = getloadedmodules or get_loaded_modules,
    getConstants = debug.getconstants or getconstants or getconsts,
    getUpvalues = debug.getupvalues or getupvalues or getupvals,
    getProtos = debug.getprotos or getprotos,
    getStack = debug.getstack or getstack,
    getConstant = debug.getconstant or getconstant or getconst,
    getUpvalue = debug.getupvalue or getupvalue or getupval,
    getProto = debug.getproto or getproto,
    getMetatable = getrawmetatable or debug.getmetatable,
    getHui = get_hidden_gui or gethui,
    setClipboard = setclipboard or writeclipboard,
    setConstant = debug.setconstant or setconstant or setconst,
    setContext = setthreadcontext or set_thread_context or (syn and syn.set_thread_identity),
    setUpvalue = debug.setupvalue or setupvalue or setupval,
    setStack = debug.setstack or setstack,
    setReadOnly = setreadonly or (make_writeable and function(table, readonly) if readonly then make_readonly(table) else make_writeable(table) end end),
    isLClosure = islclosure or is_l_closure or (iscclosure and function(closure) return not iscclosure(closure) end),
    isReadOnly = isreadonly or is_readonly,
    isXClosure = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or istempleclosure or checkclosure,
    hookMetaMethod = hookmetamethod or (hookfunction and function(object, method, hook) return hookfunction(getMetatable(object)[method], hook) end),
    readFile = readfile,
    writeFile = writefile,
    makeFolder = makefolder,
    isFolder = isfolder,
    isFile = isfile,
}

if PROTOSMASHER_LOADED then
    globalMethods.getConstant = function(closure, index)
        return globalMethods.getConstants(closure)[index]
    end
end

local oldGetUpvalue = globalMethods.getUpvalue
local oldGetUpvalues = globalMethods.getUpvalues

globalMethods.getUpvalue = function(closure, index)
    if type(closure) == "table" then
        return oldGetUpvalue(closure.Data, index)
    end

    return oldGetUpvalue(closure, index)
end

globalMethods.getUpvalues = function(closure)
    if type(closure) == "table" then
        return oldGetUpvalues(closure.Data)
    end

    return oldGetUpvalues(closure)
end

environment.hasMethods = hasMethods
environment.oh = {
    Events = {},
    Hooks = {},
    Cache = importCache,
    Methods = globalMethods,
    Constants = {
        Types = {
            ["nil"] = "rbxassetid://4800232219",
            table = "rbxassetid://4666594276",
            string = "rbxassetid://4666593882",
            number = "rbxassetid://4666593882",
            boolean = "rbxassetid://4666593882",
            userdata = "rbxassetid://4666594723",
            vector = "rbxassetid://4666594723",
            ["function"] = "rbxassetid://4666593447",
            ["thread"] = "rbxassetid://4666593447",
            ["integral"] = "rbxassetid://4666593882"
        },
        Syntax = {
            ["nil"] = Color3.fromRGB(244, 135, 113),
            table = Color3.fromRGB(225, 225, 225),
            string = Color3.fromRGB(225, 150, 85),
            number = Color3.fromRGB(170, 225, 127),
            boolean = Color3.fromRGB(127, 200, 255),
            userdata = Color3.fromRGB(225, 225, 225),
            vector = Color3.fromRGB(225, 225, 225),
            ["function"] = Color3.fromRGB(225, 225, 225),
            ["thread"] = Color3.fromRGB(225, 225, 225),
            ["unnamed_function"] = Color3.fromRGB(175, 175, 175)
        }
    },
    Exit = function()
        for _i, event in pairs(oh.Events) do
            event:Disconnect()
        end

        for original, hook in pairs(oh.Hooks) do
            local hookType = type(hook)
            if hookType == "function" then
                hookFunction(hook, original)
            elseif hookType == "table" then
                hookFunction(hook.Closure.Data, hook.Original)
            end
        end

        local ui = importCache["rbxassetid://11389137937"]
        local assets = importCache["rbxassetid://5042114982"]

        if ui then
            unpack(ui):Destroy()
        end

        if assets then
            unpack(assets):Destroy()
        end
    end
}

if getConnections then 
    for __, connection in pairs(getConnections(game:GetService("ScriptContext").Error)) do

        local conn = getrawmetatable(connection)
        local old = conn and conn.__index
        
        if PROTOSMASHER_LOADED ~= nil then setwriteable(conn) else setReadOnly(conn, false) end
        
        if old then
            conn.__index = newcclosure(function(t, k)
                if k == "Connected" then
                    return true
                end
                return old(t, k)
            end)
        end

        if PROTOSMASHER_LOADED ~= nil then
            setReadOnly(conn)
            connection:Disconnect()
        else
            setReadOnly(conn, true)
            connection:Disable()
        end
    end
end

useMethods(globalMethods)

local HttpService = game:GetService("HttpService")
local releaseInfo = HttpService:JSONDecode(game:HttpGetAsync("https://api.github.com/repos/" .. user .. "/Hydroxide/releases"))[1]

if readFile and writeFile then
    local hasFolderFunctions = (isFolder and makeFolder) ~= nil
    local ran, result = pcall(readFile, "__oh_version.txt")

    if not ran or releaseInfo.tag_name ~= result then
        if hasFolderFunctions then
            local function createFolder(path)
                if not isFolder(path) then
                    makeFolder(path)
                end
            end

            createFolder("hydroxide")
            createFolder("hydroxide/user")
            createFolder("hydroxide/user/" .. user)
            createFolder("hydroxide/user/" .. user .. "/methods")
            createFolder("hydroxide/user/" .. user .. "/modules")
            createFolder("hydroxide/user/" .. user .. "/objects")
            createFolder("hydroxide/user/" .. user .. "/ui")
            createFolder("hydroxide/user/" .. user .. "/ui/controls")
            createFolder("hydroxide/user/" .. user .. "/ui/modules")
        end

        function environment.import(asset)
            if importCache[asset] then
                return unpack(importCache[asset])
            end

            local assets

            if asset:find("rbxassetid://") then
                assets = { game:GetObjects(asset)[1] }
            elseif web then
                if readFile and writeFile then
                    local file = (hasFolderFunctions and "hydroxide/user/" .. user .. '/' .. asset .. ".lua") or ("hydroxide-" .. user .. '-' .. asset:gsub('/', '-') .. ".lua")
                    local content

                    if (isFile and not isFile(file)) or not importCache[asset] then
                        content = game:HttpGetAsync("https://raw.githubusercontent.com/" .. user .. "/Hydroxide/" .. branch .. '/' .. asset .. ".lua")
                        writeFile(file, content)
                    else
                        local ran, result = pcall(readFile, file)

                        if (not ran) or not importCache[asset] then
                            content = game:HttpGetAsync("https://raw.githubusercontent.com/" .. user .. "/Hydroxide/" .. branch .. '/' .. asset .. ".lua")
                            writeFile(file, content)
                        else
                            content = result
                        end
                    end

                    assets = { loadstring(content, asset .. '.lua')() }
                else
                    assets = { loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/" .. user .. "/Hydroxide/" .. branch .. '/' .. asset .. ".lua"), asset .. '.lua')() }
                end
            else
                assets = { loadstring(readFile("hydroxide/" .. asset .. ".lua"), asset .. '.lua')() }
            end

            importCache[asset] = assets
            return unpack(assets)
        end

        writeFile("__oh_version.txt", releaseInfo.tag_name)
    elseif ran and releaseInfo.tag_name == result then
        function environment.import(asset)
            if importCache[asset] then
                return unpack(importCache[asset])
            end

            if asset:find("rbxassetid://") then
                assets = { game:GetObjects(asset)[1] }
            elseif web then
                local file = (hasFolderFunctions and "hydroxide/user/" .. user .. '/' .. asset .. ".lua") or ("hydroxide-" .. user .. '-' .. asset:gsub('/', '-') .. ".lua")
                local ran, result = pcall(readFile, file)
                local content

                if not ran then
                    content = game:HttpGetAsync("https://raw.githubusercontent.com/" .. user .. "/Hydroxide/" .. branch .. '/' .. asset .. ".lua")
                    writeFile(file, content)
                else
                    content = result
                end

                assets = { loadstring(content, asset .. '.lua')() }
            else
                assets = { loadstring(readFile("hydroxide/" .. asset .. ".lua"), asset .. '.lua')() }
            end

            importCache[asset] = assets
            return unpack(assets)
        end

    end

    useMethods({ import = environment.import })
end

useMethods(import("methods/string"))
useMethods(import("methods/table"))
useMethods(import("methods/userdata"))
useMethods(import("methods/environment"))

--import("ui/main")
--INIT END
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
if bypass_adonis then
Interface.Base.Drag.Title.Text = "SeliXide Secured c.1"
Interface.Base.Body.Pages.Home.Title.Text = 'Welcome to SeliXide Secured'
else
Interface.Base.Drag.Title.Text = "SeliXide c.1"
Interface.Base.Body.Pages.Home.Title.Text = 'Welcome to SeliXide'
end
Interface.Base.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Open.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Open.Icon.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.Body.Pages.Home.Logo.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.MessageBox.Border.ImageColor3 = Color3.fromRGB(0, 0, 255)
Interface.Base.Body.Pages.RemoteSpy.Logs.Results.Clip.Content.ScrollBarImageColor3 = Color3.fromRGB(0, 42, 255)
Interface.Base.Body.Pages.Home.Slogan.RichText = true
Interface.Base.Body.Pages.Home.Slogan.Text = 'Hydroxide version but SeliXide, fully optimized for seliware and bug fixes! (by nvmdog)'
for i,v in Interface.ContextMenus:GetDescendants() do
if v.ClassName == 'ImageLabel' and v.ImageColor3 == Color3.fromRGB(170, 0, 0) then
v.ImageColor3 = Color3.fromRGB(0,0,255)
end
end
Interface.Parent = CoreGui
warn('! SELIXIDE !')
return Interface
