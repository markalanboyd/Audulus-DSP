# Audulus-DSP

This is a library of Lua DSP code written for Audulus' DSP node. The DSP node uses Lua to process audio and control signals. 

The DSP node is a great way to write custom audio effects, oscillators, submodule tools, and more.

### Quick Start

1. Declare your inputs and outputs in the inspector panel.
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

### Contributing

Contributions are welcome! Please read the [Contributing Guidelines](/docs/CONTRIBUTING.md) before submitting a pull request.

---
# Overview

What follows is a brief overview of the boilerplate code you need to use in order to write DSP code for the Audulus DSP node. It is intended for those who have some experience programming. If you are new to programming or DSP, you may want to start with the [Introduction to DSP in Audulus](/docs/intro_to_dsp/intro_to_dsp.md).

## The `process()` Function

``` lua
function process(frames)
    for i = 1, frames do
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
for i = 1, frames do
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
    for i = 1, frames do
        output[i] = double(input[i])
    end
end
```

You should declare variables within function that are locally-scoped with the `local` keyword. There is no need to declare top-level functions or variables as `local`.

Although there are no set standards for Lua about case types, in this library, all variables use `camelCase`, all constants use `SCREAMING_SNAKE_CASE`, and all functions use `camelCase()`.

## `sampleRate` Global Variable
![Sample Rate Global Variable](/docs/img/sample-rate-global.png)

You also have access to a global variable called `sampleRate`. This is the sample rate of the audio signal. 

The `sampleRate` variable is set either by Audulus' global sample rate, an inline Resample node (for supersampling), or the host's sample rate if you are using Audulus as an AUv3. If you change the sample rate, the `sampleRate` variable will be updated and the script will be recompiled.

You do not need to pass `sampleRate` as an argument to your `process()` function - simply use it as you would a global variable.

## Optimizing Strategies

There are a few strategies you can use to optimize your DSP code.

The first is to, whenever possible, precalculate values that do not change within the `for` loop. This is especially useful for calculations that are expensive to perform.

``` lua
-- Bandpass filter
-- Static filter parameters
centerFreq = 500
Q = 1

-- Calculate normalized angular frequency
omega = 2 * math.pi * centerFreq / sampleRate
alpha = math.sin(omega) / (2 * Q)

-- Precalculate filter coefficients
b0_raw = alpha
b1_raw = 0
b2_raw = -alpha
a0_raw = 1 + alpha
a1_raw = -2 * math.cos(omega)
a2_raw = 1 - alpha

-- Precalculate divisions
b0 = b0_raw / a0_raw
b1 = b1_raw / a0_raw
b2 = b2_raw / a0_raw
a1 = a1_raw / a0_raw
a2 = a2_raw / a0_raw

-- Filter state variables
x1 = 0
x2 = 0
y1 = 0
y2 = 0

function process(frames)
    for i=1,frames do
        input_signal = input[i]

        -- Apply biquad filter
        y = b0 * input_signal + b1 * x1 + b2 * x2 - a1 * y1 - a2 * y2

        -- Update state variables
        x2 = x1
        x1 = input_signal
        y2 = y1
        y1 = y

        output[i] = y
    end
end


```

To optimize your code by only running certain operations once per block, you can perform functions outside of the `for` loop. This is useful for operations that do not need to be performed on every sample in the frame. For example, if you are calculating biquad coefficients, you can do this once per block instead of once per sample.

To access the first sample in the block for your calculations, you can use `input[1]`.



The processing buffer size - usually the buffer size set by the `Audio Buffer Size` setting in `Audulus 4 > Settings`.



Feedback loop bug?



static filter

current sample rate - reason for that is so you can use it in your initialization code. whole script is recompiled when you change the sample rate.