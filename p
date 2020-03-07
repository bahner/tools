#!/bin/bash

gpg --decrypt ~/Dokumenter/.pw.asc 2> /dev/null| egrep -ie "$@"
