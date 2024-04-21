
#!/bin/bash

# Linux Sound Uses Alas as the base system and pulseaudio as a user friendly interface - so if using basic confiuration then use pulse where required


sudo apt update && sudo apt upgrade

sudo apt install ffmpeg winff

sudo apt install midisnoop jack-midi-clock jack-mixer midish gmidimonitor seq24

sudo apt install mixxx freewheeling sooperlooper multimedia-looping multimedia-midi giada aesqjoy aj-snapshot qtractor


sudo apt install yt-dlp


 
sudo apt install pipewire-alsa
sudo apt install pipewire-jack
sudo apt install pipewire-audio



echo 'qpwgraph is a graph manager dedicated to PipeWire (https://pipewire.org),'
echo 'using the Qt C++ framework (https://qt.io), based and pretty much like the'
echo 'same of QjackCtl (https://qjackctl.sourceforge.io).'
echo 'sudo apt install qpwgraph







echo 'Configuring System For Realtime Audio Proudction For Live-Looping Before Installing Pipewire With Qjackctl Configuration Defaults...' echo 


# Real-time kernel (optional, check if a real-time version is available for your distribution)
sudo apt install linux-rt

sudo usermod -a -G audio $USER
sudo usermod -a -G audio jeremy

# sudo apt install pipewire-media-session-jack   <-- required?

sudo apt install pipewire pipewire-audio-client-libraries libjack-jackd2-dev

sudo systemctl --user enable --now pipewire pipewire-pulse
sudo systemctl --user enable --now pipewire-media-session

sudo apt install wireplumber  # Ubuntu example for installing WirePlumber
sudo systemctl --user enable --now wireplumber





pipewire_network() {
# Enable Network Streaming for PipeWire 
 echo "Enabling network streaming for PipeWire..."
 sudo sed -i 's/enable-network = false/enable-network = true/' /etc/pipewire/pipewire-pulse.conf
 echo "Network streaming enabled for PipeWire."
}

pipewire_network



pipewire_test() {
 echo "Test Your Configuration"
 echo "After setting up, you should test if your JACK applications can connect through PipeWire seamlessly:"
 echo ""
 echo "Run a JACK application, such as qjackctl, and it should interface with PipeWire without needing to start jackd."
 echo "Check connections: You can use command-line tools or graphical tools like Helvum or Carla to see if your JACK clients are correctly connecting through PipeWire."
 echo 
 echo "sudo apt install carla"
}

pipewire_test


realtime_config() { 
  echo "Configuring REaltime Audio Services"; echo 
# File path
  FILE_PATH="/etc/security/limits.d/99-realtime-audio.conf"

# Check if the file exists and make a backup
 if [ -f "$FILE_PATH" ]; then
    echo "Backing up existing configuration..."
    sudo cp $FILE_PATH "${FILE_PATH}.bak"
 else
    echo "No existing configuration found, creating new file..."
 fi

# Add real-time and memlock limits for the audio group
 echo "@audio   -  rtprio  95" | sudo tee $FILE_PATH > /dev/null
 echo "@audio   -  memlock unlimited" | sudo tee -a $FILE_PATH > /dev/null

  echo "Real-time configuration has been set."
}

realtime_config



pipewire_control() {
 echo 'sudo apt install gnome-remote-desktop'
 echo 
 echo 'This daemon enables GNOME to offer remote desktop sharing and control'
 echo 'using RDP with PipeWire. It supports GNOME on both X11 and Wayland.'
 echo 'Remote sharing can be enabled and managed in the GNOME Settings app.'
 echo
}

pipewire_control



pulseaudio() {
  sudo apt-get update && sudo apt upgrade

  killall pulseaudio
  pulseaudio --kill
  pulseaudio --start

  sudo apt-get install pulseaudio
  sudo apt-get install pulseaudio-module-jack
}


pipewire_qjackctl_routing_streams() {

	# Print instructions for setting up input and output streams in QjackCtl
	printf "To set the input and output streams in QjackCtl, you can use the pactl command-line tool, which is part of the PulseAudio utilities and compatible with QjackCtl. Here's how you can set up input and output streams:\n\n"

	printf "List Available Sink and Source Devices:\n"
	printf "pactl list sinks\n"
	printf "pactl list sources\n\n"
	printf "This will list all available output (sink) and input (source) devices, respectively. Take note of the names or indices of the devices you want to use.\n\n"

	printf "Set Default Sink and Source:\n"
	printf "pactl set-default-sink <sink_name_or_index>\n"
	printf "pactl set-default-source <source_name_or_index>\n\n"
	printf "Replace <sink_name_or_index> and <source_name_or_index> with the name or index of the sink and source you want to set as default, respectively.\n\n"

	printf "Set Application Output and Input:\n"
	printf "pactl move-sink-input <input_id> <sink_name_or_index>\n"
	printf "pactl move-source-output <output_id> <source_name_or_index>\n\n"
	printf "Replace <input_id> and <output_id> with the ID of the application's input or output stream you want to move, and <sink_name_or_index> or <source_name_or_index> with the name or index of the sink or source you want to move the stream to.\n\n"

	printf "Example:\n"
	printf "pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo\n"
	printf "pactl set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo\n\n"
	printf "This example sets the default output to a specific ALSA sink and the default input to a specific ALSA source.\n\n"

	printf "You can use these commands in a script or directly in the terminal to configure input and output streams in QjackCtl according to your preferences. Make sure to replace the device names or indices with the ones corresponding to your system's configuration.\n"

}
# if else command do not continue until enter is pressed - open shell in new window to configure first before pressing enter
pipewire_qjackctl_routing_streams



# Define the audio interface; use 'cat /proc/asound/cards' to list all sound cards
INTERFACE="hw:0"

# Define the sample rate and buffer size
SAMPLE_RATE=48000
BUFFER_SIZE=1024

# Number of periods. For USB audio devices, a period of 3 is recommended.
PERIODS=3

# Check if jackd is already running
if pgrep -x "jackd" > /dev/null
then
    echo "JACK server is already running."
else
    # Start JACK
    echo "Starting JACK server..."
    /usr/bin/jackd -dalsa -d$INTERFACE -r$SAMPLE_RATE -p$BUFFER_SIZE -n$PERIODS -P -s &
    sleep 2
    echo "JACK server started."
fi

# Check if JACK server started successfully
if pgrep -x "jackd" > /dev/null
then
    echo "JACK server is running."
else
    echo "Failed to start JACK server. Please check the settings and try again."
fi




# bash start_jackd_enhanced.sh 




pipewire_routing() {
# Print instructions for setting up input and output streams in PipeWire
printf "To set the input and output streams in PipeWire, you can use the pactl command-line tool, which is part of the PulseAudio utilities and compatible with PipeWire. Here's how you can set up input and output streams:\n\n"

printf "List Available Sink and Source Devices:\n"
printf "pactl list sinks\n"
printf "pactl list sources\n\n"
printf "This will list all available output (sink) and input (source) devices, respectively. Take note of the names or indices of the devices you want to use.\n\n"

printf "Set Default Sink and Source:\n"
printf "pactl set-default-sink <sink_name_or_index>\n"
printf "pactl set-default-source <source_name_or_index>\n\n"
printf "Replace <sink_name_or_index> and <source_name_or_index> with the name or index of the sink and source you want to set as default, respectively.\n\n"

printf "Set Application Output and Input:\n"
printf "pactl move-sink-input <input_id> <sink_name_or_index>\n"
printf "pactl move-source-output <output_id> <source_name_or_index>\n\n"
printf "Replace <input_id> and <output_id> with the ID of the application's input or output stream you want to move, and <sink_name_or_index> or <source_name_or_index> with the name or index of the sink or source you want to move the stream to.\n\n"

printf "Example:\n"
printf "pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo\n"
printf "pactl set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo\n\n"
printf "This example sets the default output to a specific ALSA sink and the default input to a specific ALSA source.\n\n"

printf "You can use these commands in a script or directly in the terminal to configure input and output streams in PipeWire according to your preferences. Make sure to replace the device names or indices with the ones corresponding to your system's configuration.\n"
}

pipewire_routing

