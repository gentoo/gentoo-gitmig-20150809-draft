# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/watchpid/watchpid-0.1-r1.ebuild,v 1.1 2005/03/03 16:20:18 ciaranm Exp $

DESCRIPTION="Watches a process for termination"
SRC_URI="http://www.codepark.org/projects/utils/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.codepark.org/"
KEYWORDS="x86 amd64 -ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/libc"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} || die
	make ${MAKEOPTS} || die
}

src_install() {
	make DESTDIR=${D} install || die
	cd ${S}
	dodoc README AUTHORS COPYING NEWS
}
