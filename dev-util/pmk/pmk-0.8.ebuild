# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmk/pmk-0.8.ebuild,v 1.2 2004/04/17 06:39:41 mr_bones_ Exp $

DESCRIPTION="Aims to be an alternative to GNU autoconf"
SRC_URI="mirror://sourceforge/pmk/${P}.tar.gz"
HOMEPAGE="http://pmk.sourceforge.net/"

LICENSE="BSD"
IUSE=""
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	./pmkcfg.sh -p /usr
	make || die "Build failed"
}

src_install () {
	make DESTDIR=${D} MANDIR=/usr/share/man install || die

	dodoc BUGS Changelog INSTALL LICENSE README STATUS TODO
}
