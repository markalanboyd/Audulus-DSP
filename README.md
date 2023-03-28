# Audulus-DSP

This is a library of Lua DSP code written for Audulus' DSP node. The DSP node uses Lua to process signals in batches of samples called frames. 

The DSP node is a great way to write custom audio effects, oscillators, submodule tools, and more.

## Getting Started

![Basic DSP Code Example](/docs/img/getting-started-example.png)

Above is a barebones example of how to use the DSP node. 

The `process()` function is run once per frame. You do not need to call it after declaring it - that is done automatically behind the scenes.

The `process()` function takes a single argument, `frames`, which is a table of samples. Do not change the name of this argument, or the node will not work.

The length of the frame is set by your `Audio Buffer Size`, which can be found under `Audulus 4 > Settings`.

![Audio Buffer Size](/docs/img/audio-buffer-size.png)

A buffer size of `128` means each frame contains `128` samples. These samples are just lists of numbers, and can be accessed by their index. You do not, however, use `frames` directly to access the signal. `frames` is in fact just a global variable that stores the value set by your `Audio Buffer Size`. To bring signals into the DSP node, you instead use an `input` which you declare at the top of the inspector panel.

![Declaring IO](/docs/img/declaring-io.png)

Inputs and outputs are declared by separating them with a space. Once you have declared each input and output, it will appear on the node as a connection that can be made within Audulus. You can also then use the `input` and `output` variables in your script.

When you use `inputs` and `outputs` that are declared in the inspector, you must remember that they are tables. This means that you must use the `[]` operator to access the values.

This explains the second part of the necessary boilerplate code below:

![For Loop](/docs/img/for-loop.png)

In this example, `i` is the index of the current sample in the frame, and `frames` is the maximum number of samples. The `for` loop loops through each sample and performs an operation on them. In the given example, each corresponding input sample is sent to fill the list of output samples. 

Global variables and variables that need to be initiated before use are declared above the `process()` function. You do not need make a separate `init()` function.

![Global Variable Declaration](/docs/img/global-variable-declaration.png)

Although there are no set standards for Lua about case types, in this library, all variables use `camelCase`, all constants use `SCREAMING_SNAKE_CASE`, and all functions use `snake_case()`.

### TLDR:

1. Declare your inputs and outputs in the inspector panel.
2. Initialize your global variables and constants.
3. Add the boilerplate code:
```
function process(frames)
    for i = 1, frames do
        -- Do stuff here
    end
end
```
4. Access your inputs and outputs within the for loop like this: `input[i]` and `output[i]`.