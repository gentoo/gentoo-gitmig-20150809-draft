# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-admin/qtsvc/qtsvc-0.1.ebuild,v 1.1 2001/01/27 11:33:46 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A QT frontend for svc"
SRC_URI="http://www.together.net/~plomp/${A}"
HOMEPAGE="http://www.together.net/~plomp/qtsvc.html"

DEPEND=">=x11-libs/qt-x11-2.2.3"
RDEPEND="$DEPEND
	 >=sys-apps/daemontools-0.70"

src_unpack() {

    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/qtsvc-0.1.diff
}

src_compile() {

    try ./configure --host=${CHOST}
    try make CPPFLAGS=\"${CPPFLAGS} -fkeep-inline-functions\"

}

src_install () {

    into /usr/X11R6
    dobin qtsvc/qtsvc    
    dodoc README qtsvc/MANUAL qtsvc/LICENSE qtsvc/PROGRAMMING

}

