#!/bin/sh
export PYTHONPATH=${PYTHONPATH}:@PHOOPATH@ 
exec /usr/lib/@PHOOPATH@/curphoo.py
