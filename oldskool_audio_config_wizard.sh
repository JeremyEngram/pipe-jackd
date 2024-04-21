#!/bin/bash

echo "Alsa & Pulseaudio - Backup And Restore Wizard";

# Backup ALSA and PulseAudio configurations
backup_configurations() {
    # Backup ALSA configuration
    sudo cp /etc/asound.conf /etc/asound.conf.backup

    # Backup PulseAudio configuration
    sudo cp -r /etc/alsa /etc/alsa.backup
    sudo cp -r /etc/pulse /etc/pulse.backup

    sudo zip -r ¬/alsabackup.zip /etc/alsa
    sudo zip -r ¬/pulsebackup.zip /etc/pulse
}

# Restore ALSA and PulseAudio configurations
restore_configurations() {
    # Restore ALSA configuration
    sudo cp /etc/asound.conf.backup /etc/asound.conf

    # Restore PulseAudio configuration
    sudo rm -rf /etc/pulse
    sudo cp -r /etc/pulse.backup /etc/pulse
}

# Main script
echo "Welcome to the ALSA and PulseAudio Backup and Restore script!"
echo "What would you like to do?"
echo "1. Backup ALSA and PulseAudio configurations"
echo "2. Restore ALSA and PulseAudio configurations"
read -p "Enter your choice (1 or 2): " choice

case "$choice" in
    1)
        echo "Backing up ALSA and PulseAudio configurations..."
        backup_configurations
        echo "Backup complete."
        ;;
    2)
        echo "Restoring ALSA and PulseAudio configurations..."
        restore_configurations
        echo "Restoration complete."
        ;;
    *)
        echo "Invalid choice. Please enter either 1 or 2."
        ;;
esac
