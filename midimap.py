import mido

# Define the name of the USB device
device_name = "Akai Renaissance USB"

# Define the file name for logging
log_file = "midi_log.txt"

try:
    # Open the MIDI port
    port = mido.open_input(device_name)
    print(f"Opened {device_name} successfully.")
except IOError:
    print(f"Could not open {device_name}. Make sure it's connected.")
    exit()

try:
    # Open log file
    with open(log_file, 'w') as f:
        f.write("MIDI Note Log:\n")
except IOError:
    print(f"Error opening log file {log_file}")
    exit()

print(f"Logging MIDI notes to {log_file}. Press Ctrl+C to stop.")

try:
    # Log MIDI notes indefinitely
    with mido.open_input(device_name) as port:
        for msg in port:
            if msg.type == 'note_on':
                with open(log_file, 'a') as f:
                    f.write(f"Note: {msg.note} - Velocity: {msg.velocity}\n")
except KeyboardInterrupt:
    print("Logging stopped.")
