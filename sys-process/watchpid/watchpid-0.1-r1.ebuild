# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/watchpid/watchpid-0.1-r1.ebuild,v 1.2 2006/04/30 17:34:22 swegener Exp $

DESCRIPTION="Watches a process for termination"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.codepark.org/"
KEYWORDS="x86 amd64 -ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README AUTHORS
}
