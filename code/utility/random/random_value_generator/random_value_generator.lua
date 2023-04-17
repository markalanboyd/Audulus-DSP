--[[

Random Value Generator
by Mark Boyd
v 1.1
April 17th, 2023
http://www.markboyd.dev

This script outputs a random float value between 0 and 1 every time the 
gateIn input is triggered.

You can specify a seed value for the random number generator. If you
leave the seed value at 0, the script will use the current time as a
seed. This is useful for generating random numbers that are different
every time the script is run.

After the script checks the seed value, it sets the random seed to the
value passed to it.

The prevGate and randomFloat variables are initialized to zero. The
prevGate variable is used to check if the gateIn input is triggered.
The randomFloat variable is used to store the random float value.

Within the process() function, it first checks if the gateIn input is
triggered and that the prevGate variable is 0. If both conditions are
true, the randomFloat variable is set to a random float value between 0
and 1.

The randomFloat variable is then output to the randomOut output, and the
prevGate variable is set to the value of the gateIn input to prevent the
script from outputting a random float value every sample that the gateIn
input is held high.

--]]

-- Inputs: gateIn
-- Outputs: randomOut

SEED = 0

if SEED == 0 then
    math.randomseed(os.time())
else
    math.randomseed(SEED)
end

prevGate = 0
randomFloat = 0

function process(frames)
    for i = 1, frames do
        if prevGate == 0 and gateIn[i] > 0 then
            randomFloat = math.random()
        end

        randomOut[i] = randomFloat
        prevGate = gateIn[i]
    end
end
