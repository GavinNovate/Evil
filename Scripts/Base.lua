EvilNpc = GameMain:NewMod("EvilNpc");--先注册一个新的MOD模块

function EvilNpc:HasNpc(name)
    for i=0,ThingMgr.NpcList.Count-1 do
        if ThingMgr.NpcList[i]:GetName()==name then
            return true
        end
    end
	return false
end

function EvilNpc:FindNpc(name)
    for i=0,ThingMgr.NpcList.Count-1 do
        if ThingMgr.NpcList[i]:GetName()==name then
            return ThingMgr.NpcList[i]
        end
    end
	return nil
end

function EvilNpc:AddReincarnate(id)
    local npc = CS.XiaWorld.NpcRandomMechine.MakeReincarnateNpc(id)
    npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.FLAG_ISVISTOR, 1)
    npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.WaitHelping, 1)
    npc:ChangeRank(CS.XiaWorld.g_emNpcRank.Worker, true, false, true)
    npc.PropertyMgr.RelationData:RemoveAllRelationShip()
    npc.PropertyMgr.RelationData.m_mapNameCache:Clear()
    NpcMgr:AddNpc(npc,Map:RandomBronGrid(),Map,g_emFightCamp.Friend)

    local npc = CS.XiaWorld.NpcRandomMechine.MakeReincarnateNpc(80001)
    --npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.FLAG_ISVISTOR, 1)
    npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.WaitHelping, 1)
    npc:AddModifier("SysVistorModifier",1,false,1,600)
    npc:ChangeRank(CS.XiaWorld.g_emNpcRank.Worker, true, false, true)
    npc.PropertyMgr.RelationData:RemoveAllRelationShip()
    npc.PropertyMgr.RelationData.m_mapNameCache:Clear()
    ThingMgr:EquptNpc(npc, 0, CS.XiaWorld.g_emNpcRichLable.Normal, true, false, 0, 0)
    NpcMgr:AddNpc(npc,Map:RandomBronGrid(),Map,g_emFightCamp.Friend)

    local npcs = CS.System.Collections.Generic["List`1[XiaWorld.Thing]"]()
    npcs:Add(npc)
    MessageMgr:AddMessage(68061501,npcs)
    return npc
end
