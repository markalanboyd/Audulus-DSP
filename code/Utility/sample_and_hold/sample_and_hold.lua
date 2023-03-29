--[[

Sample and Hold
by Mark Boyd
v 1.0
March 29, 2023
http://www.markboyd.dev

This script takes a sample of the sampleIn input every time the gateIn
input is pulsed and outputs the sample.

First the prevGate and sample variables are initialized to 0. The
prevGate variable is used to keep track of the previous value of the
gateIn input, and the sample variable is used to store the current
sample.

If the prevGate variable is 0 and the gateIn[i] is greater than 0,
that means that a button press or input clock pulse has occurred. In
that case, the sample variable is set to the current value of the
sampleIn[i].

The sampleOut[i] is set to the current value of the sample variable and
the prevGate variable is set to the current value of the gateIn[i]. The
prevGate variable must be set to the current value of the gateIn[i] so
that as long as the gateIn[i] is greater than 0, the prevGate variable
will stay high as well.

--]]

-- Inputs: sampleIn gateIn 
-- Outputs: sampleOut 

prevGate = 0
sample = 0

function process(frames)
    for i = 1, frames do
        if prevGate == 0 and gateIn[i] > 0 then 
            sample = sampleIn[i]
        end
        sampleOut[i] = sample
        prevGate = gateIn[i]
    end
end
