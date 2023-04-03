a--[[

Count Up
by Mark Boyd
v 1.0
March 28, 2023
http://www.markboyd.dev

This is a simple counter that counts up by 1 every time the gateIn input
is pulsed. It can be reset to 0 by gating the syncIn input.

First the count and prevGate variables are initialized to 0. The count
variable will be our output, and the prevGate variable is used to keep 
track of the previous value of the gateIn input.

If the syncIn input is greater than 0, the count variable is set to 0.

If the prevGate variable is 0 and the gateIn[i] is greater than 0,
that means that a button press or input clock pulse has occurred. In
that case, the count variable is incremented by 1.

The countOut[i] is set to the current value of the count variable and
the prevGate variable is set to the current value of the gateIn[i]. The
prevGate variable must be set to the current value of the gateIn[i] so
that as long as the gateIn[i] is greater than 0, the prevGate variable
will stay high as well.

--]]

-- Inputs: gateIn syncIn
-- Outputs: countOut

count = 0
prevGate = 0

function process(frames)
    for i = 1, frames do
        if syncIn[i] > 0 then 
            count = 0
        else
            if prevGate == 0 and gateIn[i] > 0 then 
                count = count + 1
            end
        end
        
        countOut[i] = count
        prevGate = gateIn[i]
    end
end
