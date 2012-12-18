import sys
from termios import *

# Indexes for termios list.
IFLAG = 0
OFLAG = 1
CFLAG = 2
LFLAG = 3
ISPEED = 4
OSPEED = 5
CC = 6

def setcbreak():
    mode = tcgetattr(sys.stdin)

    oldLFLAG = mode[LFLAG]
    oldVMIN = mode[CC][VMIN]
    oldVTIME = mode[CC][VTIME]

    mode[LFLAG] = mode[LFLAG] & ~(ECHO | ICANON) 
    mode[CC][VMIN] = 1
    mode[CC][VTIME] = 0

    tcsetattr(sys.stdin, TCSAFLUSH, mode)
    return (oldLFLAG,oldVMIN,oldVTIME)

def unsetcbreak(oldLFLAG,oldVMIN,oldVTIME):
    mode = tcgetattr(sys.stdin)
    mode[LFLAG] = oldLFLAG
    mode[CC][VMIN] = oldVMIN
    mode[CC][VTIME] = oldVTIME

    tcsetattr(sys.stdin, TCSAFLUSH, mode)

def start():
    (oldLFLAG,oldVMIN,oldVTIME) = setcbreak()
    try:
        while True:
            s = sys.stdin.read(1)
            c = ord(s)
            hx = s.encode('hex')
            oc = oct(ord(s))
            
            print s + "  "+ str(c) + "  " + str(hx) + "  " + str(oc)
    finally:
        unsetcbreak(oldLFLAG,oldVMIN,oldVTIME)

if __name__ == "__main__":
    start()

