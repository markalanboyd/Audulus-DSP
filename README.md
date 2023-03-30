# Audulus-DSP

This is a library of Lua DSP code written for Audulus' DSP node. The DSP node uses Lua to process signals in batches of samples called frames. 

The DSP node is a great way to write custom audio effects, oscillators, submodule tools, and more.

### Quick Start

1. Declare your inputs and outputs in the inspector panel.
1. Initialize your global variables and constants.
1. Declare your functions.
1. Add the boilerplate code:
    ```
    function process(frames)
        -- Once per block
        for i = 1, frames do
            -- Once per sample
        end
    end
    ```
1. Access your inputs and outputs within the for loop like this: `input[i]` and `output[i]`.

---
## The *process(frames)* Function

![Basic DSP Code Example](/docs/img/getting-started-example.png)

Above is a barebones example of how to use the DSP node. 

The `process()` function is run once per frame. You do not need to call it after declaring it - that is done automatically behind the scenes.

The `process()` function takes a single argument, `frames`. Do not change the name of this argument, or the node will not work.

![Audio Buffer Size](/docs/img/audio-buffer-size.png)

A buffer size of `128` means each block contains `128` samples. These samples are just lists of numbers, and can be accessed by their index. You do not, however, use `frames` directly to access the signal. `frames` is in fact just a global variable that stores the integer value set by your `Audio Buffer Size`. 

---

## Inputs and Outputs and the `for` loop

To bring signals into the DSP node, you instead use an `input` which you declare at the top of the inspector panel.

![Declaring IO](/docs/img/declaring-io.png)

Inputs and outputs are declared by separating them with a space. Once you have declared each input and output, it will appear on the node as a connection that can be made within Audulus. You can also then use the `input` and `output` variables in your script.

When you use `inputs` and `outputs` that are declared in the inspector, you must remember that they are tables. This means that you must use the `[]` operator to access the values.

This explains the second part of the necessary boilerplate code below:

![For Loop](/docs/img/for-loop.png)

In this example, `i` is the index of the current sample in the frame, and `frames` is the maximum number of samples. The `for` loop loops through each sample in the table and performs a user-defined operation on them. In the example above, each corresponding input sample is sent to fill the list of output samples.

At the end of the frame, the `output` table is emptied to the next node in the signal flow outside of the DSP node. The `input` table is also filled with the next frame of samples.

---
## Declaring Variables and Functions

Global variables are declared above the `process()` function. You do not need make a separate `init()` function.

![Global Variable Declaration](/docs/img/global-variable-declaration.png)

Declare functions to be used within your `process()` function above it. You do not need to declare top-level functions as local, but if you have a function within a function, you should declare it as `local`.

![Declaring Functions](/docs/img/declaring-functions.png)

You can declare `local` variables within functions using the `local` keyword. There is no need to declare top-level functions or variables as `local`.

Although there are no set standards for Lua about case types, in this library, all variables use `camelCase`, all constants use `SCREAMING_SNAKE_CASE`, and all functions use `camelCase()`.

![Sample Rate Global Variable](/docs/img/sample-rate-global.png)

In addition to `frames` you have access to a global variable called `sampleRate`. This is the sample rate of the audio signal. It is set by the `Sample Rate` setting in `Audulus 4 > Settings`. You do not need to pass this variable as an argument to your `process()` function - simply use it as you would a global variable.

--- 
## Once Per Block Optimization

![Once Per Block](/docs/img/once-per-block.png)

To optimize your code by only running certain operations once per block, you can perform functions outside of the `for` loop. This is useful for operations that do not need to be performed on every sample in the frame. For example, if you are calculating biquad coefficients, you can do this once per block instead of once per sample.

To access the first sample in the block, you can use `input[1]`.

---
## Contributing

Contributions are welcome! Please read the [Contributing Guidelines](/CONTRIBUTING.md) before submitting a pull request.