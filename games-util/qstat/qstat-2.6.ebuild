# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.6.ebuild,v 1.3 2005/01/20 23:26:41 gongloo Exp $

DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="mirror://sourceforge/qstat/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS} -Dsysconfdir=\\\"/etc\\\"" || die "emake failed"
}

src_install() {
	dobin qstat || die "dobin failed"
	dosym qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt
	dohtml template/* qstatdoc.html
}
