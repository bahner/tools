#!/usr/bin/env python3
""" Takes one positional parameter an AWS region name

Prints the ipranges in this region.
"""

import sys
import requests

try:
    region = sys.argv[1]
except IndexError:
    region = 'any'

ranges = requests.get('https://ip-ranges.amazonaws.com/ip-ranges.json').json()
prefixes = set()

for prefix in ranges['prefixes']:
    if prefix['region'] == region or region == 'any':
        prefixes.add(prefix['ip_prefix'])

for prefix in sorted(prefixes):
    print(prefix)
