globalVariable1 = 0
globalVariable2 = []
globalVariable3 = {}

GLOBAL_CONSTANT1 = 42
GLOBAL_CONSTANT2 = [1, 2, 3]
GLOBAL_CONSTANT3 = {a = 1, b = 2, c = 3}

function multiplyBy2(input)
    local localVariable = 2
    return input * localVariable
end

function process(frames)
    oncePerFrame = input * 2
    for i = 1, frames do
        output[i] = input[i]
    end
end
