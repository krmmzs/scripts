#!/usr/bin/env python3

import fileinput
import os

# import you-get

with fileinput.input() as f_input:
    for line in f_input:
        line = line.strip()
        print(f"downloading{line}")
        os.system("you-get " + line)
