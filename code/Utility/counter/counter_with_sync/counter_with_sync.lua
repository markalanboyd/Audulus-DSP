--[[

Counter with Sync
by Mark Boyd
v 1.1
April 13th, 2023
http://www.markboyd.dev

This is a simple counter that counts up by 1 every time the gateIn input
is pulsed. It can be reset to 0 by gating the syncIn input.

First the count, prevGate, and prevSync variables are initialized to 0.
The count variable will be our output, and the prevGate and prevSync 
variables are used to keep track of the previous value of the 
gateIn and syncIn inputs respectively.

If the syncIn input is greater than 0 and the prevSync is also zero
(that is, the sync is still not being held high), the count variable is
set to 0.

If the prevGate variable is 0 and the gateIn is greater than 0,
that means that a button press or input clock pulse has occurred. In
that case, the count variable is incremented by 1.

The countOut is set to the current value of the count variable and
the prevGate and prevSync variables are set to the current values of
the gateIn and syncIn inputs respectively. Keeping track of the previous
values of the inputs is necessary to detect when the inputs are held
high.

--]]

-- Inputs: gateIn syncIn
-- Outputs: countOut

count = 0
prevGate = 0
prevSync = 0

function process(frames)
    for i = 1, frames do
        if syncIn[i] > 0 and prevSync == 0 then 
            count = 0
        elseif gateIn[i] > 0 and prevGate == 0 then 
            count = count + 1
        end

        countOut[i] = count
        prevGate = gateIn[i]
        prevSync = syncIn[i]
    end
end
