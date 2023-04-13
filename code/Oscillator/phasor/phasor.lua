--[[

Phasor
by Mark Boyd
v 1.1
April 13th, 2023
http://www.markboyd.dev

This script creates a phasor that outputs a value between 0 and 2 * pi.

We first create a variable called twoPi and set it to 2 * pi. This is
because it's best practice to precalculate static values outside of the
loop, saving processing time.

We also initialize the phase variable to 0. This is the variable that
acts as the accumulator for the phasor.

Inside the process function, we calculate the phaseIncrement variable by
dividing the hzIn value by the sampleRateIn value and multiplying by
twoPi.

Next, the phase variable is incremented by the phaseIncrement variable.

We then check to see if the phase variable is greater than or equal to
twoPi. If it is, we set the phase variable to 0. This is because the
phasor should reset to 0 when it reaches 2 * pi.

Finally, we set the phasorOut value to the phase variable.

--]]

-- Inputs: hzIn 
-- Outputs: phasorOut

twoPi = 2 * math.pi
phase = 0

function process(frames)
    phaseIncrement = hzIn[1] / sampleRate * twoPi
    for i = 1, frames do
        phase = phase + phaseIncrement
        if phase >= twoPi then phase = 0 end
        phasorOut[i] = phase
    end
end
