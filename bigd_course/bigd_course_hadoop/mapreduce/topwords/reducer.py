#!/usr/bin/env python3
import sys

word_counts = {}

for line in sys.stdin:
    word, count = line.strip().split('\t', 1)
    count = int(count)
    if word in word_counts:
        word_counts[word] += count
    else:
        word_counts[word] = count

top5 = sorted(word_counts.items(), key=lambda x: x[1], reverse=True)[:5]

for word, count in top5:
    print(word + "\t" + str(count))
    
