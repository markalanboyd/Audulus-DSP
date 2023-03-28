# Audulus-DSP

This is a library for writing DSP code in Audulus. The DSP node uses the Lua scripting language to process signals in frames. The DSP node is a great way to write custom audio effects, oscillators, submodule tools, and more.

## Getting Started

![Basic DSP Code Example](/docs/img/getting-started-example.png)

Above is a barebones example of how to use the DSP node. 

The `process()` function is run once per frame. You do not need to call it after declaring it - that is done automatically behind the scenes.

The `process()` function takes a single argument, `frames`, which is a table of samples. Do not change the name of this argument, or the node will not work.

The length of the frame is set by your `Audio Buffer Size`, which can be found under `Audulus 4 > Settings`.

![Audio Buffer Size](/docs/img/audio-buffer-size.png)

A buffer size of `128` means each frame contains `128` samples.

In the example above, signal passes directly from the node's input to its output without any processing.

Global variables and variables that need to be initiated before use are declared above the `process()` function.

![Global Variable Declaration](/docs/img/global-variable-declaration.png)

