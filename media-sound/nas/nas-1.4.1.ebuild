# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/nas/nas-1.4.1.ebuild,v 1.3 2000/11/01 04:44:18 achim Exp $

A=${P}.src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Network Audio System"
SRC_URI="http://radscan.com/nas/${A}"
HOMEPAGE="http://radscan.com/nas.html"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

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

