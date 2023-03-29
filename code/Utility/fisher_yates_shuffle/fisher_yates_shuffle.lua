--[[

Fisher-Yates Shuffle
by Mark Boyd
v 1.0
March 28, 2023
http://www.markboyd.dev

This script shuffles a set of values from 0 to 7 using the Fisher-Yates
algorithm. Shuffling 8 values produces 8! or 40,320 possible
permutations.

First we create a table called values and set it to the values 0 to 7.
These are the values that will be shuffled.

We also create a variable called gatePrev and set it to 0. The gatePrev
variable is used to store the previous value of the gateIn variable.

Next we create a function called shuffle. This function takes a table as
an argument. The function loops through the table backwards, starting at
the last index and ending at the second index. For each index, a random
index is generated between 1 and the current index. The values at the
current index and the random index are then swapped.

Inside the process function, we check to see if the gateIn value is 1
and the gatePrev value is 0. If it is, we call the shuffle function and
pass it the values table as an argument.

Next we set the out0 value to the first value in the values table, the
out1 value to the second value in the values table, and so on.

Finally, we set the gatePrev variable to the gateIn variable. This is
to store the current value of the gateIn variable for the next time the
process function is called and prevent the shuffle function from being
called multiple times in a row.

--]]

-- Inputs: gateIn
-- Outputs: out0, out1, out2, out3, out4, out5, out6, out7

values = {0, 1, 2, 3, 4, 5, 6, 7}
gatePrev = 0

function shuffle(table)
    for j = #table, 2, -1 do
        local k = math.random(j)
        table[j], table[k] = table[k], table[j]
    end
end

function process(frames)
    for i = 1, frames do
        if gateIn[i] == 1 and gatePrev == 0 then
            shuffle(values)
        end
        
        out0[i] = values[1]
        out1[i] = values[2]
        out2[i] = values[3]
        out3[i] = values[4]
        out4[i] = values[5]
        out5[i] = values[6]
        out6[i] = values[7]
        out7[i] = values[8]
        
        gatePrev = gateIn[i]
    end
end
