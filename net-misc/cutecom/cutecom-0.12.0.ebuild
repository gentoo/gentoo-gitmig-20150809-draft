# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cutecom/cutecom-0.12.0.ebuild,v 1.3 2005/01/25 18:15:10 greg_g Exp $

inherit eutils

DESCRIPTION="CuteCom is a serial terminal, like minicom, written in qt"
HOMEPAGE="http://cutecom.sourceforge.net"
SRC_URI="http://cutecom.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=x11-libs/qt-3.2.0"

src_compile() {
	addwrite "${QTDIR}/etc/settings"
	econf
	emake
}

src_install() {
	dobin "cutecom"
	dodoc README Changelog COPYING README

	make_desktop_entry cutecom "CuteCom" openterm
}
