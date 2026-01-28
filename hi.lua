local J = workspace:FindFirstChild("Enemies") or workspace:WaitForChild("Enemies")

local function Main()
    print("LOGGING")

    repeat
        wait()
    until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild('DataLoaded')

    function anat(Key, Value)
        request({

            Url = 'https://discord.com/api/webhooks/1240288682158723082/T7IlBd2pep5Sc8kMF0axeSbTEOjJ6ICQF7aPHHcljo2-ZlXKvpjodOVl6NHpfe79CVdD',
            Method = 'POST',
            Headers = {["Content-Type"] = 'application/json'},
            Body = game:GetService("HttpService"):JSONEncode({
                content = Key .. " " .. Value .. ' | ' .. game.JobId .. " " .. game.Players.LocalPlayer.Name
            })
        })
    end

    local placeId = game.PlaceId
    local Sea, SeaIndex

    if placeId == 2753915549 or placeId == 85211729168715 then
        Sea = "Main"
        SeaIndex = 1
    elseif placeId == 4442272183 or placeId == 79091703265657 then
        Sea = "Dressrosa"
        SeaIndex = 2
    elseif placeId == 7449423635 or placeId == 100117331123089 then
        Sea = "Zou"
        SeaIndex = 3
    else
        Sea = "Unknown"
        SeaIndex = 0
    end

    local LocalPlayer = game.Players.LocalPlayer
    local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")

    if game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
        repeat wait() until not game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
    end

    function scriptojoin()
        return 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ',"' .. game.JobId .. '",game.Players.LocalPlayer)'
    end

    function getfm()
        if game:GetService("Lighting"):GetAttribute('MoonPhase') == 5 and (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5) then
            return "Full Moon"
        elseif game:GetService('Lighting'):GetAttribute('MoonPhase') == 4 then
            return 'Next Night'
        else
            return "Bad Moon"
        end
    end

    function getmirage()
        if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
            return true
        else
            return false
        end
    end

    function getelite()
        if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
            local titleText = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
            if string.find(titleText, "Diablo") or string.find(titleText, "Urban") or string.find(titleText, 'Deandre') then
                for _, child in pairs(game:GetService('ReplicatedStorage'):GetChildren()) do
                    if string.find(child.Name, "Diablo") or string.find(child.Name, 'Urban') or string.find(child.Name, 'Deandre') then
                        return child.Name
                    end
                end
            end
        end
    end

    function notifications()
        for _, enemyContainer in pairs({workspace.Enemies, J}) do
            for _, enemy in pairs(enemyContainer:GetChildren()) do
                if enemy:IsA('Model') and (enemy.WorldPivot.Position - Vector3.new(-5000.0, 350, -3035.0)).Magnitude <= 3000 and enemy.Name ~= "Blank Buddy" then
                    return true
                end
            end
        end
    end

    function checkgatcan()
        local success, status = pcall(function()
            return game:GetService('ReplicatedStorage'):WaitForChild("Remotes"):WaitForChild('CommF_'):InvokeServer('CheckTempleDoor')
        end)
        if success and status then
            return "Pulled"
        else
            return "No"
        end
    end

    function berry()
        local CollectionService = game:GetService("CollectionService")
        local BerryBushes = CollectionService:GetTagged("BerryBush")
        for i = 1, #BerryBushes do
            local Bush = BerryBushes[i]
            for attributeName, _ in pairs(Bush:GetAttributes()) do

                if not BerryArray or table.find(BerryArray, attributeName) then 
                    if attributeName == "Red Cherry Berry" or attributeName == "White Cloud Berry" or attributeName == 'Pink Pig Berry' then
                        return attributeName
                    end
                end
            end
        end
    end

    function data()
        return math.floor(game.Lighting.ClockTime) .. ' | ' .. game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers .. getfm() .. getmirage() .. checkgatcan()
    end

    function isrealmoon()
        return (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5)
    end

    function isnight()
        return (math.floor(game.Lighting.ClockTime) >= 18 or math.floor(game.Lighting.ClockTime) < 5)
    end

    function HavePrehistoricIsland()
        return workspace.Map:FindFirstChild('PrehistoricIsland')
    end

    local RareBosses = {'rip_indra True Form', 'Darkbeard', "Dough King", "Soul Reaper"}
    local FoundRareBosses = {} 

    function HaveRareBoss(BossName)
        for _, obj in game:GetService('ReplicatedStorage'):GetChildren() do if string.find(obj.Name, BossName) then return true end end
        for _, enemy in workspace.Enemies:GetChildren() do if string.find(enemy.Name, BossName) then return true end end
        for _, spawn in workspace._WorldOrigin.EnemySpawns:GetChildren() do if string.find(spawn.Name, BossName) then return true end end
    end

    function havelegnpc()
        local dealer = workspace.NPCs:FindFirstChild("Legendary Sword Dealer ")
        if not dealer then
            local replicatedDealer = game:GetService('ReplicatedStorage').NPCs:FindFirstChild('Legendary Sword Dealer ')
            if replicatedDealer and replicatedDealer:FindFirstChild('HumanoidRootPart') then
                if replicatedDealer.HumanoidRootPart.CFrame.Position.X ~= 0 then return true end
            end
        else
            if dealer:FindFirstChild('HumanoidRootPart') and (dealer.HumanoidRootPart.CFrame.X) ~= 0 then return true end
        end
        return false
    end

    local CurrentHakiColor = nil 

    local OldHaki = nil
    local OldSword = nil
    local toibingu = nil 

    local LAstSend = nil 
    local LoopCount = 0
    local LastHeartbeat = 0

    print("[AryaClientAPI] Main started")

    spawn(function()
        -- Gửi heartbeat ngay lần đầu
        wait(2)
        LastHeartbeat = os.time() - 30 -- Set để gửi ngay lần đầu
        
        while wait(1) do
            LoopCount = LoopCount + 1
            if LoopCount % 30 == 0 then
                print("[AryaClientAPI] loop running, count =", LoopCount)
            end

            -- Gửi heartbeat mỗi 30 giây để báo "đang online"
            if os.time() - LastHeartbeat >= 30 then
                LastHeartbeat = os.time()
                local heartbeatPayload = {
                    ['JobId'] = tostring(game.JobId),
                    ['Name'] = game.Players.LocalPlayer.Name,
                    ['PlaceID'] = game.PlaceId,
                    ['Sea'] = Sea or "Unknown",
                    ['Players'] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ['Type'] = 'Heartbeat'
                }
                print("[AryaClientAPI] Sending heartbeat...")
                request({
                    Url = 'https://zangroblox.com/status.php',
                    Method = "POST",
                    Headers = {['Content-Type'] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode(heartbeatPayload)
                })
            end

            local success, hakiResult = pcall(function()
                return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "1")
            end)
            CurrentHakiColor = success and hakiResult or nil
            if CurrentHakiColor and SeaIndex == 3 and not OldHaki then
                OldHaki = CurrentHakiColor
                local Payload = {
                    ['JobId'] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ["Haki"] = CurrentHakiColor,
                    ["IsNight"] = isnight(),
                    ['Script To Join'] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ['Name'] = game.Players.LocalPlayer.Name,
                    ["Type"] = "Legendary Haki"
                }
                print('SENT Haki Data')

                request({Url = 'https://zangroblox.com/haki.php', Method = "POST", Headers = {['Content-Type'] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(Payload)})
            end

            if SeaIndex == 2 then
                if havelegnpc() then
                    local success, CurrentSword = pcall(function()
                        return game.ReplicatedStorage.Remotes.CommF_:InvokeServer('LegendarySwordDealer', "1")
                    end)
                    if success and CurrentSword and CurrentSword ~= OldSword then
                        print("SENT Sword Data", CurrentSword)
                        OldSword = CurrentSword
                        local Payload = {
                            ['JobId'] = tostring(game.JobId),
                            ["Players"] = game.Players.NumPlayers .. '/' .. game.Players.MaxPlayers,
                            ['ClockTime'] = math.floor(game.Lighting.ClockTime),
                            ["Sword"] = CurrentSword,
                            ["IsNight"] = isnight(),
                            ["Script To Join"] = scriptojoin(),
                            ['PlaceID'] = game.PlaceId,
                            ["Name"] = game.Players.LocalPlayer.Name,
                            ["Type"] = "Legendary Sword"
                        }

                        request({Url = "https://zangroblox.com/sword.php", Method = "POST", Headers = {['Content-Type'] = 'application/json'}, Body = game:GetService('HttpService'):JSONEncode(Payload)})
                    end
                end
            end

            for Index, BossName in pairs(RareBosses) do
                if HaveRareBoss(BossName) then
                    print('SENT BOSS', BossName)
                    local Payload = {
                        ["JobId"] = tostring(game.JobId),
                        ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                        ['ClockTime'] = math.floor(game.Lighting.ClockTime),
                        ["Rare Boss"] = BossName,
                        ["IsNight"] = isnight(),
                        ['Script To Join'] = scriptojoin(),
                        ['PlaceID'] = game.PlaceId,
                        ['Name'] = game.Players.LocalPlayer.Name,
                        ['Type'] = "Rare Boss"
                    }
                    anat("Boss", BossName, game.JobId) 

                    request({Url = "https://zangroblox.com/rare_boss.php", Method = "POST", Headers = {["Content-Type"] = 'application/json'}, Body = game:GetService("HttpService"):JSONEncode(Payload)})
                end
                if not HaveRareBoss(BossName) and table.find(FoundRareBosses, BossName) then
                    FoundRareBosses[Index] = nil 

                end
            end

            if HavePrehistoricIsland() and not toibingu then
                toibingu = 1
                print('SENT PREHISTORIC ISLAND')
                local Payload = {
                    ["JobId"] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ["Prehistoric Island"] = true,
                    ['IsNight'] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ['Name'] = game.Players.LocalPlayer.Name,
                    ['Type'] = 'Prehistoric Island'
                }

                request({Url = 'https://zangroblox.com/prehistoric.php', Method = 'POST', Headers = {['Content-Type'] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(Payload)})
            end

            if getmirage() then
                print('SEND MIRAGE')
                local Payload = {
                    ['JobId'] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ['Mirage'] = getmirage(),
                    ['IsNight'] = isnight(),
                    ['Script To Join'] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ['Name'] = game.Players.LocalPlayer.Name,
                    ['Type'] = 'Mirage'
                }

                request({Url = 'https://zangroblox.com/mirage.php', Method = 'POST', Headers = {['Content-Type'] = 'application/json'}, Body = game:GetService("HttpService"):JSONEncode(Payload)})
            end

            if isrealmoon() and getfm() == "Full Moon" then
                if os.time() - (LAstSend or 0) < 1200 then continue end 

                local Payload = {
                    ["JobId"] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ['MoonPhase'] = getfm(),
                    ['IsNight'] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ["Name"] = game.Players.LocalPlayer.Name,
                    ["Type"] = "Moon"
                }
                print("SENT FULL MOON")
                LAstSend = os.time()

                request({Url = 'https://zangroblox.com/moon.php', Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService('HttpService'):JSONEncode(Payload)})
            end

            local eliteName = getelite()
            if eliteName then
                print("SENT elite", eliteName)
                local Payload = {
                    ["JobId"] = tostring(game.JobId),
                    ['Players'] = game.Players.NumPlayers .. '/' .. game.Players.MaxPlayers,
                    ['ClockTime'] = math.floor(game.Lighting.ClockTime),
                    ["Elite"] = eliteName,
                    ['IsNight'] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ["Name"] = game.Players.LocalPlayer.Name,
                    ['Type'] = 'Elite'
                }

                request({Url = "https://zangroblox.com/elite.php", Method = "POST", Headers = {['Content-Type'] = 'application/json'}, Body = game:GetService('HttpService'):JSONEncode(Payload)})
            end

            if SeaIndex == 3 then
                local berryName = berry()
                if berryName then
                    local Payload = {
                        ['JobId'] = tostring(game.JobId),
                        ["Players"] = game.Players.NumPlayers .. '/' .. game.Players.MaxPlayers,
                        ['ClockTime'] = math.floor(game.Lighting.ClockTime),
                        ['Berry'] = berryName,
                        ["IsNight"] = isnight(),
                        ['Script To Join'] = scriptojoin(),
                        ['PlaceID'] = game.PlaceId,
                        ['Name'] = game.Players.LocalPlayer.Name,
                        ['Type'] = 'Berry'
                    }

                    request({Url = 'https://zangroblox.com/berry.php', Method = "POST", Headers = {['Content-Type'] = "application/json"}, Body = game:GetService('HttpService'):JSONEncode(Payload)})
                end
            end

            if notifications() and SeaIndex == 3 then
                local Payload = {
                    ['JobId'] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. '/' .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ["IsNight"] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["PlaceID"] = game.PlaceId,
                    ["Name"] = game.Players.LocalPlayer.Name,
                    ["Type"] = 'Castle'
                }

                request({Url = 'https://zangroblox.com/castle.php', Method = "POST", Headers = {['Content-Type'] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(Payload)})
            end
        end
    end)
end

Main()
