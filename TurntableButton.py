import os
import serial
import threading

class controllerThread(threading.Thread):
   def run(self):
       while 1:
        while 1:
            msg = ser.readline()
            # print msg
            if msg == "up\r\n":
                os.system("osascript upvote.scpt")
                print "Awesome!"
            if msg == "down\r\n":
                os.system("osascript downvote.scpt")
                print "Lame!"
 
def main():
    print 'exiva\'s Arduino Turntable Controller'
    # Start Serial port
    global ser 
    ser = serial.Serial('/dev/tty.usbserial-A9007QcM', 9600) # Change to your serial port.
    #Spawn threads
    controllerThread().start()
          
if __name__ == "__main__":
  main()