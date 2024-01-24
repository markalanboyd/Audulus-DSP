Phasor = {}
P = Phasor
Phasor.__index = Phasor

function Phasor.new()
    local self = setmetatable({}, Phasor)

    self.phase = 0

    return self
end

function Phasor:audio(hz)
    local phase_increment = hz / sampleRate * Math.pi2
    self.phase = self.phase + phase_increment
    if self.phase >= Math.pi2 then
        self.phase = 0
    end
    return self.phase
end

function Phasor:control(frames, hz)
    local phase_increment = hz / (sampleRate / frames) * Math.pi2
    self.phase = self.phase + phase_increment
    if self.phase >= Math.pi2 then
        self.phase = 0
    end
    return self.phase
end
