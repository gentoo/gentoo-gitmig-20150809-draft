# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openhbci-plugin-ddvcard/openhbci-plugin-ddvcard-0.4.ebuild,v 1.2 2004/06/24 23:17:11 agriffis Exp $

DESCRIPTION="Plugin to use DDV cards with openhbci."
HOMEPAGE="http://openhbci.sourceforge.net/"
SRC_URI="mirror://sourceforge/openhbci/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/openhbci-0.9.13"

src_compile() {
	econf --with-chipcard=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}
