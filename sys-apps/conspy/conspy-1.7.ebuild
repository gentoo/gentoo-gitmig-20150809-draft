# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/conspy/conspy-1.7.ebuild,v 1.1 2009/12/26 14:28:03 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="Remote control for virtual consoles"
HOMEPAGE="http://ace-host.stuart.id.au/russell/files/conspy"
SRC_URI="http://ace-host.stuart.id.au/russell/files/${PN}/${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	dohtml ${PN}.html
}
