#!/usr/bin/env python3
import sys
import re

stop_words = {
    'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for',
    'of', 'with', 'by', 'from', 'up', 'about', 'into', 'through', 'during',
    'before', 'after', 'above', 'below', 'between', 'among', 'is', 'are',
    'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having',
    'do', 'does', 'did', 'doing', 'would', 'could', 'should', 'may', 'might',
    'must', 'can', 'shall', 'will', 'this', 'that', 'these', 'those', 'i',
    'you', 'he', 'she', 'it', 'we', 'they', 'me', 'him', 'her', 'us', 'them'
}

pattern = re.compile(r"[a-zA-Z]+(?:'[a-zA-Z]+)?")

for line in sys.stdin:
    line = line.lower()
    words = pattern.findall(line)
    for w in words:
        if w.count("'") > 1:
            continue
        if w.startswith("'"):
            continue
        if len(w) <= 2:
            continue
        if w in stop_words:
            continue
        print(w + "\t1")
