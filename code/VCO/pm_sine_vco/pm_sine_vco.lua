--[[

Phase Modulation Sine Wave VCO
by Mark Boyd
v 1.0
March 28, 2023
http://www.markboyd.dev

This script generates a sine wave at a set frequency and allows the
frequency to be modulated by a phase modulation signal.

The refHz variable is set to 440, which is the standard frequency for
concert A. The twoPi variable is set to 2 * pi. This is because it's
best practice to precalculate static values outside of the loop, saving
processing time.

The phase variable is initialized to 0. This is the variable that acts
as the accumulator for the sine wave.

Inside the process function, the hz variable is set to the refHz
variable multiplied by 2 raised to the power of the octIn value. This
is because the octIn value is a linearized pitch value between -5 and 5,
and we need to convert it to a frequency value.

The pm variable is set to the pmIn value multiplied by pi. This is
because the pmIn value is a linearized phase modulation value between
-1 and 1, and we need to convert it to a phase modulation value in
radians.

The phaseIncrement variable is calculated by dividing the hz variable
by the sampleRate value and multiplying by twoPi. This is the amount
that the phase variable is incremented by each time the process
function is called.

Next, the phase variable is incremented by the phaseIncrement variable
plus the pm variable.

Finally, the audioOut value is set to the sine of the phase variable
plus the pm variable, generating a phase modulated sine wave.

--]]

-- Inputs: octIn pmIn sampleRate
-- Outputs: audioOut

refHz = 440
twoPi = 2 * math.pi
phase = 0

function process(frames)
    for i = 1, frames do
        local hz = refHz * 2 ^ octIn[i]
        local pm = pmIn[i] * math.pi
        local phaseIncrement = hz / sampleRate[i] * twoPi
        phase = phase + phaseIncrement
        audioOut[i] = math.sin(phase + pm)
    end
end

