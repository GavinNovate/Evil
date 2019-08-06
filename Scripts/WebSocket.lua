local tbTable = GameMain:GetMod("TestWebSocket");

function tbTable:OnEnter()
	return
	self.ws = CS.WebSocketSharp.WebSocket("ws://localhost:8080/socket");
	self.ws:OnMessage("+", self.OnMessage);
	self.ws:OnOpen("+", self.OnOpen);
	self.ws:OnClose("+", self.OnClose);
	self.ws:OnError("+", self.OnError);
	self.ws:Connect ();
	self.ws:SendString ("Hello Server");
	--self.ws:SendByte (Byte);
	--self.ws:SendFileInfo (FileInfo);
	--self.ws:SendStream (Stream,int);


end

function tbTable.OnMessage(obj, e)
	--print("OnMessage:"..e.Data);
	self.ws:SendString ("从修仙模拟器发挥来的消息："..e.Data);
end

function tbTable.OnOpen()
	print("OnOpen");
end

function tbTable.OnClose(obj, e)
	print("OnClose");
end

function tbTable.OnError(obj, e)
	print("OnError:"..e.Message);
end

function tbTable:OnLeave()
	self.ws:OnMessage("-", self.OnMessage);
	self.ws:OnOpen("-", self.OnOpen);
	self.ws:OnClose("-", self.OnClose);
	self.ws:OnError("-", self.OnError);
	self.ws:Close();
end
