--[[

Test Sine Wave Generator
by Mark Boyd
v 1.0
March 28, 2023
http://www.markboyd.dev

Inputs: n/a
Outputs: audioOut

This script generates a sine wave at a set frequency.

You can change the frequency by changing the value of the hz variable.

The sampleRate is set to 44100, but you must set it to match the sample
rate of the audio device you are using.

The phaseIncrement variable is calculated by dividing the frequency by
the sample rate and multiplying by 2 * pi. This is the amount that the
phase variable is incremented by each time the process function is
called. By precalculating this value, we can save some processing time
in the process function.

Inside the process function, the phase variable is incremented by the
phaseIncrement variable. The audioOut[i] is set to the sine of the
phase variable, generating a sine wave.

A proper phasor would reset the phase variable to 0 when it reaches 2 *
pi, but this script does not do that. The reason is it's unnecessary for
this script. The phase variable is only used to generate the sine wave,
and the sine function will return the same value for any phase value, so
it doesn't matter if the phase variable is greater than 2 * pi.

--]]

hz = 440
sampleRate = 44100
phaseIncrement = hz / sampleRate * 2 * math.pi
phase = 0

function process(frames)
    for i = 1, frames do
        phase = phase + phaseIncrement
        audioOut[i] = math.sin(phase)
    end
end
