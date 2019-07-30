local tbExample = GameMain:NewMod("Evil");--先注册一个新的MOD模块

function tbExample:OnInit()
	print("Evil init");
	local npc = CS.XiaWorld.NpcRandomMechine.MakeReincarnateNpc(80001);	--添加指定轮回者
	NpcMgr:AddNpc(npc,0,Map,g_emFightCamp.Friend);		--添加轮回者到玩家阵营
end

function tbExample:OnSetHotKey()
	print("Example OnSetHotKey");

	--ID为快捷键注册时的编码，编码需要是唯一的，不可为空
	--Name为快捷键的名称，会显示到快捷键面板上，需要将本文件转换为UTF-8才可使用中文
	--Type为快捷键所属类别，快捷键会根据类别自动分类，不可为空
	--InitialKey1为快捷键的第一组按键，使用"+"进行连接组合键位，键位请阅读快捷键列表找到所需要的键盘编码，可以为空
	--InitialKey2为快捷键的第二组按键，使用"+"进行连接组合键位，键位请阅读快捷键列表找到所需要的键盘编码，可以为空
	--快捷键有区分大小写，请按快捷键列表的键盘编码输入
	local tbHotKey = { {ID = "Test" , Name = "Mod测试按键" , Type = "Mod", InitialKey1 = "Y" , InitialKey2 = "Y" } };

	return tbHotKey;
end

function tbExample:OnHotKey(ID,state)

	--ID为快捷键注册时的编码，系统识别快捷键的唯一标识
	--state为快捷键当前操作状态，按下"down"，持续"stay"，离开"up"
	--print(ID);
	if ID == "Test" and state == "down" then
		local npc = CS.XiaWorld.NpcRandomMechine.MakeReincarnateNpc(80001);						-- 添加指定轮回者
		npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.FLAG_ISVISTOR, 1);
		npc:AddSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.WaitHelping, 1);
		NpcMgr:AddNpc(npc,Map:RandomBronGrid(),Map,g_emFightCamp.Friend);						-- 添加轮回者到玩家阵营
		ThingMgr:EquptNpc(npc, 0, CS.XiaWorld.g_emNpcRichLable.Richest, false, true, 0, 0);		-- 给NPC添加随机装备
	end

end
