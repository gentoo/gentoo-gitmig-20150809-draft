# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmk/pmk-0.8.ebuild,v 1.1 2004/03/15 17:13:38 dholm Exp $

DESCRIPTION="Aims to be an alternative to GNU autoconf"
SRC_URI="mirror://sourceforge/pmk/${P}.tar.gz"
HOMEPAGE="http://pmk.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_compile() {
	./pmkcfg.sh -p /usr
	make || die "Build failed"
}

src_install () {
	make DESTDIR=${D} MANDIR=/usr/share/man install || die

	dodoc BUGS Changelog INSTALL LICENSE README STATUS TODO
}
