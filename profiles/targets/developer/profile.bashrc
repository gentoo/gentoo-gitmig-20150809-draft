#!/bin/bash

# We change around a few variables, since we've enabled splitdebug.
export CFLAGS="${CFLAGS} -g"
export CXXFLAGS="${CXXFLAGS} -g"
