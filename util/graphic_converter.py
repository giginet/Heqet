import re
import os
import sys
from PIL import Image

path = sys.argv[1] if len(sys.argv) >= 2 else os.getcwd()
os.chdir(path)
path = os.path.abspath(path)
files = os.listdir(path)
for file in files:
    filename, ext = os.path.splitext(file)
    ext = ext.lower()
    if ext in ('.png',):
        img = Image.open(file)
        tmb = img.copy()
        width, height = img.size
        tmb.thumbnail((width / 2, height / 2))
        print filename
        if re.search(r'\-hd$', filename):
            tmb.save('%s%s' % (filename[:-3], ext))
        else:
            os.rename(file, '%s-hd%s' % (filename, ext))
            tmb.save(file)
