-- SCROLL TO BOTTOM ----------------------------------------------------

Osc = {}
O = Osc
Osc.__index = Osc

function Osc.new()
    local self = setmetatable({}, Osc)
    self.__gate = Gate.new()
    self.__phasor = Phasor.new()
    self.__phase = 0
    self.hz = 1
    self.phase_offset = 0
    self.sync = 0
    self.shape = 0
    return self
end

function Osc:update()
    self.__phase = self.__phasor:audio(
        self.hz,
        self.__gate:to_pulse(self.sync)
    ) + self.phase_offset * Math.pi2
end

function Osc:sine()
    return math.sin(self.__phase)
end

function Osc:triangle()
    return math.abs(
        ((self.__phase + Math.hpi) % Math.pi2 / Math.pi2 * 2 - 1)
    ) * -2 + 1
end

function Osc:square()
    local state = self.__phase < math.pi
    if state then return 1 else return -1 end
end

function Osc:saw()
    return (self.__phase + Math.hpi) % Math.pi2 / Math.pi2 * 2 - 1
end
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
Math = {}
M = Math

Math.pi2 = math.pi * 2
Math.hpi = math.pi * 0.5
Math.qpi = math.pi * 0.25
Phasor = {}
P = Phasor
Phasor.__index = Phasor

function Phasor.new()
    local self = setmetatable({}, Phasor)
    self.phase = 0
    return self
end

function Phasor:audio(hz, sync)
    local phase_increment = hz / sampleRate * Math.pi2
    self.phase = self.phase + phase_increment
    if self.phase >= Math.pi2 or sync > 0 then
        self.phase = 0
    end
    return self.phase
end

function Phasor:control(frames, hz, sync)
    local phase_increment = hz / (sampleRate / frames) * Math.pi2
    self.phase = self.phase + phase_increment
    if self.phase >= Math.pi2 or sync > 0 then
        self.phase = 0
    end
    return self.phase
end
Util = {}
U = Util

function Util.update(array)
    for _, obj in ipairs(array) do
        obj:update()
    end
end


-- AUDULUS-DSP LIBRARY ----------------------------------------------
-- Version: 0.0.1-alpha
-- Updated: 2024.01.24
-- URL: https://github.com/markalanboyd/Audulus-DSP

----- Instructions -----
-- 1. TBD

-- CODE ----------------------------------------------------------------

function process(frames)
    -- Once per frame
    for i = 1, frames do
        -- Once per sample
    end
end

