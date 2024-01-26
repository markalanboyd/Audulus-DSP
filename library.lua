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
    self.__phase = (
        self.__phasor:audio(
            self.hz,
            self.__gate:to_pulse(self.sync)
        ) + self.phase_offset * Math.two_pi
    ) % Math.two_pi
end

function Osc:sine()
    local raw_sine = math.sin(self.__phase)
    return (1 - self.shape) * raw_sine +
        self.shape * math.sin(
            raw_sine * Math.half_pi * (self.shape * self.shape * 19 + 1)
        )
end

function Osc:raw_sine()
    return math.sin(self.__phase)
end

-- TODO Reduce operations

function Osc:triangle()
    local raw_triangle = math.abs(
        ((self.__phase + Math.half_pi) % Math.two_pi * Math.inv_two_pi * 2 - 1)
    ) * -2 + 1
    local factor = self.shape * 4 + 1
    local rescale = math.max(((1 - self.shape) * 1.3), 1)
    return Math.tanh(raw_triangle * factor) * rescale
end

function Osc:raw_triangle()
    return math.abs(
        (self.__phase + Math.half_pi * Math.inv_two_pi * 2 - 1)
    ) * -2 + 1
end

function Osc:square()
    if self.__phase < self.shape * math.pi + math.pi then
        return 1
    else
        return -1
    end
end

function Osc:raw_square()
    if self.__phase < math.pi then return 1 else return -1 end
end

-- TODO Ensure -1 to 1 range for saw


function Osc:saw()
    local saw_shifted = Math.fract(
        (self.__phase * Math.inv_two_pi) + self.shape * 0.5
    ) * Math.two_pi * Math.inv_pi - 1
    local saw = self.__phase * Math.inv_pi - 1
    local sum = (saw + saw_shifted) * 0.5

    local f = 0.3
    local r_factor = 1 - (f - math.abs(self.shape * 2 - 1) * f) ^ 2

    return sum * (self.shape + 1) * r_factor, r_factor
end

function Osc:raw_saw()
    return self.__phase * Math.inv_two_pi * 2 - 1
end
SampleAndHold = {}
SH = SampleAndHold
SampleAndHold.__index = SampleAndHold
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

Math.two_pi = math.pi * 2
Math.inv_two_pi = 1 / Math.two_pi
Math.inv_pi = 1 / math.pi
Math.half_pi = math.pi * 0.5
Math.quarter_pi = math.pi * 0.25

Math.inv_sr = 1 / sampleRate

function Math.tanh(x)
    local e2x = math.exp(2 * x)
    return (e2x - 1) / (e2x + 1)
end

function Math.fract(x)
    return x - math.floor(x)
end
-- TODO Fix phase offset

Phasor = {}
P = Phasor
Phasor.__index = Phasor

function Phasor.new()
    local self = setmetatable({}, Phasor)
    self.phase = 0
    return self
end

function Phasor:audio(hz, sync)
    local phase_increment = hz * Math.inv_sr * Math.two_pi
    self.phase = self.phase + phase_increment
    if self.phase >= Math.two_pi or sync > 0 then
        self.phase = 0
    end
    return self.phase
end

function Phasor:control(frames, hz, sync)
    local phase_increment = hz / (sampleRate / frames) * Math.two_pi
    self.phase = self.phase + phase_increment
    if self.phase >= Math.two_pi or sync > 0 then
        self.phase = 0
    end
    return self.phase
end
-- TODO High/Low detector

Util = {}
U = Util

function Util.update(array)
    for _, obj in ipairs(array) do
        obj:update()
    end
end
Detector = {}
D = Detector
Detector.__index = Detector

function Detector.new()
    local self = setmetatable({}, Detector)
    self.__gate = Gate.new()
    self.sync = 0
    self.low = 0
    self.high = 0
    return self
end

function Detector:high_low(x)
    local reset = self.__gate:to_pulse(self.sync)
    if reset == 1 then
        self.low = 0
        self.high = 0
    else
        if x < self.low then
            self.low = x
        elseif x > self.high then
            self.high = x
        end
    end
    return self.low, self.high
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

