EvilNpc = GameMain:NewMod("EvilNpc");

-- 判断门派是否含有指定名称的NPC
function EvilNpc:HasNpc(name)
  for k,v in pairs(ThingMgr.NpcList) do
    if name == v:GetName() then
      return true
    end
  end
  return false
end

-- 获得指定名称NPC的信息
function EvilNpc:FindNpc(name)
  for k,v in pairs(ThingMgr.NpcList) do
    if name == v:GetName() then
      return v
    end
  end
  return nil
end

-- 添加指定轮回者
function EvilNpc:AddReincarnate(id)
    local npc = CS.XiaWorld.NpcRandomMechine.MakeReincarnateNpc(id)
    npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.WaitHelping, 1)
    npc:AddModifier("SysVistorModifier",1,false,1,600)
    npc.PropertyMgr.RelationData:RemoveAllRelationShip()
    npc.PropertyMgr.RelationData.m_mapNameCache:Clear()
    ThingMgr:EquptNpc(npc, 0, CS.XiaWorld.g_emNpcRichLable.Normal, true, false, 0, 0)
    NpcMgr:AddNpc(npc,Map:RandomBronGrid(),Map,g_emFightCamp.Friend)

    local npcs = CS.System.Collections.Generic["List`1[XiaWorld.Thing]"]()
    npcs:Add(npc)
    MessageMgr:AddMessage(68061501,npcs)
    return npc
end

-- 获取指定轮回者的名字
function EvilNpc:GetReincarnateName(id)
  return NpcMgr:GetReincarnateDataByID(id).LastName..NpcMgr:GetReincarnateDataByID(id).FristName
end

-- 显示轮回者面板
function EvilNpc:ShowReincarnatesBox(world,title,content,ids,callback)
  local names = {}
  for k,v in pairs(ids) do
    names[k] = EvilNpc:GetReincarnateName(v)
  end
  world:ShowStoryBox(content,title,names,
    function(index)
      local id = ids[index+1]
      local name = names[index+1]
      callback(id,name)
    end
  );
end

-- 显示打探行踪面板
function EvilNpc:ShowInquireReincarnatesBox(me,world,ids)
  local i = me.npcObj.Name
  EvilNpc:ShowReincarnatesBox(world,"打探行踪",""..i.."决定在此处打听一些人的行踪。",ids,
    function(id,name)
      if EvilNpc:HasNpc(name) then
        world:ShowStoryBox(""..i.."在此打听了"..name.."的行踪，得知其在很久之前就没了消息，据说是加入了某个修仙门派。","打探行踪")
      else
        EvilNpc:AddReincarnate(id)
        world:ShowStoryBox(""..i.."在此打听了"..name.."的行踪，得知其在近日游历到某个修仙门派做客。","打探行踪")
      end
    end
  )
end

-- 随机招揽弟子
function EvilNpc:AddRandomReincarnate(me,world,idStart,idEnd)
  local i = me.npcObj.Name
  local id = world:RandomInt(idStart,idEnd + 1)
  local name = EvilNpc:GetReincarnateName(id)
  if EvilNpc:HasNpc(name) then
    world:ShowStoryBox(""..i.."听说"..name.."根骨奇佳，是一个修仙的奇才，然得知其在很久之前就没了消息，据说是加入了某个修仙门派。","招揽弟子")
  else
    EvilNpc:AddReincarnate(id)
    world:ShowStoryBox(""..i.."听说"..name.."根骨奇佳，是一个修仙的奇才，然得知其在近日游历到某个修仙门派做客。","招揽弟子")
  end
end
