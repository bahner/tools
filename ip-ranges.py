#!/usr/bin/env python3
""" Takes one positional parameter - an AWS region name
and prints the ipranges in this region.
"""
import requests
import sys

region = sys.argv[1]

ranges = requests.get('https://ip-ranges.amazonaws.com/ip-ranges.json').json()

for prefix in ranges['prefixes']:
    if prefix['region'] == region or prefix['region'] == "GLOBAL":
        print(prefix['ip_prefix'])
