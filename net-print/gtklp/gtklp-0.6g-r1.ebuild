# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.6g-r1.ebuild,v 1.2 2002/05/23 06:50:18 seemant Exp $

S=${WORKDIR}/src
DESCRIPTION="A GUI fort cupsd"
SRC_URI="http://www.stud.uni-hannover.de/~sirtobi/gtklp/files/${P}.src.tgz"
HOMEPAGE="http://www.stud.uni-hannover.de/~sirtobi/gtklp"

DEPEND="virtual/glibc =x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7"

src_compile() {
    try make CCFLAGS="$CFLAGS"
}

src_install () {
    into /usr
    dobin gtklp
    dodoc gtklprc.path.sample
    docinto html
    dodoc doc/*.html doc/*.jpg doc/*.gif

}

