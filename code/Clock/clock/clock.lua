--[[

Clock
by Mark Boyd
v 1.0
March 29, 2023
http://www.markboyd.dev

This script uses an accumulator to create a 0 to 1 saw wave which we
then use to create a square wave.

First we declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, we calculate the incr (increment) variable 
by dividing the hzIn value by the sampleRateIn value.

Then, we add the incr variable to the acc variable. If the acc variable
is greater than or equal to 1, we set it to 0.

Finally, we use a ternary operator to set the gateOut value to 1 if the
phase variable is less than or equal to 0.5, and 0 if it is greater
than 0.5.

--]]

-- Inputs: hzIn sampleRate 
-- Outputs: phasorOut

acc = 0

function process(frames)
    for i = 1, frames do
        local incr = hzIn[i] / sampleRateIn[i]
        acc = acc + incr
		if acc >= 1 then acc = 0 end
        gateOut[i] = acc <= 0.5 and 1 or 0
    end
end
