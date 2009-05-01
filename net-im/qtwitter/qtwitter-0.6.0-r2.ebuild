# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qtwitter/qtwitter-0.6.0-r2.ebuild,v 1.1 2009/05/01 15:06:47 hwoarang Exp $

EAPI="2"

inherit qt4 multilib

DESCRIPTION="A Qt client for Twitter"
HOMEPAGE="http://www.qt-apps.org/content/show.php/qTwitter?content=99087"
SRC_URI="http://files.ayoy.net/qtwitter/release/current/src/${P}-r1-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	echo "CONFIG += nostrip" >> "${S}"/${PN}.pro
	sed -i "s/\$\${INSTALL_PREFIX}\/lib/\$\${INSTALL_PREFIX}\/$(get_libdir)/" \
		twitterapi/twitterapi.pro || die "sed failed"
}

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
