Gate = {}
G = Gate
Gate.__index = Gate

function Gate.new()
    local self = setmetatable({}, Gate)
    self.state = 0
    self.latch = false
    return self
end

function Gate:to_pulse(gate)
    local gate_high = gate > 0
    if not gate_high then
        self.latch = false
        return self.state
    end
    if not self.latch then
        self.state = 1
        self.latch = true
    else
        self.state = 0
    end
    return self.state
end
