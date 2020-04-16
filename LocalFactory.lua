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


---@param plotX number
---@param plotY number
---@param buildingType number
---@param playerType number
---@param pctComplete number
---@param bPillaged number

function OnBuildingAddedToMap(plotX, plotY, buildingType, playerType, pctComplete, bPillaged)
	print(plotX);
	print(plotY);
	print(buildingType);
	print(playerType);
	print(pctComplete);
	print(bPillaged);
end

print("LocalFactory_OnBuildingAddedToMap");

Events.BuildingAddedToMap.Add(OnBuildingAddedToMap);
