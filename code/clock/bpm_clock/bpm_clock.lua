--[[

BPM Clock
by Mark Boyd
v 1.1
April 13th, 2023
http://www.markboyd.dev

This script expands on the clock script to create a clock that uses a
control input to set the BPM.

First we declare a minimum and maximum value for BPM and precalculate
the range between them.

Then we then declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, but before the loop, we calculate the
hz value from the BPM value. We then calculate the increment value
from the hz value and the sample rate.

Next, inside the loop, we add the increment value to the accumulator
variable. If the accumulator variable is greater than or equal to 1,
we set it back to 0.

Finally, we check if the accumulator variable is less than or equal to
0.5. If it is, we set the gateOut to 1. If it is not, we set the
gateOut to 0.

--]]

-- Inputs: bpmControlIn 
-- Outputs: gateOut

minBPM = 60
maxBPM = 200
bpmRange = maxBPM - minBPM

acc = 0

function process(frames)
	local hz = (bpmControlIn[1] * bpmRange + minBPM) / 60
	local incr = hz / sampleRate
    for i = 1, frames do
        acc = acc + incr
        if acc >= 1 then acc = 0 end
        gateOut[i] = acc <= 0.5 and 1 or 0
    end
end