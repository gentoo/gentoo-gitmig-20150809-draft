# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/shed/shed-1.13.ebuild,v 1.1 2007/03/11 15:36:33 hattya Exp $

IUSE=""

DESCRIPTION="Simple Hex EDitor"
HOMEPAGE="http://shed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5.3"

src_compile() {

	econf || die
	emake AM_CFLAGS="${CFLAGS}" || die

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README TODO

}
