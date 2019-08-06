EvilNpc = GameMain:NewMod("EvilNpc");--先注册一个新的MOD模块

function EvilNpc:HasNpc(name)
    for i=0,ThingMgr.NpcList.Count-1 do
        if ThingMgr.NpcList[i]:GetName()==name then
            return true
        end
    end
	return false
end
