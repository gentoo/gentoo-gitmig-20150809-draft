#!/usr/bin/env spython

# This script will take a list of ebuild files, sort them in the order
# of their dependencies, then print them back out. (That is, for any
# given package, its dependencies will be printed out *before* the
# package itself.) Needed for the autodist.sh script.

import portage
import sys

