# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/socnetv/socnetv-0.60.ebuild,v 1.1 2009/05/28 10:31:04 hwoarang Exp $

EAPI="2"

inherit qt4

MY_PN="SocNetV"
MY_PV="${PV/60/6.0}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Qt Social Network Visualizer"
HOMEPAGE="http://socnetv.sourceforge.net/"
SRC_URI="mirror://sourceforge/socnetv/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="x11-libs/qt-gui:4
		x11-libs/qt-webkit:4"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	dobin socnetv || die "dobin failed"
	doicon src/images/socnetv.png || die "doicon failed"
	make_desktop_entry  socnetv "${PN}" socnetv.png 'Science' \
		|| die "make_desktop_entry failed"
	insinto /usr/share/${PN}/examples || die "insinto failed"
	doins nets/* || die "doins failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi
}
