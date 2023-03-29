--[[

Clock
by Mark Boyd
v 1.0
March 29, 2023
http://www.markboyd.dev

This script uses an accumulator to create a 0 to 1 saw wave which we
then use to create a square wave. It also features a pulse width control
input that is sampled at the beginning of each cycle. This prevents the
pulse width from changing during the cycle.

First we declare a variable called acc and set it to 0. This is the
variable that acts as an accumulator.

Inside the process function, we first check to see if the acc variable
is equal to 0. If it is, we set the pwCtrl variable to the value of the
pwCtrlIn input. Since the acc variable is equal to 0 for only one sample 
at the beginning of each cycle, and we later use the pwCtrl variable
instead of the pwCtrlIn input, this prevents the pulse width from
changing during the cycle.
    
Next we calculate the incr (increment) variable by dividing the hzIn 
value by the sampleRate value.

Then, we add the incr variable to the acc variable. If the acc variable
is greater than or equal to 1, we set it to 0.

Finally, we use a ternary operator to set the gateOut value to 1 if the
acc variable is less than or equal to pwCtrl, and 0 if it is greater.

--]]

-- Inputs: hzIn pwCtrlIn sampleRate 
-- Outputs: gateOut

acc = 0

function process(frames)
    for i = 1, frames do
        if acc == 0 then
            pwCtrl = pwCtrlIn[i]
        end
        
        local incr = hzIn[i] / sampleRate[i]
        acc = acc + incr
        
        if acc >= 1 then acc = 0 end

        gateOut[i] = acc <= pwCtrl and 1 or 0
    end
end
