#!/usr/bin/env python3
""" Takes one positional parameter - an AWS region name
and prints the ipranges in this region.
"""
import requests
import sys
import ipaddress

PREFIXES=set()

try:
    region = sys.argv[1]
except IndexError:
    # If no parameter is given print the all
    region = 'all'

ranges = requests.get('https://ip-ranges.amazonaws.com/ip-ranges.json').json()

for prefix in ranges['prefixes']:
    if prefix['region'] == region or region == 'all':
        PREFIXES.add(prefix['ip_prefix'])

for prefix in sorted(PREFIXES, key = ipaddress.IPv4Network):
    print(prefix)
