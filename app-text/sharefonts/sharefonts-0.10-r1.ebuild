# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sharefonts/sharefonts-0.10-r1.ebuild,v 1.1 2001/04/13 14:09:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/fonts/${A}"
HOMEPAGE="http://www.gimp.org"

src_install () {

    dodir /usr/X11R6/lib/X11/fonts/sharefont
    cp -a * ${D}/usr/X11R6/lib/X11/fonts/sharefont
    rm  ${D}/usr/X11R6/lib/X11/fonts/sharefont/README
    dodoc README

}

