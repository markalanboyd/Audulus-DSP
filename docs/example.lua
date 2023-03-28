globalVariable1 = 0
globalVariable2 = []
globalVariable3 = {}

GLOBAL_CONSTANT1 = 42
GLOBAL_CONSTANT2 = [1, 2, 3]
GLOBAL_CONSTANT3 = {a = 1, b = 2, c = 3}

function process(frames)
    for i = 1, frames do
        output[i] = input[i]
    end
end