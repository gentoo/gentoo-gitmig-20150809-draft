# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchpid/watchpid-0.1-r1.ebuild,v 1.3 2002/07/14 19:20:20 aliz Exp $

A=${PN}_${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Watches a process for termination"
SRC_URI="http://www.codepark.org/projects/utils/${A}"
HOMEPAGE="http://www.codepark.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_compile() {

	try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	try make DESTDIR=${D} install
	cd ${S}
	dodoc README AUTHORS COPYING NEWS
}



