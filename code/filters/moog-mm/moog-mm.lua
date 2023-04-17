-- Analog-modeled Moog transistor ladder filter -- multimode :: Jerry Smith, 2023.
-- Based on designs by Victor Lazzarini and Will Pirkle. 
-- ZDF implementation based on Vadim Zavalishin's designs.

SR = sampleRate

-- Make a function for filter parameters
function filter_params(fc, res, mode)
  local fMin, fMax = math.log(20), math.log(20000)
  cutoff = math.exp(fc * (fMax - fMin) + fMin)
  
  g = 1 - math.exp(-2 * math.pi * cutoff / SR)
  res = 2*((1 - res) - .45)
  k = res * (1 - g)
  
  -- Calculate resonance feedback coefficient
r = k / (1 + k * (4 - 2 * math.sqrt(2)) + 2 * math.sqrt(2) * k * k)

  ftype = math.floor(mode * 8.99)
end

function tanh(x)
  return (math.exp(x) - math.exp(-x)) / (math.exp(x) + math.exp(-x))
end

-- Initialize state variables
z1,z2,z3,z4 = 0,0,0,0

-- Filter function
function filter(frame)
  --frame = tanh(frame*3)/1.57 -- uncomment to apply shaping to input
  -- State variables with tanh clipping applied to resonance feedback
z1 = z1 + g * (frame - z1 + tanh(k * (z2 - z1 + r * (z1 - z4))))
z2 = z2 + g * (z1 - z2 + tanh(k * (z3 - z2 + r * (z2 - z1))))
z3 = z3 + g * (z2 - z3 + tanh(k * (z4 - z3 + r * (z3 - z2))))
z4 = z4 + g * (z3 - z4 + tanh(k * (r * (z4 - z3))))
  
  -- Filter modes
  if     ftype == 0 then return z4 -- 4p LP
  elseif ftype == 1 then return z2 -- 2p LP
  elseif ftype == 2 then return z4 - z1 -- 4p BP
  elseif ftype == 3 then return -(z2 - z4) -- 2p BP
  elseif ftype == 4 then return z4 - z3 -- 4p HP
  elseif ftype == 5 then return frame - 2 * z2 + z4 -- 2p HP
  elseif ftype == 6 then return z2 + z4 - 2 * z1 -- 2p notch
  elseif ftype == 7 then return frame - k * z2 + z4 -- 2p PK
  elseif ftype == 8 then return z3 - k * z1 -- 2p LS
  end
end

function process(frames)
  filter_params(fc[1], res[1], mode[1])
  for i = 1, frames do
    out[i] = filter(input[i])
  end
end
