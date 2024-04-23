import subprocess

def list_usb_devices():
    # Run the lsusb command and capture its output
    lsusb_output = subprocess.run(['lsusb'], capture_output=True, text=True)
    
    # Split the output into lines
    lines = lsusb_output.stdout.split('\n')
    
    # Parse each line to extract bus number, device number, and description
    usb_devices = []
    for line in lines:
        if line:
            parts = line.split()
            bus_number = parts[1]
            device_number = parts[3][:-1]  # Remove colon at the end
            description = ' '.join(parts[6:])
            usb_devices.append({'bus_number': bus_number, 'device_number': device_number, 'description': description})
    
    return usb_devices

def main():
    # List connected USB devices
    usb_devices = list_usb_devices()
    
    # Print the details of each USB device
    for index, device in enumerate(usb_devices, start=1):
        print(f"Device {index}: Bus {device['bus_number']}, Device {device['device_number']}: {device['description']}")

if __name__ == "__main__":
    main()
