#!/usr/bin/python
import psutil
import os
from termcolor import colored 
import power


def status():
    sta = open("/sys/class/power_supply/BAT0/status","r").readline().strip()
    print (sta)


def main():
    icons = {
            10: " ",
            20: " ",
            30: " ",
            40: " ",
            50: " ",
            60: " ",
            70: " ",
            80: " ",
            90: " ",
            100: " ",
            
            }
    colorIcon = {100: "ﮤ"}
    #per = os.system("acpi -b | grep -E -o '[0-9][0-9]?%'")
    
    percent = psutil.sensors_battery().percent
    val = int(percent)
    to = (percent + 9) // 10 * 10
    if(val >= 100):
        print(f"{icons[to]} " + f"{colorIcon[to]}")
    else:
        print(f"{icons[to]} " + str(val) + "%")
    status()
main()
