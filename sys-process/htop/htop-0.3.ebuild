# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.3.ebuild,v 1.1 2005/03/03 15:12:50 ciaranm Exp $

inherit eutils

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO
}
