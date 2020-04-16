--[[
文明6使用Havok引擎。Havok引擎执行Havok脚本，Havok脚本是lua的变种。

文明6脚本有的地方标注了变量类型，如

function CreateGoalUI( goal:GoalItem )
	local inst:table = m_goalIM:GetInstance();
end

这是Havok脚本的特有功能。

为了获得完全的lua语法支持及错误检测能力，本脚本完全遵守lua，不使用Havok脚本的特有功能。
另外，本脚本的注释和智能提示写法符合的是Intellij Idea + EmmyLua插件的标准。
]]


--- OnBuildingConstructed desc
---@param cityType number 如city center, campus, harbor等
function OnBuildingConstructed(playerID, cityType, buildingID, plotID, bOriginalConstruction)
    -- https://www.lua.org/manual/5.2/manual.html#6.1
    -- print可以接受任意数量的参数
    -- print("OnBuildingConstructed", playerID, cityType, buildingID, plotID, bOriginalConstruction)
	local building = GameInfo.Buildings[buildingID]

	local advancedBallisticsInfo= GameInfo.Technologies['TECH_ADVANCED_BALLISTICS']


	local player=Players[playerID]
    local techs = player:GetTechs()
	if techs:HasTech(advancedBallisticsInfo.Index) or techs:HasBoostBeenTriggered(advancedBallisticsInfo.Index) then
		print(techs:HasTech(advancedBallisticsInfo.Index), techs:HasBoostBeenTriggered(advancedBallisticsInfo.Index))
		return
	end



    if building ~= nil and (building.Name == 'LOC_BUILDING_POWER_PLANT_NAME' or building.Name == 'LOC_BUILDING_LOCAL_POWER_PLANT_NAME') then
        print('发电厂造好了')

        if player.PowerPlantCount == nil then
			player.PowerPlantCount=0
			local localPowerPlantInfo = GameInfo.Buildings['BUILDING_LOCAL_POWER_PLANT']
			local regionalPowerPlantInfo = GameInfo.Buildings['BUILDING_POWER_PLANT']
			print(localPowerPlantInfo,localPowerPlantInfo.Index)

			for _, city in player:GetCities():Members() do
				local cityBuildings= city:GetBuildings()
				if cityBuildings:HasBuilding(localPowerPlantInfo.Index) then
					player.PowerPlantCount=player.PowerPlantCount+1
					print(city:GetName(),'has local')
				elseif cityBuildings:HasBuilding(regionalPowerPlantInfo.Index) then
					player.PowerPlantCount=player.PowerPlantCount+1
					print(city:GetName(),'has regional')
				end
			end
        else
            player.PowerPlantCount = player.PowerPlantCount + 1
        end

		print(player.PowerPlantCount)
		if player.PowerPlantCount>=2 then
			print('有两座发电厂或本地发电厂了')

			techs:TriggerBoost(advancedBallisticsInfo.Index)
		end
    end
end

--[[
--- OnBuildingAddedToMap desc
---@param plotX number
---@param plotY number
---@param buildingType number
---@param playerType number
---@param pctComplete number
---@param bPillaged number
function OnBuildingAddedToMap(plotX, plotY, buildingType, playerType, pctComplete, bPillaged)
	print('OnBuildingAddedToMap', plotX, plotY, buildingType, playerType, pctComplete, bPillaged);
end
]]

print("LocalFactory_OnBuildingAddedToMap")

--Events.BuildingAddedToMap.Add(OnBuildingAddedToMap);
GameEvents.BuildingConstructed.Add(OnBuildingConstructed)

--[[

 LocalFactory: OnBuildingConstructed	0	655366	20	3457	true
 LocalFactory: OnBuildingAddedToMap		13	41	20	0	655366	0
]]