--[[

Phasor
by Mark Boyd
v 1.0
March 29, 2023
http://www.markboyd.dev

This script uses a phasor to create a square wave that we can use as a
clock signal.

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

Finally, we use a ternary operator to set the gateOut value to 1 if the
phase variable is less than pi, and 0 if it is greater than or equal to
pi.

--]]

-- Inputs: hzIn sampleRate 
-- Outputs: phasorOut

twoPi = 2 * math.pi
phase = 0

function process(frames)
    for i = 1, frames do
        phaseIncrement = hzIn[i] / sampleRateIn[i] * twoPi
        phase = phase + phaseIncrement
		if phase >= twoPi then phase = 0 end
        gateOut[i] = phase < math.pi and 1 or 0
    end
end
