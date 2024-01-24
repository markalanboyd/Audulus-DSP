Osc = {}
O = Osc
Osc.__index = Osc

function Osc.new()
    local self = setmetatable({}, Osc)
    self.phasor = Phasor.new()
    return self
end

function Osc:sine(hz, phase_offset)
    local po = phase_offset or 0
    return math.sin(
        self.phasor:audio(hz) + po
    )
end
