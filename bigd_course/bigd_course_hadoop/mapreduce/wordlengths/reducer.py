#!/usr/bin/env python3
import sys

current_length = None
current_count = 0

for line in sys.stdin:
    length, count = line.strip().split('\t', 1)
    count = int(count)
    if length == current_length:
        current_count += count
    else:
        if current_length:
            print(str(current_length) + "\t" + str(current_count))
        current_length = length
        current_count = count

if current_length:
    print(str(current_length) + "\t" + str(current_count))
