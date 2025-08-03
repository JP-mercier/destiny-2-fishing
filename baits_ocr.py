# pip install pytesseract pillow keyboard opencv-python numpy screeninfo
import pytesseract
from PIL import ImageGrab, Image
import keyboard
import os
import cv2
import numpy as np
from datetime import datetime
from screeninfo import get_monitors

# Set the path to the Dropbox directory
dropbox_dir = r"C:\Users\Jean-Philippe\dropbox"

isdir = os.path.isdir(dropbox_dir)
print(isdir)

# Get screen size
monitor = get_monitors()[0]
width = monitor.width
height = monitor.height

# Define the coordinates of the area to capture based on screen size
if width == 1920 and height == 1080:
    x1, y1, x2, y2 = 0, 0, 1920, 1080
elif width == 2560 and height == 1440:
    x1, y1, x2, y2 = 0, 0, 2560, 1440

# Set the path to the tesseract executable
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe' # Path to the tesseract executable

while True:
    keyboard.wait("k")

    # Capture the screen area
    image = ImageGrab.grab(bbox=(x1, y1, x2, y2))
    keyboard.press_and_release('b')

    # Convert the image to grayscale
    gray = cv2.cvtColor(np.array(image), cv2.COLOR_BGR2GRAY)

    # Apply a threshold to create a binary image
    _, thresh = cv2.threshold(gray, 150, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

    # Use OCR to extract text from the binary image
    text = pytesseract.image_to_string(Image.fromarray(thresh))

    # Find the index of "Bait: " in the text
    index = text.find("Bait:")

    # Isolate everything after "Bait: "
    if index != -1:
        bait_text = text[index + len("Bait:"):]

        # Find the index of "/500" in the bait_text
        index2 = bait_text.find("/500")

        # Remove everything after "/500" as well as "/500" itself
        if index2 != -1:
            final_text = bait_text[:index2]
            print(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - baits: {final_text}/500")
            with open("baits.txt", "w") as f:
                f.write(final_text)
            if isdir == True:
                with open(os.path.join(dropbox_dir, "baits.txt"), "a") as f:
                    f.write(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - baits: {final_text}/500\n")
        else:
            print(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Could not find '/500' in the bait_text")
            if isdir == True:
                with open(os.path.join(dropbox_dir, "baits.txt"), "a") as f:
                    f.write(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Could not find '/500' in the bait_text\n")
    else:
        print(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Could not find 'Bait: ' in the text")
        if isdir == True:
            with open(os.path.join(dropbox_dir, "baits.txt"), "a") as f:
                f.write(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Could not find 'Bait: ' in the text\n")
