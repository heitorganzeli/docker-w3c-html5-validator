import urllib.request
import os
import sys
import subprocess


def main():
    try:
        with urllib.request.urlopen('http://localhost:45000/w3c-validator/', timeout=30):
            print('service ok')
    except:
        os.chdir(os.path.dirname(os.path.realpath(__file__)))
        __execute_system_command("/bin/bash reboot_validator.sh")


def __execute_system_command(command):
    dns_process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
    out, err = dns_process.communicate()
    return out.decode('utf-8')

if __name__ == "__main__":
    main()
