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
