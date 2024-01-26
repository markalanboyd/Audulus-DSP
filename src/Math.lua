Math = {}
M = Math

Math.two_pi = math.pi * 2
Math.inv_two_pi = 1 / Math.two_pi
Math.inv_pi = 1 / math.pi
Math.half_pi = math.pi * 0.5
Math.quarter_pi = math.pi * 0.25

Math.inv_sr = 1 / sampleRate

function Math.tanh(x)
    local e2x = math.exp(2 * x)
    return (e2x - 1) / (e2x + 1)
end

function Math.fract(x)
    return x - math.floor(x)
end
