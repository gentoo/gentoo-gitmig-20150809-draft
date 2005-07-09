# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.5.2.ebuild,v 1.4 2005/07/09 04:34:08 josejx Exp $

inherit eutils flag-o-matic

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="debug"
DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	use debug && {
		append-flags -O -ggdb -DDEBUG
		RESTRICT="${RESTRICT} nostrip"
	}
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO
}
