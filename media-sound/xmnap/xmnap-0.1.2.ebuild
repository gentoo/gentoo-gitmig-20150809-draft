# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmnap/xmnap-0.1.2.ebuild,v 1.1 2000/09/16 16:46:53 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Motif based Napster Client"
SRC_URI="http://home.swipnet.se/~w-10246/linux/${A}"
HOMEPAGE="http://home.swipnet.se/~w-10246/linux/"


src_compile() {

    cd ${S}
    try xmkmf -a
    try make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin xmnap
    insinto /etc/X11/app-defaults/XmNap
    doins XmNap.ad
    insinto /usr/X11R6/include/bitmaps/xmnap
    doins images/*.xpm

}

