#!/bin/zsh
# Concatenate all Lua files in the current directory into one except for builtins.

library_file="library.lua"
dev_library_file="library-dev.lua"

# Delete the existing library files if they exist
[ -f "$library_file" ] && rm "$library_file"
[ -f "$dev_library_file" ] && rm "$dev_library_file"

# Add the top content to library.lua
echo "-- SCROLL TO BOTTOM ----------------------------------------------------\n" > "$library_file"

# Concatenate the Lua files into library.lua using find
find . -name '*.lua' -not -name "$library_file" -not -name 'builtins.lua' -not -name 'temp_library.lua' -exec cat {} + >> "$library_file"
echo "\n" >> "$library_file" # Add a newline at the end

# Add the bottom content to library.lua
cat << EOF >> "$library_file"
-- AUDULUS-DSP LIBRARY ----------------------------------------------
-- Version: 0.0.1-alpha
-- Updated: 2024.01.24
-- URL: https://github.com/markalanboyd/Audulus-DSP

----- Instructions -----
-- 1. TBD

-- CODE ----------------------------------------------------------------

function process(frames)
    -- Once per frame
    for i = 1, frames do
        -- Once per sample
    end
end

EOF

# Create development version of the library file (library-dev.lua)
awk '/-- CODE ----------------------------------------------------------------/{print; exit} {print}' "$library_file" > "$dev_library_file"
