#!/bin/bash

source tests-common.sh

inherit eutils

# bug 395025
eshopts_push -s nullglob
eshopts_pop

texit
