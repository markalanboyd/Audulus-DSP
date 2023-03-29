--[[

BPM Clock
by Mark Boyd
v 1.0
March 29, 2023
http://www.markboyd.dev

This script expands on the clock script to create a clock that accepts
a BPM value as input. The BPM value is then converted to a frequency
value and used to create a square wave.

First we declare a minimum and maximum value for BPM and precalculate
the range between them.

Then we then declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, we calculate the hz variable by multiplying
the bpmControlIn value by the bpmRange variable and adding the minBPM
variable. We then divide the hz variable by 60 to convert it to a
frequency value.
    
Next, we calculate the incr (increment) variable by dividing the hz 
value by the sampleRate value.

Then, we add the incr variable to the acc variable. If the acc variable
is greater than or equal to 1, we set it to 0.

Finally, we use a ternary operator to set the gateOut value to 1 if the
phase variable is less than or equal to 0.5, and 0 if it is greater
than 0.5.

--]]

-- Inputs: bpmControlIn sampleRate 
-- Outputs: gateOut

minBPM = 60
maxBPM = 200
bpmRange = maxBPM - minBPM

acc = 0

function process(frames)
    for i = 1, frames do
        local hz = (bpmControlIn[i] * bpmRange + minBPM) / 60
        local incr = hz / sampleRate[i]
        acc = acc + incr
		if acc >= 1 then acc = 0 end
        gateOut[i] = acc <= 0.5 and 1 or 0
    end
end
