# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.10.ebuild,v 1.4 2006/10/21 22:10:00 tcort Exp $

DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="mirror://sourceforge/qstat/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc-macos ppc64 x86"
IUSE="debug"

DEPEND=""

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dosym qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt template/README.txt
	dohtml template/*.html qstatdoc.html
}
