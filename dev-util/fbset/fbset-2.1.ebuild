# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/fbset/fbset-2.1.ebuild,v 1.1 2001/02/09 07:38:39 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A utility to set the framebuffer videomode"
SRC_URI="http://home.tvd.be/cr26864/Linux/fbdev/${A}"
HOMEPAGE="http://linux-fbdev.org"


src_compile() {

    try make

}

src_install () {

    dobin fbset modeline2fb
    doman *.[58]
    dodoc etc/fb.modes.*
    dodoc INSTALL

}

