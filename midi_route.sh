#!/bin/bash

# Start JACK if it's not running
pgrep jackd || jackd -d alsa &

# Wait a bit for JACK to start
sleep 2

# List available MIDI inputs and outputs
aconnect -l

# Set your software's MIDI input name or client number
software_input="Software_MIDI_Input_Name"

# Automatically connect all available MIDI hardware to the specified software input
for port in $(aconnect -l | grep 'client' | grep -i 'MIDI' | cut -d ' ' -f 2 | tr -d ':'); do
    aconnect $port $software_input
done

echo "MIDI routing configured."
