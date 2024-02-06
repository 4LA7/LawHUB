local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "SamzPRBDY",
    SubTitle = "SamzPRBDY",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    MainTab   = Window:AddTab({ Title = "Main", Icon = "home" }),
    VehicleTab    = Window:AddTab({ Title = "Vehicle", Icon = "car" }),
    TeleportTab = Window:AddTab({ Title = "Teleport", Icon = "aperture" }),
    ServerTab = Window:AddTab({ Title = "Server", Icon = "server" }),
    DeveloperTab = Window:AddTab({ Title = "Developer", Icon = "shield-check" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

do
    local FarmSection = Tabs.MainTab:AddSection("Farm Config")

    local AmountTeleport = FarmSection:AddInput("Input", {
        Title = "Amount Teleport",
        Default = 9999,
        Placeholder = "EX: 9999",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            truck_amount_teleport = Value
        end
    })

    local AmountCooldown = FarmSection:AddInput("Input", {
        Title = "Cooldown Teleport",
        Default = 45,
        Placeholder = "Recommended 45",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            truck_cooldown_teleport = Value
        end
    })
    
    Tabs.MainTab:AddButton({
        Title = "Truck Farm",
        Description = "",
        Callback = function()
            DoFarm()
        end
    })

    local BoxSniper = Tabs.MainTab:AddSection("Box Sniper")

    BoxSniper:AddButton({
        Title = "Claim Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Claim"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    BoxSniper:AddButton({
        Title = "Gamepass Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Buy",
                [2] = "Gamepass Box"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    BoxSniper:AddButton({
        Title = "Limited Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Buy",
                [2] = "Limited Box"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    local MainMisc = Tabs.MainTab:AddSection("Misc")

    local JobDown = MainMisc:AddDropdown("Dropdown", {
        Title = "Select Job",
        Values = {"Biru Driver", "Gowes Driver", "Unemployee", "Office Worker", "Silambat Courier", "Truck Driver", "Travel Driver"},
        Multi = false,
        Default = "",
    })

    JobDown:OnChanged(function(Value)
        if Value == "Biru Driver" then
            local args = {
                [1] = "Taxi"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Gowes Driver" then
            local args = {
                [1] = "Gowes"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Unemployee" then
            local args = {
                [1] = "Unemployee"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Office Worker" then
            local args = {
                [1] = "Office"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Silambat Courier" then
            local args = {
                [1] = "SiLambat"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Truck Driver" then
            local args = {
                [1] = "Truck"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        elseif Value == "Travel Driver" then
            local args = {
                [1] = "Travel"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        end
    end)


    function AntiAFK()
        AFKConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function()
            local idleTask = task.spawn(function()
                while true do
                    task.wait(5)
    
                    game.VirtualInputManager:SendKeyEvent(true, "W", false, game)
                    wait()
                    game.VirtualInputManager:SendKeyEvent(false, "W", false, game)
                end
            end)
    
            game.Players.LocalPlayer.CharacterRemoved:Connect(function()
                idleTask:cancel()
            end)
        end)
    end

    local AntiToggle = MainMisc:AddToggle("MyToggle", {Title = "Anti AFK", Default = true })
    AntiToggle:OnChanged(function()
        AntiAFK(Value)
    end)

    local Dealership = Tabs.VehicleTab:AddSection("Car Dealership")

    local DealershipCentralJava = Dealership:AddDropdown("Dropdown", {
        Title = "Dealership [ Central Java ]",
        Values = {"Mobil Bekas", "Honda", "Kia", "Mitsubishi", "Toyota", "Komersial"},
        Multi = false,
        Default = "",
    })

    DealershipCentralJava:OnChanged(function(Value)
        if Value == "Mobil Bekas" then
            fireproximityprompt(workspace.Etc.Dealership["77"].Prompt)
        elseif Value == "Honda" then
            fireproximityprompt(workspace.Etc.Dealership:GetChildren()[6].Prompt)
        elseif Value == "Kia" then
            fireproximityprompt(workspace.Etc.Dealership.KIA.Prompt)
        elseif Value == "Mitsubishi" then
            fireproximityprompt(workspace.Etc.Dealership.Mitsubishi.Prompt)
        elseif Value == "Toyota" then
            fireproximityprompt(workspace.Etc.Dealership:GetChildren()[8].Prompt)
        elseif Value == "Komersial" then
            fireproximityprompt(workspace.Etc.Dealership.Komersial.Prompt)
        end
    end)


    local DealershipWestJava = Dealership:AddDropdown("Dropdown", {
        Title = "Dealership [ West Java ]",
        Values = {"Mobil Bekas", "Mobil Bandung", "Daihatsu", "Honda", "Hyundai", "Kia", "Komersial", "Mazda", "Nissan", "Otnas", "Premium", "Suzuki"},
        Multi = false,
        Default = "",
    })

    DealershipWestJava:OnChanged(function(Value)
        if Value == "Mobil Bekas" then
            fireproximityprompt(workspace.Etc.Dealership["77"].Prompt)
        elseif Value == "Mobil Bandung" then
            fireproximityprompt(workspace.Etc.Dealership.Bandung.Prompt)
        elseif Value == "Mobil Bandung" then
            fireproximityprompt(workspace.Etc.Dealership.Bandung.Prompt)
        elseif Value == "Daihatsu" then
            fireproximityprompt(workspace.Etc.Dealership.Daihatsu.Prompt)
        elseif Value == "Honda" then
            fireproximityprompt(workspace.Etc.Dealership.Honda.Prompt)
        elseif Value == "Hyundai" then
            fireproximityprompt(workspace.Etc.Dealership.Hyundai.Prompt)
        elseif Value == "Kia" then
            fireproximityprompt(workspace.Etc.Dealership.KIA.Prompt)
        elseif Value == "Komersial" then
            fireproximityprompt(workspace.Etc.Dealership.Komersial.Prompt)
        elseif Value == "Mazda" then
            fireproximityprompt(workspace.Etc.Dealership.Mazda.Prompt)
        elseif Value == "Nissan" then
            fireproximityprompt(workspace.Etc.Dealership.Nissan.Prompt)
        elseif Value == "Otnas" then
            fireproximityprompt(workspace.Etc.Dealership.Otnas.Prompt)
        elseif Value == "Premium" then
            fireproximityprompt(workspace.Etc.Dealership.Premium.Prompt)
        elseif Value == "Suzuki" then
            fireproximityprompt(workspace.Etc.Dealership.Suzuki.Prompt)
        end
    end)

    local DealershipJakarta = Dealership:AddDropdown("Dropdown", {
        Title = "Dealership [ Jakarta ]",
        Values = {"Audi", "BMW", "Lexus", "MercedesBenz", "Toyota", "WeltWagen", "Wuling"},
        Multi = false,
        Default = "",
    })

    DealershipJakarta:OnChanged(function(Value)
        if Value == "Audi" then
            fireproximityprompt(workspace.Etc.Dealership.Audi.Prompt)
        elseif Value == "BMW" then
            fireproximityprompt(workspace.Etc.Dealership.BMW.Prompt)
        elseif Value == "Lexus" then
            fireproximityprompt(workspace.Etc.Dealership.Lexus.Prompt)
        elseif Value == "MercedesBenz" then
            fireproximityprompt(workspace.Etc.Dealership.MercedesBenz.Prompt)
        elseif Value == "Toyota" then
            fireproximityprompt(workspace.Etc.Dealership.Toyota.Prompt)
        elseif Value == "WeltWagen" then
            fireproximityprompt(workspace.Etc.Dealership.VW.Prompt)
        elseif Value == "Wuling" then
            fireproximityprompt(workspace.Etc.Dealership.Wuling.Prompt)
        end
    end)

    local TimeTrialSection = Tabs.VehicleTab:AddSection("Time Trial")

    TimeTrialSection:AddButton({
        Title = "Time Trial",
        Description = "Will work in jakarta map",
        Callback = function()
            TimeTrialJakarta()
        end
    })

    local PomBensin = Tabs.VehicleTab:AddSection("Pom Isna-Hamzah")

    local PomCentralJava = PomBensin:AddDropdown("Dropdown", {
        Title = "Fuel Station [ Central Java ]",
        Values = {"Solar", "Electric", "Pertalite", "Dex", "Turbo", "VPowerRON95", "SuperRON92", "VPowerDieselCN51"},
        Multi = false,
        Default = "",
    })

    PomCentralJava:OnChanged(function(Value)
        if Value == "Solar" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[88].Prompt)
        elseif Value == "Electric" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller.Fuel.Prompt)
        elseif Value == "Pertalite" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[44].Prompt)
        elseif Value == "Dex" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[2].Prompt)
        elseif Value == "Turbo" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[84].Prompt)
        elseif Value == "VPowerRON95" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[83].Prompt)
        elseif Value == "SuperRON92" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[49].Prompt)
        elseif Value == "VPowerDieselCN51" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[8].Prompt)
        end
    end)

    local PomWestJava = PomBensin:AddDropdown("Dropdown", {
        Title = "Fuel Station [ West Java ]",
        Values = {"Pertamax", "Solar", "Electric", "VPowerNitroRON98", "Turbo", "Dex", "Pertalite", "VPowerDieselCN51", "SuperRON92", "VPowerRON95", "Premium"},
        Multi = false,
        Default = "",
    })

    PomWestJava:OnChanged(function(Value)
        if Value == "Pertamax" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[64].Prompt)
        elseif Value == "Solar" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller.Fuel.Prompt)
        elseif Value == "Electric" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[62].Prompt)
        elseif Value == "VPowerNitroRON98" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[61].Prompt)
        elseif Value == "Turbo" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[59].Prompt)
        elseif Value == "Dex" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[50].Prompt)
        elseif Value == "Pertalite" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[44].Prompt)
        elseif Value == "VPowerDieselCN51" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[40].Prompt)
        elseif Value == "SuperRON92" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[38].Prompt)
        elseif Value == "VPowerRON95" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[37].Prompt)
        elseif Value == "Premium" then
            fireproximityprompt(workspace.Etc.Car.FuelFiller:GetChildren()[8].Prompt)
        end
    end)

    local CarMisc = Tabs.VehicleTab:AddSection("Misc")

    CarMisc:AddButton({
        Title = "Wash Car",
        Description = "",
        Callback = function()
            fireproximityprompt(workspace.Etc.Wash:GetChildren()[2].Prompt)
        end
    })

    local gotoModification = Tabs.TeleportTab:AddSection("Modification Location")

    gotoModification:AddButton({
        Title = "Teleport",
        Description = "You must in inside of car",
        Callback = function()
            gotoModification()
        end
    })

    function gotoModification()
        local playerName = game.Players.LocalPlayer.Name
        local carIdentifier = "sCar"
        local playerCar = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]
        if game.PlaceId == 9233343468 then
            playerCar:SetPrimaryPartCFrame(CFrame.new(-17241.0352, -15.4131603, 18883.3945, -0.49346447, 0, 0.869766355, 0, -1.00000048, 0, 0.869766355, 0, 0.493463993))
        elseif game.PlaceId == 14005966837 then
            playerCar:SetPrimaryPartCFrame(CFrame.new(837.241455, 23.425499, -3882.73242, -0.94222188, -0, -0.334989905, 0, -1.00000024, 0, -0.334989905, 0, 0.942221701))
        else
            playerCar:SetPrimaryPartCFrame(CFrame.new(-32563.8242, 1044.54321, -46702.9375, -0.862272978, 0, 0.506444514, 0, -1.00000048, 0, 0.506444514, 0, 0.86227262))
        end
    end

    local TeleportToPlayer = Tabs.TeleportTab:AddSection("Goto Someone")

    local Players = game:GetService("Players") 
    function GetAllPlayers()
        local playerList = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then 
                table.insert(playerList, player.Name)
            end
        end
        return playerList
    end

    function TeleportToSelectedPlayer(selectedPlayer)
        if selectedPlayer then
            local playerToTeleport = Players:FindFirstChild(selectedPlayer)
            if playerToTeleport then
                local targetPosition = playerToTeleport.Character and playerToTeleport.Character:FindFirstChild("HumanoidRootPart").Position
                if targetPosition then
                    game.Players.LocalPlayer.Character:MoveTo(targetPosition)
                end
            end
        end
    end
    
    local RefreshedPlayers = GetAllPlayers()

    local gotoSomeone = TeleportToPlayer:AddDropdown("Dropdown", {
        Title = "Teleport To Someone",
        Values = RefreshedPlayers,
        Multi = false,
        Default = "",
    })

    TeleportToPlayer:AddButton({
        Title = "Refresh Players",
        Description = "",
        Callback = function()
            RefreshedPlayers = GetAllPlayers()
        end
    })

    gotoSomeone:OnChanged(function(Value)
        TeleportToSelectedPlayer(Value)
    end)



    Tabs.DeveloperTab:AddButton({
        Title = "Dark-Dex Explorer",
        Description = "",
        Callback = function()
            getgenv().Key = "Bash"
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AIY%20Dex",true))()
        end
    })

    Tabs.DeveloperTab:AddButton({
        Title = "Simple Spy",
        Description = "",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
        end
    })











    function DoFarm(Value)
        local plr = game.Players.LocalPlayer
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "U", false, game)
        wait(0.8)
        local args = { "Truck" }
        game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        game.Workspace.Gravity = 10
        wait(2)
        game.Workspace.Gravity = 0
        fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
        fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
        game.Workspace.Gravity = 10
        TakeEarlyPoint()
        fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
        fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
        wait(0.5)
        local destination = GetWaypointName()
        wait(1)
        game.Workspace.Gravity = 100
        wait(1)
        CheckStartJob()
        wait(2)
        SpawnTruck()
        wait(4)
        GetInsideOfTruck()
        wait(3)
        RemoveTrailerFromTruck()
        wait()
        wait(0.5)
        TruckFarm(true)
        CountTimer()
    end

    function TakeEarlyPoint()
        local waypointPosition = game:GetService("Workspace").Etc.Waypoint.Waypoint.Position
        local playerName = game.Players.LocalPlayer.Name
        local carIdentifier = "sCar"
        
        local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(waypointPosition)
        local starterPrompt = game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt
        for i = 1, 5 do
            fireproximityprompt(starterPrompt)
        end
    end

    function SpawnTruck()
        local waypointPosition = game.Workspace.Etc.Job.Truck.Spawner.Part.Position
        local playerName = game.Players.LocalPlayer.Name
        local carIdentifier = "sCar"
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypointPosition)

        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
        wait(1)
        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
    end

    function GetInsideOfTruck()
        local playerName = game.Players.LocalPlayer.Name
        local carIdentifier = "sCar"
        local truckDriveSeat = game:GetService("Workspace").Vehicles[playerName .. carIdentifier].DriveSeat
        local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(truckDriveSeat.Position)
        wait(1.5)
        local promptDriveSeat = truckDriveSeat.PromptDriveSeat
        fireproximityprompt(promptDriveSeat)
        wait(0.5)
        if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil or game.Players.LocalPlayer.Character.Humanoid.SeatPart.Name ~= "DriveSeat" then
            fireproximityprompt(promptDriveSeat)
            wait(0.5)
        end
    end

    function RemoveTrailerFromTruck()
        local playerName = game.Players.LocalPlayer.Name
        local carIdentifier = "sCar"
        local playerCar = game.Workspace.Vehicles[playerName .. carIdentifier]
        for _, descendant in pairs(playerCar:GetDescendants()) do
            if descendant.Name == "Trailer1" then
                descendant:Destroy()
            end
        end
    end

    function TruckFarm(value)
        task.spawn(function()
            for i = 1, truck_amount_teleport do
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil or game.Players.LocalPlayer.Character.Humanoid.SeatPart.Name ~= "DriveSeat" then
                    return false
                end
                
                StartCountdown()

                local Waypoint = game.Workspace.Etc.Waypoint.Waypoint.BillboardGui.TextLabel.Text
                if Waypoint == "PT.CDID Cargo Cirebon" then
                    local playerName = game.Players.LocalPlayer.Name
                    local carIdentifier = "sCar"
                    local playerCar = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]
                    playerCar:SetPrimaryPartCFrame(CFrame.new(-21803.8867, 1046.98877, -27817.0586, 0, 0, -1, 0, 1, 0, 1, 0, 0))
                    game.Workspace.Gravity = -5
                    wait(12)
                    game.Workspace.Gravity = 500
                else
                    local waypointPosition = game:GetService("Workspace").Etc.Waypoint.Waypoint.Position
                    local playerName = game.Players.LocalPlayer.Name
                    local carIdentifier = "sCar"
                    local playerCar = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]
                    
                    playerCar:SetPrimaryPartCFrame(CFrame.new(waypointPosition))
                    game.Workspace.Gravity = -5
                    wait(7)
                    game.Workspace.Gravity = 500
                end

                wait(2)
                wait(0.2)

                task.wait()
            end
        end)
    end


    function StartCountdown()
        local cirebon = workspace.Etc.Waypoint.Waypoint.BillboardGui.TextLabel.Text
        
        for i = truck_cooldown_teleport, 1, -1 do
            wait(1)
        end
        
    end

    function CheckStartJob()
        local waypoint = game.Workspace.Etc.Waypoint.Waypoint
        if waypoint and waypoint.BillboardGui and waypoint.BillboardGui.TextLabel then
            local labelText = waypoint.BillboardGui.TextLabel.Text
            if labelText == "PT.Shad Cirebon" then
                StartJob()
            end
        else
        end
    end

    function GetWaypointName()
        local waypoint = game.Workspace.Etc.Waypoint.Waypoint
        if not waypoint then
            warn("Waypoint not found!")
            return nil
        end
        
        local waypointLabel = waypoint:FindFirstChild("BillboardGui") and waypoint.BillboardGui:FindFirstChild("TextLabel")
        if not waypointLabel then
            warn("Waypoint label not found!")
            return nil
        end
        
        local waypointName = waypointLabel.Text
        return waypointName
    end
end



function TimeTrialJakarta()
    fireproximityprompt(workspace.Etc.Race.TimeTrial.Start.Prompt)

    wait(10)

    local playerName = game.Players.LocalPlayer.Name
    local playerCar = game:GetService("Workspace").Vehicles[playerName .. "sCar"]

    if playerCar == nil then
        print("Kendaraan player tidak ditemukan!")
        return
    end

    wait(5)
    
    local checkpointCFrames = {
        CFrame.new(-4922.92578, 41.3567047, 363.310974, 2.05039978e-05, -0.86604017, -0.499974549, 1.00000012, 2.05039978e-05, 5.49852848e-06, 5.49852848e-06, -0.499974549, 0.866040111),
        CFrame.new(-3684.76489, 42.3644257, -526.991089, 2.07424164e-05, -0.57355696, -0.819165647, 0.99999994, 2.07424164e-05, 1.07884407e-05, 1.07884407e-05, -0.819165647, 0.573557019),
        CFrame.new(-2025.33301, 46.4877014, -556.023926, -8.22544098e-06, 0.642762423, -0.766065776, 1.00000012, 7.9870224e-06, -3.75509262e-06, 3.75509262e-06, -0.766065776, -0.642762542),
        CFrame.new(-1175.63403, 66.2507553, -29.6842384, -5.96046448e-07, 0.0871878564, -0.996191859, 1, 5.96046448e-07, -5.66244125e-07, 5.66244125e-07, -0.996191859, -0.087187767),
        CFrame.new(-799.506531, 47.0191269, 1184.70581, -8.10623169e-06, -0.642762303, -0.766065598, 1, -8.10623169e-06, -3.78489494e-06, -3.78489494e-06, -0.766065598, 0.642762303),
        CFrame.new(-1528.93933, 44.2638969, 2426.12964, 6.10947609e-05, -0.857243359, -0.514911354, 0.99999994, 6.10947609e-05, 1.69277191e-05, 1.69277191e-05, -0.514911354, 0.857243419),
        CFrame.new(-3078.01807, 44.0052948, 5127.05176, 3.12328339e-05, -0.941413283, -0.33725512, 1, 3.12328339e-05, 5.42402267e-06, 5.42402267e-06, -0.33725512, 0.941413283),
        CFrame.new(-3217.22119, 46.7632523, 5518.37402, -2.31266022e-05, 0.620019555, 0.78458631, 1, 2.31266022e-05, 1.12056732e-05, -1.12056732e-05, 0.78458631, -0.620019674),
        CFrame.new(-3430.00879, 45.0853043, 5427.7749, -4.78029251e-05, 0.710414648, -0.703783453, 1.00000012, 4.76837158e-05, -1.96695328e-05, 1.96695328e-05, -0.703783453, -0.710414648),
        CFrame.new(-4060.83228, 46.4606247, 5065.17041, -8.58306885e-06, 0.0378802717, 0.9992823, 1, 8.58306885e-06, 8.22544098e-06, -8.22544098e-06, 0.9992823, -0.0378801823),
        CFrame.new(-4198.26904, 46.3244781, 5102.25586, 2.84910202e-05, -0.988597989, 0.150579125, 1, 2.84910202e-05, -2.16066837e-06, -2.16066837e-06, 0.150579125, 0.988597989),
        CFrame.new(-4165.93652, 46.7464714, 4843.74316, 1.54972076e-06, -0.422563195, 0.906333447, 1, 1.54972076e-06, -9.83476639e-07, -9.83476639e-07, 0.906333447, 0.422563195),
        CFrame.new(-4751.43848, 43.617115, 4931.35645, -6.43730164e-06, 0.173615277, 0.984813631, 1, 6.37769699e-06, 5.42402267e-06, -5.42402267e-06, 0.984813631, -0.173615336),
        CFrame.new(-5305.7793, 46.3041267, 4970.16943, 4.0948391e-05, 0.966288626, -0.257461786, 1.00000012, -4.12464142e-05, 5.37931919e-06, -5.37931919e-06, -0.257461786, -0.966288805),
        CFrame.new(-5081.28174, 45.4488754, 4867.95801, -1.66893005e-06, 0.198071688, 0.980187535, 1, 1.66893005e-06, 1.34110451e-06, -1.34110451e-06, 0.980187535, -0.198071718),
        CFrame.new(-4683.97754, 46.3174934, 4793.32666, -5.24520874e-06, 0.203165472, 0.979144454, 1, 5.1856041e-06, 4.2617321e-06, -4.2617321e-06, 0.979144454, -0.203165531),
        CFrame.new(-4192.91455, 45.5189095, 4713.36572, 2.10404396e-05, 0.957543075, 0.288290054, 0.99999994, -2.0980835e-05, -3.09944153e-06, 3.09944153e-06, 0.288290054, -0.957543135),
        CFrame.new(-4277.23633, 43.0489655, 4203.81738, -4.42266464e-05, -0.999355972, 0.0358850844, 1, -4.42266464e-05, 7.93486834e-07, 7.93486834e-07, 0.0358850844, 0.999355912),
        CFrame.new(-4404.104, 45.3556252, 3396.99365, 4.29153442e-05, -0.984804988, 0.173663557, 1, 4.29153442e-05, -3.75509262e-06, -3.75509262e-06, 0.173663557, 0.984805048),
        CFrame.new(-4739.25293, 41.2888908, 1538.89795, 4.29153442e-05, -0.984804988, 0.173663557, 1, 4.29153442e-05, -3.75509262e-06, -3.75509262e-06, 0.173663557, 0.984805048),
    }


    for i = 1, #checkpointCFrames do
        local checkpointCFrame = checkpointCFrames[i]
        playerCar:SetPrimaryPartCFrame(checkpointCFrame)

        wait(1)
    end

    wait(56)

    local checkpointCFrame = CFrame.new(-4839.61328, 44.5184326, 945.549805, 1.57356262e-05, -0.986318946, 0.164848655, 1.00000012, 1.57356262e-05, -1.31875277e-06, -1.31875277e-06, 0.164848655, 0.986318886)
    playerCar:SetPrimaryPartCFrame(checkpointCFrame)

end




SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()