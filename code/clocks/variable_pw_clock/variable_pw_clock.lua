--[[

Variable Pulse Width Clock
by Mark Boyd
v 1.1
April 13th, 2023
http://www.markboyd.dev

This script uses an accumulator to create a 0 to 1 saw wave which we
then use to create a square wave clock. It also features a pulse width
control input that is sampled at the beginning of each cycle. This 
prevents the pulse width from changing during the cycle.

First we declare a variable called maxHz and set it to 20. This is the
maximum speed of the clock in Hz.

Then we declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, but before the loop, we calculate the incr
(increment) variable from the hzIn value and the sample rate. The hzIn
value is cubed and then multiplied by maxHz to create a more exponential
curve.

Then, inside the loop, we check if the acc variable is equal to 0. If it
is, we set the pw (pulse width) variable to the pwCtrlIn value.
    
Next, we add the incr variable to the acc variable. If the acc variable
is greater than or equal to 1, we set it to 0.

Finally, we use a ternary operator to set the gateOut value to 1 if the
acc variable is less than or equal to pwCtrl, and 0 if it is greater.

--]]

-- Inputs: hzIn pwCtrlIn sampleRate 
-- Outputs: gateOut

maxHz = 20
acc = 0

function process(frames)
    local incr = hzIn[1] ^ 3 * maxHz / sampleRate
    for i = 1, frames do
        if acc == 0 then
            pw = pwCtrlIn[i]
        end
        
        acc = acc + incr
        if acc >= 1 then acc = 0 end
        gateOut[i] = acc <= pw and 1 or 0
    end
end
