# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/waveselect/waveselect-0.1.2.ebuild,v 1.3 2005/07/01 15:11:10 caleb Exp $

inherit kde

DESCRIPTION="Waveselect is wireless lan connection tool for Linux using QT and wireless-tools."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=19152"
SRC_URI="http://kernelpanic.no/waveselect/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}

RDEPEND="net-wireless/wireless-tools
		>=x11-libs/qt-3.3.3"
need-qt 3

src_compile() {
	${QTDIR}/bin/qmake -project || die
	${QTDIR}/bin/qmake || die
	make || die
}

src_install() {
	dobin waveselect
	dodoc README
}
