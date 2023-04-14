
-- Biquad Filters from the RBJ Cookbook :: Jerry Smith, 2023

SR = sampleRate

local fMin,fMax = math.log(20), math.log(20000)

local A1,A2,A3,B1,B2 = 0,0,0,0,0
local x1,x2,y1,y2 = 0,0,0,0

-- Math functions, for readability
local pi = math.pi
local sin = math.sin
local cos = math.cos
local log = math.log
local exp = math.exp
local sqrt = math.sqrt

function sinh(x)
  return (math.exp(x) - math.exp(-x)) / 2
end

function tanh(x)
  return (math.exp(x) - math.exp(-x)) / (math.exp(x) + math.exp(-x))
end

-- Biquad filter coefficients for a lowpass filter
function LPF(f0, q)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local q = q*10+.05
  
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) / (2 * q)
  
  local b0 = (1 - cos(w0))/2
  local b1 = 1 - cos(w0)
  local b2 = (1 - cos(w0))/2
  local a0 = 1 + alpha
  local a1 = -2*cos(w0)
  local a2 = 1 - alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a highpass filter
function HPF(f0, q)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local q = q*10+.05
  
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) / (2 * q)
  
  local b0 = (1 + cos(w0))/2
  local b1 = -(1 + cos(w0))
  local b2 = (1 + cos(w0))/2
  local a0 = 1 + alpha
  local a1 = -2*cos(w0)
  local a2 = 1 - alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a bandpass filter
function BPF(f0, bw)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local bw = bw*10+.05
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) * sinh( log(2)/2 * bw * w0/sin(w0) )

  local b0 = alpha
  local b1 = 0
  local b2 = -alpha
  local a0 = 1 + alpha
  local a1 = -2 * cos(w0)
  local a2 = 1 - alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a notch filter
function NF(f0, bw)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local bw = bw*10+.05
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) * sinh( log(2)/2 * bw * w0/sin(w0) )

  local b0 = 1
  local b1 = -2 * cos(w0)
  local b2 = 1
  local a0 = 1 + alpha
  local a1 = -2 * cos(w0)
  local a2 = 1 - alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a peak filter
function PKF(f0, q, gain)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local q = q*10+.05
  local gain = gain*40-20
  local A = 10^(gain/40)
  
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) / (2 * q)
  
  local b0 = 1 + alpha*A
  local b1 = -2*cos(w0)
  local b2 = 1 - alpha*A
  local a0 = 1 + alpha/A
  local a1 = -2*cos(w0)
  local a2 = 1 - alpha/A

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a low shelf filter
function LSF(f0, slope, gain)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local S = slope*.998+.001
  local gain = gain*40-30
  local A = 10^(gain/40)
  
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) / 2 * sqrt( (A + 1/A)*(1/S - 1) + 2 )
  
  local b0 = A*( (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha )
  local b1 = 2*A*( (A-1) - (A+1)*cos(w0) )
  local b2 = A*( (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha )
  local a0 = (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha
  local a1 = -2*( (A-1) + (A+1)*cos(w0) )
  local a2 = (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for a high shelf filter
function HSF(f0, slope, gain)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local S = slope*.998+.001
  local gain = gain*40-30
  local A = 10^(gain/40)
  
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) / 2 * sqrt( (A + 1/A)*(1/S - 1) + 2 )
  
  local b0 = A*( (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha )
  local b1 = -2*A*( (A-1) + (A+1)*cos(w0) )
  local b2 = A*( (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha )
  local a0 = (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha
  local a1 = 2*( (A-1) - (A+1)*cos(w0) )
  local a2 = (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end

-- Biquad filter coefficients for an allpass filter
function APF(f0, bw)
  local f0 = exp(f0*(fMax-fMin)+fMin)
  local bw = bw*10+.05
  local w0 = 2 * pi * f0 / SR
  local alpha = sin(w0) * sinh( log(2)/2 * bw * w0/sin(w0) )

  local b0 = 1 - alpha
  local b1 = -2 * cos(w0)
  local b2 = 1 + alpha
  local a0 = 1 + alpha
  local a1 = -2 * cos(w0)
  local a2 = 1 - alpha

  A1,A2,A3,B1,B2 = b0/a0,b1/a0,b2/a0,a1/a0,a2/a0
end


local x1, x2, y1, y2 = 0, 0, 0, 0

-- Biquad filter formula
function Filter(samples)
    
    -- Compute filter output
    local outSamples = A1 * samples + A2 * x1 + A3 * x2 - B1 * y1 - B2 * y2

    -- Update state variables
    x2, x1, y2, y1 = x1, samples, y1, outSamples

    return outSamples
end

-- Audulus method for processing blocks of samples
function process(frames)

-- Select a filter
local fmode = math.floor(mode[1]*7.99)+1
if fmode == 1 then LPF(fc[1], q[1]) end
if fmode == 2 then HPF(fc[1], q[1]) end
if fmode == 3 then BPF(fc[1], q[1]) end
if fmode == 4 then NF(fc[1], q[1]) end
if fmode == 5 then PKF(fc[1], q[1], gain[1]) end
if fmode == 6 then LSF(fc[1], q[1], gain[1]) end
if fmode == 7 then HSF(fc[1], q[1], gain[1]) end
if fmode == 8 then APF(fc[1], q[1]) end

--clip = clip[1]

-- Process the frames and send to the output
  for i=1,frames do	
   output[i] = Filter(input[i])
  end
end
