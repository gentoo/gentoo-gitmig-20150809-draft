####################################################################
#         Copyright 1999-2003 Gentoo Technologies, Inc.            #
# Distributed under the terms of the GNU General Public License v2 #
####################################################################
#
# p	do not enforce paging based non-executable pages
# e	do not emulate trampolines
# r	do not randomize mmap() base [ELF only]
# m	do not restrict mprotect()
# s	do not enforce segmentation based non-executable pages
# x	do not randomize ET_EXEC base [ELF only]

PAGEEXEC_EXEMPT="/usr/X11R6/bin/XFree86 /usr/lib/wine/bin/wine"
TRAMPOLINE_EXEMPT=""
MPROTECT_EXEMPT=""
MMAP_EXEMPT=""
SEGEXEC_EXEMPT=""
RANDEXEC_EXEMPT=""
