# Audulus-DSP

This is a library of Lua DSP code written for Audulus' DSP node. The DSP node uses [Lua](https://www.lua.org/) to process audio and control signals. 

The DSP node is a great way to write custom audio effects, oscillators, modulators, submodule tools, and more.

### Quick Start

1. Declare your inputs and outputs in the inspector panel separated by a space.
1. Initialize your global variables and constants.
1. Declare your functions.
1. Add the boilerplate code:
    ``` lua
    function process(frames)
        -- Once per block
        for i = 1, frames do
            -- Once per sample
        end
    end
    ```
1. Access your inputs and outputs within the for loop like this: `input[i]` and `output[i]`.
1. The editor contains the built-in [`math` library](https://www.lua.org/manual/5.4/manual.html#6.7) for Lua 5.4. Other external libraries must be copied and pasted into the script editor.

### Contributing

Contributions are welcome! Please read the [Contributing Guidelines](/docs/CONTRIBUTING.md) before submitting a pull request.

---
# Overview

What follows is a brief overview of the boilerplate code you need to use in order to write DSP code for the Audulus DSP node. It is intended for those who have some experience programming. If you are new to programming or DSP, you may want to start with the [Introduction to DSP in Audulus](/docs/intro_to_dsp/intro_to_dsp.md).

## The `process()` Function

``` lua
function process(frames)
    for i=1,frames do
        output[i] = input[i]
    end
end
```

Above is a barebones example of how to use the DSP node. You declare a function called `process()`, pass the buffer size as its first argument, and then use a `for` loop to access the samples in the buffer.

The `process()` function runs automatically. You do not need to call it after declaring it.

The `process()` function has a single positional argument called `frames`. You can change the name of this argument, but it must be the first argument.

![Audio Buffer Size](/docs/img/audio-buffer-size.png)

You do not use the `frames` variable directly to access the signal. The first positional argument in the process function passes an integer value set by your audio buffer size. 

A buffer size of `128` means each block contains `128` samples. A sample is just a floating-point number. A block is an array of samples, and each sample can be accessed by its index. 

If you are using Audulus as an AUv3, the audio buffer size will be set by the host.

## Inputs and Outputs and the `for` loop

To bring signals into the DSP node, you use an `input` which you declare at the top of the inspector panel.

![Declaring IO](/docs/img/declaring-io.png)

Inputs and outputs are declared by separating them with a space. Once you have declared each input and output, it will appear on the node as a connection that can be made within Audulus. You can also then use the `input` and `output` variables in your script.

`inputs` and `outputs` are accessed like arrays. This means that you must use the `[]` operator to access the samples they contain.

``` lua
for i=1,frames do
    output[i] = input[i]
end
```

In this example, `i` is the index of the current sample in the frame, and `frames` is the maximum number of samples. The `for` loop loops through each sample in the table and performs a user-defined operation on them. With `output[i] = input [i]`, the output array is set to the value of the input array.

In reality, `inputs` and `outputs` are audio buffer objects, but for the purposes of coding, you can think of them as arrays.

## Declaring Variables and Functions

Global variables are declared above the `process()` function. You do not need make a separate `init()` function.

``` lua
GLOBAL_CONSTANT = 42

globalVariable = 0

function process(frames)
    -- do something
end
```

Declare functions to be used within your `process()` function above it. You do not need to declare top-level functions as local, but if you have a function within a function, you should declare it as `local`.

``` lua
function double(x)
    return x * 2
end

function process(frames)
    for i=1,frames do
        output[i] = double(input[i])
    end
end
```

You should declare variables within function that are locally-scoped with the `local` keyword. There is no need to declare top-level functions or variables as `local`.

Although there are no set standards for Lua about case types, in this library, all variables use `camelCase`, all constants use `SCREAMING_SNAKE_CASE`, and all functions use `camelCase()`.

## `sampleRate` Global Variable
![Sample Rate Global Variable](/docs/img/sample-rate-global.png)

You also have access to a global variable called `sampleRate`. This is the sample rate of the input signal. 

The `sampleRate` variable is set either by Audulus' global sample rate, an inline Resample node (for supersampling), or the host's sample rate if you are using Audulus as an AUv3. If you change the sample rate, the `sampleRate` variable will be updated and the script will be recompiled.

You do not need to pass `sampleRate` as an argument to your `process()` function - simply use it as you would a global variable.

## Optimizing Strategies

The specifics of how to optimize your DSP code will depend on the type of DSP you are writing. However, there are a few general strategies that can be applied to most cases.

First, the DSP node itself has some CPU overhead. This is unavoidable. However, you can reduce the amount of CPU used by your DSP code by optimizing your code.

The more that you can do within one DSP node, the less CPU you will use. For example, if you have a filter and an envelope follower, you can combine them into a single DSP node. This will reduce the overall CPU usage of your patch.

Also, whenever possible, precalculate values that do not change within the `for` loop outside of the `for` loop. This is especially useful for calculations that are expensive to perform.

In the example below, we have a fixed filter with a cutoff of `1000 Hz`. We can precalculate the filter coefficients and store them in global variables. This way, we do not need to perform the same calculations every time the `process()` function is called.

``` lua
CUTOFF = 1000
-- Precalculate filter coefficients here

function process(frames)
    for i=1,frames do
        -- Filter here
    end
end
```

If you want a filter with a variable cutoff, you can use a `cutoff` input and precalculate the filter coefficients in the `process()` function. This works well with knob or envelope-based modulation.

``` lua
function process(frames)
    cutoff = cutoffInput[1]
    -- Precalculate filter coefficients here
    for i=1,frames do
        -- Filter here
    end
end
```

You can also calculate everything within the `for` loop. This is the most computationally expensive option, but is a good choice when you want to FM the filter.

``` lua
function process(frames)
    for i=1,frames do
        cutoff = cutoffInput[i]
        -- Calculate filter coefficients here
        -- Filter here
    end
end
```
