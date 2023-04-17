--[[

os.time() Random Seed
by Mark Boyd
v 1.0
April 17th, 2023
http://www.markboyd.dev

This script generates a random seed based on the current time and sets
the random seed to that value. This is useful for generating random
numbers that are different every time the script is run.

The os.time() function returns the current time in seconds since the
Unix epoch. The os.date() function formats the time in a human-readable
format. We then have to convert the formatted time to a number so that
we can use it as a seed for the random number generator. Next, the
math.randomseed() function sets the random seed to the value passed
to it.

Within the process() function, the output is set to a random number
between 0 and 1 for every sample. The output is white noise.

--]]

currentTime = os.time()
formattedTime = os.date("%m%H%M%S", currentTime)
seed = tonumber(formattedTime)
math.random(seed)

function process(frames)
    for i = 1, frames do
        output[i] = math.random()
    end
end
