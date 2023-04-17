--[[

os.time() Random Generator
by Mark Boyd
v 1.0
April 17th, 2023
http://www.markboyd.dev

This script outputs a random number between 0 and 1 every time the 
gateIn input is triggered.

This script uses the os.time() function to use the current time as a
random seed. This is useful for generating random numbers that are
different every time the script is run.

The os.time() function returns the current time in seconds since the
Unix epoch. The os.date() function formats the time in a human-readable
format. We convert the formatted time to a number with the tonumber()
function so that we can use it as a seed for the random number
generator. Next, the math.randomseed() function sets the random seed to
the value passed to it.

Within the process() function, the output is set to a random number
between 0 and 1 for every sample. The output is white noise.

--]]

-- Inputs: gateIn
-- Outputs: randomOut

currentTime = os.time()
formattedTime = os.date("%m%d%H%M%S", currentTime)
seed = tonumber(formattedTime)
math.randomseed(seed)

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