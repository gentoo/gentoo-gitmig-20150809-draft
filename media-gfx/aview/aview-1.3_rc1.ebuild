# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aview/aview-1.3_rc1.ebuild,v 1.2 2001/05/21 17:34:31 achim Exp $

A=${PN}-1.3.0rc1.tar.gz
S=${WORKDIR}/${PN}-1.3.0
DESCRIPTION="An ASCII PNG-Viewer"
SRC_URI="http://prdownloads.sourceforge.net/aa-project/${A}"
HOMEPAGE="http://aa-project.sourceforge.net/aview/" 
DEPEND=">=media-libs/aalib-1.2"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make aview

}

src_install () {

    into /usr
    dobin aview asciiview
    doman *.1 
    dodoc ANNOUNCE COPYING ChangeLog README* TODO

}


