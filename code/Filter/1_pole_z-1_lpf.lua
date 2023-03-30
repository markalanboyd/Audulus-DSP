--[[

1 Pole Z-1 Low Pass Filter
by Mark Boyd
v 1.0
March 30, 2023
http://www.markboyd.dev

This script creates a 1 pole low pass filter. It uses the z-1 method to
calculate the filter coefficients.

The twoPi variable and sampleRateRecip variable are set to 2 * pi and
1 / sampleRate, respectively. This is because it's best practice to
precalculate static values outside of the loop, saving processing time.

The z1 variable is initialized to 0. This is the variable that acts as
the accumulator for the filter.

Inside the process function, the cutoff variable is set to 20 * 2 raised
to the power of the cutoffCtrlIn value. This is because the cutoffCtrlIn
value is a linearized cutoff value between 0 and 1, and we need to
convert it to a cutoff value in Hz.

The rc (resistance-capacitance) variable is set to 1 divided by the
cutoff variable multiplied by twoPi.

The alpha (smoothing factor) variable is set to the sampleRateRecip
variable divided by the rc variable plus the sampleRateRecip variable.

Next, the z variable is set to the alpha variable multiplied by the
audioIn value plus 1 minus the alpha variable multiplied by the z1
variable.

The z1 variable is set to the z variable.

Finally, the audioOut value is set to the z variable. This generates a
low pass filtered signal.

--]]

-- Inputs: audioIn cutoffCtrlIn
-- Outputs: audioOut cutoffOut

twoPi = 2 * math.pi
sampleRateRecip = 1 / sampleRate
z1 = 0

function process(frames)
    cutoff = 20 * 2^(10 * cutoffCtrlIn[1])
    cutoffOut[1] = cutoff
    rc = 1 / (cutoff * twoPi)
    alpha = sampleRateRecip / (rc + sampleRateRecip)
    for i = 1, frames do
        local z = alpha * audioIn[i] + (1 - alpha) * z1
        z1 = z
        audioOut[i] = z
    end
end
