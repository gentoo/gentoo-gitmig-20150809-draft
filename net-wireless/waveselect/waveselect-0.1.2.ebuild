# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/waveselect/waveselect-0.1.2.ebuild,v 1.8 2009/12/28 17:22:38 ssuominen Exp $

EAPI=2
inherit eutils qt3

DESCRIPTION="Waveselect is wireless lan connection tool for Linux using QT and wireless-tools."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=19152"
SRC_URI="http://kernelpanic.no/waveselect/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	${QTDIR}/bin/qmake -project || die
	${QTDIR}/bin/qmake || die
	emake || die
}

src_install() {
	dobin waveselect || die
	dodoc README
}
