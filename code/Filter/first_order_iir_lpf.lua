--[[

First Order IIR LPF
by Mark Boyd
v 1.0
March 30, 2023
http://www.markboyd.dev

This script creates a 1 pole (6dB/oct), non-resonant low pass filter.

The twoPi variable and sampleRateRecip variable are set to 2 * pi and
1 / sampleRate, respectively. This is because it's best practice to
precalculate static values outside of the loop, saving processing time.

The prevOutput variable is initialized to 0. This is the variable that
acts as the accumulator for the filter.

Inside the process function, but before the for loop, we calculate the
cutoff variable with the formula: 20 * 10^(3 * cutoffCtrlIn). This is
because the cutoffCtrlIn value is a linearized cutoff value between 0
and 1, and we need to convert it to a cutoff value in Hz that will
smoothly transition from 20Hz to 20kHz.

We then calculate the rc (resistance-capacitance) variable by dividing
the cutoff variable multiplied by twoPi.

Next, we calculate the alpha variable by dividing the sampleRateRecip
variable by the sum of the rc variable and the sampleRateRecip variable.

We then loop through the frames. Inside the loop, we calculate the
prevOutput variable by multiplying the alpha variable by the audioIn
value and adding the product to the product of (1 - alpha) and the
prevOutput variable.

Finally, we set the audioOut value to the prevOutput variable.

--]]

-- Inputs: audioIn cutoffCtrlIn
-- Outputs: audioOut cutoffOut

twoPi = 2 * math.pi
sampleRateRecip = 1 / sampleRate
prevOutput = 0

function process(frames)
    cutoff = 20 * 10^(3 * cutoffCtrlIn[1])
    rc = 1 / (cutoff * twoPi)
    alpha = sampleRateRecip / (rc + sampleRateRecip)
    for i = 1, frames do
        prevOutput = alpha * audioIn[i] + (1 - alpha) * prevOutput
        audioOut[i] = prevOutput
    end
end
