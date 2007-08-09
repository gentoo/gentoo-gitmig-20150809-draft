#!/bin/bash


## Change locale if utf8 is used

LC_ALL="$(echo ${LC_ALL:0:5})" /usr/bin/xmgrace $*

