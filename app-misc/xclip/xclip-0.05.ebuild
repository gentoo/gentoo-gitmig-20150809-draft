# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xclip/xclip-0.05.ebuild,v 1.1 2001/06/07 06:03:57 grant Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/xclip
DESCRIPTION="Command-line utility to read data from standard in and
 place it in an X selection for pasting into X applications."
SRC_URI="http://www.mercuryit.com.au/~kims/xclip/${A}"
HOMEPAGE=""

DEPEND="virtual/x11"

src_compile() {

    try xmkmf 
    try make

}

src_install () {

    try make DESTDIR=${D} install
    try make DESTDIR=${D} install.man
    dodoc README INSTALL CHANGES

}

