# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/nas/nas-1.4.1.ebuild,v 1.2 2000/10/23 11:27:15 achim Exp $

A=${P}.src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Network Audio System"
SRC_URI="http://radscan.com/nas/${A}"
HOMEPAGE="http://radscan.com/nas.html"


src_compile() {

    cd ${S}
    try xmkmf
    try make WORLDOPTS='-k CDEBUGFLAGS="$(CDEBUGFLAGS) -DSTARTSERVER"' World

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc BUGS BUILDNOTES FAQ HISTORY README RELEASE TODO doc/*.ps
}

