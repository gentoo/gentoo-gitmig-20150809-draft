#!/bin/sh
export PYTHONPATH=${PYTHONPATH}:@PHOOPATH@ 
export TERM=linux
exec /usr/lib/@PHOOPATH@/curphoo.py
