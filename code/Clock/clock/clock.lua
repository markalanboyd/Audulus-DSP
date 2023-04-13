--[[

Clock
by Mark Boyd
v 1.1
April 13th, 2023
http://www.markboyd.dev

This script uses an accumulator to create a 0 to 1 saw wave which we
then use to create a square wave clock.

First we declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, but before the loop, we calculate the
increment value from the hzIn value and the sample rate.

Then, inside the loop, we add the incr variable to the acc variable.
If the acc variable is greater than or equal to 1, we set it to 0.

Finally, we use a ternary operator to set the gateOut value to 1 if the
phase variable is less than or equal to 0.5, and 0 if it is greater
than 0.5.

--]]

-- Inputs: hzIn 
-- Outputs: gateOut

acc = 0

function process(frames)
    local incr = hzIn[1] / sampleRate
    for i = 1, frames do
        acc = acc + incr
		if acc >= 1 then acc = 0 end
        gateOut[i] = acc <= 0.5 and 1 or 0
    end
end
