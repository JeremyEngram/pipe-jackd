#!/bin/bash

# Function to print instructions for setting up input and output streams
print_instructions() {
    printf "To set the input and output streams in %s, you can follow these steps:\n\n" "$1"
    printf "1. List Available Sink and Source Devices:\n"
    printf "   pactl list sinks\n"
    printf "   pactl list sources\n"
    printf "   This will list all available output (sink) and input (source) devices, respectively. Take note of the names or indices of the devices you want to use.\n\n"
    
    printf "2. Set Default Sink and Source:\n"
    printf "   pactl set-default-sink <sink_name_or_index>\n"
    printf "   pactl set-default-source <source_name_or_index>\n"
    printf "   Replace <sink_name_or_index> and <source_name_or_index> with the name or index of the sink and source you want to set as default, respectively.\n\n"
    
    printf "3. Set Application Output and Input:\n"
    printf "   pactl move-sink-input <input_id> <sink_name_or_index>\n"
    printf "   pactl move-source-output <output_id> <source_name_or_index>\n"
    printf "   Replace <input_id> and <output_id> with the ID of the application's input or output stream you want to move, and <sink_name_or_index> or <source_name_or_index> with the name or index of the sink or source you want to move the stream to.\n\n"
    
    printf "4. Example:\n"
    printf "   pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo\n"
    printf "   pactl set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo\n"
    printf "   This example sets the default output to a specific ALSA sink and the default input to a specific ALSA source.\n\n"
    
    printf "You can use these commands in a script or directly in the terminal to configure input and output streams in %s according to your preferences. Make sure to replace the device names or indices with the ones corresponding to your system's configuration.\n" "$1"
}

# Function to prompt the user for their choice
prompt_user() {
    read -p "Which audio system would you like to configure? (Enter 'p' for PipeWire, 'q' for QjackCtl): " choice
    case "$choice" in
        p|P)
            print_instructions "PipeWire"
            ;;
        q|Q)
            print_instructions "QjackCtl"
            ;;
        *)
            echo "Invalid choice. Please enter 'p' for PipeWire or 'q' for QjackCtl."
            prompt_user
            ;;
    esac
}

# Main script
echo "Welcome to the Audio Configuration Wizard!"
prompt_user
