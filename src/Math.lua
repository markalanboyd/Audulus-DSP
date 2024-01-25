Math = {}
M = Math

Math.two_pi = math.pi * 2
Math.half_pi = math.pi * 0.5
Math.quarter_pi = math.pi * 0.25

Math.inv_sr = 1 / sampleRate

function Math.tanh(x)
    local e2x = math.exp(2 * x)
    return (e2x - 1) / (e2x + 1)
end
