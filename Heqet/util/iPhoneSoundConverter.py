import os
import sys

path = sys.argv[1] if len(sys.argv) >= 2 else os.getcwd()
os.chdir(path)
path = os.path.abspath(path)
for file in os.listdir(path):
    filename, ext = os.path.splitext(file)
    if ext in ('.wav', '.mp3', '.aif'):
        os.system('/usr/bin/afconvert -f caff -d LEI16 %s %s.caf' % (file, filename))
        print 'create %s.caf' % filename
