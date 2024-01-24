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
