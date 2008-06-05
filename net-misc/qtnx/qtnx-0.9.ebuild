# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtnx/qtnx-0.9.ebuild,v 1.4 2008/06/05 15:24:06 pva Exp $

EAPI="1"
inherit qt4

MY_P="freenx-client-${PV}"
DESCRIPTION="A Qt-based NX client using nxcl"
HOMEPAGE="http://developer.berlios.de/projects/freenx/"
SRC_URI="mirror://berlios/freenx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-misc/nxcl
	|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 )
		 >=x11-libs/qt-4.3:4 )"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s#id\.key#/usr/share/${PN}/id.key#" qtnxwindow.cpp || die "sed failed"
}

src_compile() {
	eqmake4
	emake || die "Make failed"
}

src_install() {
	dobin ${PN}
	dodoc README

	insinto /usr/share/${PN}
	doins id.key
}
