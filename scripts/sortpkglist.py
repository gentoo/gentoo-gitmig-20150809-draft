#!/usr/bin/env spython

# This script will take a list of ebuild files, sort them in the order
# of their dependencies, then print them back out. (That is, for any
# given package, its dependencies will be printed out *before* the
# package itself.) Needed for the autodist.sh script.

import portage
import sys

digraph = portage.digraph()

if len(sys.argv) != 2:
	print 'usage: %s packagelist' % sys.argv[0]

try:
	packagelist = open(sys.argv[1], "r")
except:
	sys.stderr.write("could not open %s\n" % sys.argv[1])
	sys.exit(1)

packages = packagelist.readlines()
