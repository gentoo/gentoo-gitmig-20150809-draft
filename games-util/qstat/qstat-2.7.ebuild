# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.7.ebuild,v 1.1 2004/12/24 07:41:27 vapier Exp $

DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="mirror://sourceforge/qstat/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="debug"

DEPEND="virtual/libc"

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
