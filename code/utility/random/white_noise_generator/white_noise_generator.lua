--[[

White Noise Generator
by Mark Boyd
v 1.1
April 17th, 2023
http://www.markboyd.dev

This script outputs a random float value between 0 and 1 every sample.

You can specify a seed value for the random number generator. If you
leave the seed value at 0, the script will use the current time as a
seed. This is useful for generating random numbers that are different
every time the script is run.

After the script checks the seed value, it sets the random seed to the
value passed to it.

Within the process() function, the output is set to a random number
between 0 and 1 for every sample.

--]]

-- Outputs: randomOut

SEED = 0

if SEED == 0 then
    math.randomseed(os.time())
else
    math.randomseed(SEED)
end

function process(frames)
    for i = 1, frames do
        randomOut[i] = math.random()
    end
end
