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
    ) + self.phase_offset * Math.two_pi
end

function Osc:sine()
    local pure_sine = math.sin(self.__phase)
    return (1 - self.shape) * pure_sine +
        self.shape * math.sin(
            pure_sine * Math.half_pi * (self.shape * self.shape * 19 + 1)
        )
end

function Osc:pure_sine()
    return math.sin(self.__phase)
end

function Osc:triangle()
    local pure_triangle = math.abs(
        ((self.__phase + Math.half_pi) % Math.two_pi / Math.two_pi * 2 - 1)
    ) * -2 + 1
    local factor = self.shape * 4 + 1
    local rescale = math.max(((1 - self.shape) * 1.3), 1)
    return Math.tanh(pure_triangle * factor) * rescale
end

function Osc:pure_triangle()
    return math.abs(
        (self.__phase + Math.half_pi / Math.two_pi * 2 - 1)
    ) * -2 + 1
end

function Osc:square()
    local state = self.__phase < math.pi
    if state then return 1 else return -1 end
end

function Osc:saw()
    return (self.__phase + Math.half_pi) % Math.two_pi / Math.two_pi * 2 - 1
end
