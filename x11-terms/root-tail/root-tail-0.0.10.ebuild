# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# /home/cvsroot/gentoo-x86/x11-terms/aterm/,v 1.2 2001/02/15 18:17:31 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Terminal to display (multiple) log files on the root window"
SRC_URI="http://www.goof.com/pcg/marc/data/${A}"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"

DEPEND="virtual/glibc
        virtual/x11"

src_compile() {
    try xmkmf -a
    try make
}

src_install() {
    try make DESTDIR=${D} install install.man
}
