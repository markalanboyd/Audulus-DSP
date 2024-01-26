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
