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
