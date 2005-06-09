# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.4.6a.ebuild,v 1.6 2005/06/09 11:40:22 ka0ttic Exp $

DESCRIPTION="classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# access violation - bug 95364
	sed -i 's|[^)]\($(pkgdatadir)\)| $(DESTDIR)\1|' doc/Makefile.in || \
		die "sed doc/Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
