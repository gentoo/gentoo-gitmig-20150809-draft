#!/usr/bin/env spython

# This script will take a list of ebuild files, sort them in the order
# of their dependencies, then print them back out. (That is, for any
# given package, its dependencies will be printed out *before* the
# package itself.) Needed for the autodist.sh script.

import portage
import sys
import os

class depgraph:
    pass

class depgraph_node:
    def __init__(self, info):
        self.__info = info

class packagelisttree(portage.packagetree):
    def __init__(self, listfile, virtual=None):
        portage.packagetree.__init__(self, virtual)
        self.listfile = listfile

class ebuildinfo:
    def __init__(self, ebuildfile):
        if not os.path.exists(ebuildfile):
            print "!!! %s is an invalid ebuild file name!" % (ebuildfile)
            sys.exit(1)
        if ebuildfile[0:2] == './':
            ebuildfile = ebuildfile[2:]
        self.filename = ebuildfile
        self.category = os.path.basename(os.path.normpath(os.path.dirname(ebuildfile) + "/.."))
        self.pf = os.path.basename(ebuildfile[:-7])
        pkgsplit = portage.pkgsplit(self.pf, 0)
        if pkgsplit == None:
            print "!!! %s is an invalid ebuild file name!" % (ebuildfile)
            sys.exit(1)
        self.pn = pkgsplit[0]
        self.pv = pkgsplit[1]
        self.p = "%s-%s" % (self.pn, self.pv)
        if pkgsplit[2] == "0":
            self.pvr = self.pv
        else:
            self.pvr = "%s-r%s" % (self.pv, pkgsplit[2])

