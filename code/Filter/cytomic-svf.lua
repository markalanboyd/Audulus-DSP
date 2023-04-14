
-- Multimode SVF Filter :: Jerry Smith, 2023

-- Based on Andrew Simper's SVF Linear Trapezoidal Optimized filter
-- https://cytomic.com/files/dsp/SvfLinearTrapOptimised2.pdf

SR = sampleRate

-- init all variables
local ic1eq,ic2eq,g,k,a1,a2,a3,v3,v1,v2 = 0,0,0,0,0,0,0,0,0,0

function filter_params(fc, res, mode)
  local fMin, fMax = math.log(20), math.log(20000)
  local cutoff = math.exp(fc * (fMax - fMin) + fMin)
  g = math.tan(math.pi * cutoff / SR)
  k = 2 - 2 * res -- 1/Q
  a1 = 1 / (1 + g * (g + k))
  a2 = g * a1
  a3 = g * a2
  fmode = mode*4
end

function filter(v0)
  v3 = v0 - ic2eq
  v1 = a1 * ic1eq + a2 * v3
  v2 = ic2eq + a2 * ic1eq + a3 * v3
  ic1eq = 2 * v1 - ic1eq
  ic2eq = 2 * v2 - ic2eq
  
  -- filter modes
  lp = v2
  bp = v1
  hp = v0 - k * v1 - v2
  notch = v0 - k * v1
  pk = v0 - k * v1 - 2 * v2
	
  -- fade across filter modes
  if fmode <= 1 then
    return lp*(1-fmode) + bp*fmode
  elseif fmode > 1 and fmode <= 2 then
    return bp*(1-(fmode-1)) + hp*(fmode-1)
  elseif fmode > 2 and fmode <= 3 then
    return hp*(1-(fmode-2)) + notch*(fmode-2)
  elseif fmode > 3 and fmode <= 4 then
    return notch*(1-(fmode-3)) + pk*(fmode-3)
  end
end

function process(frames)
  -- call cutoff, res and moe once per frame buffer
  filter_params(fc[1], res[1], mode[1])
  for i = 1, frames do
  -- call filter function for every sample
   out[i] = filter(input[i])
  end
end
