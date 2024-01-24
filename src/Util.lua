Util = {}
U = Util

function Util.update(array)
    for _, obj in ipairs(array) do
        obj:update()
    end
end
