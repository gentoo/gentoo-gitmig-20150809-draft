# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xsnap/xsnap-1.3.ebuild,v 1.1 2001/06/07 06:20:53 grant Exp $

#P=
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Program to interactively take a 'snapshot' of a region of 
the screen"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${A}"
HOMEPAGE=""

DEPEND="virtual/x11"

src_compile() {

    try xmkmf 
    try make

}

src_install () {

    try make DESTDIR=${D} install
    try make DESTDIR=${D} install.man
    dodoc README INSTALL AUTHORS

}

