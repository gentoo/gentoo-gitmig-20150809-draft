# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes Nästén <pekdon@gmx.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}
DESCRIPTION="Screen Shooter"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/"
DEPEND="media-libs/giblib-1.2.1"

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	dobin src/scrot
	dodoc TODO README AUTHORS ChangeLog
}

