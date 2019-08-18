local WebSocket = GameMain:NewMod("WebSocket")
--local messages = {}

testt ={}

function testt.t()
    print("t")
end

function testt:tt()
    self.t()
    print("tt")
end

function WebSocket:Connect(url)
    self:Disconnect()
    self.socket = CS.WebSocketSharp.WebSocket(url)
    self.socket:OnOpen("+", self.OnInternalOpen)
    self.socket:OnMessage("+", self.OnInternalMessage)
    self.socket:OnClose("+", self.OnInternalClose)
    self.socket:OnError("+", self.OnInternalError)
    self.socket:Connect()
end

function WebSocket.OnOpen()

end

function WebSocket:Disconnect()
    if self.socket ~= nil then
        self.socket:OnOpen("-", self.OnInternalOpen)
        self.socket:OnMessage("-", self.OnInternalMessage)
        self.socket:OnClose("-", self.OnInternalClose)
        self.socket:OnError("-", self.OnInternalError)
        self.socket:Close()
        self.socket = nil
    end
end

function WebSocket:OnEnter()
    -- Do Nothing
    self.messages = {}
end

function WebSocket:OnRender(_)
    local message = table.remove(self.messages)
    if message ~= nil then
        self.socket:SendString(message)
    end
end

function WebSocket:OnLeave()
    self:Disconnect()
end

function WebSocket.OnInternalOpen()
    table.insert(self.messages, "OPEN")
end

function WebSocket.OnInternalMessage(obj, e)
    table.insert(self.messages, "MESSAGE:" .. e.Data)
end

function WebSocket.OnInternalClose(obj, e)
    table.insert(self.messages, "CLOSE" .. e.Reason)
end

function WebSocket.OnInternalError(obj, e)
    table.insert(self.messages, "ERROR" .. e.Message)
end
