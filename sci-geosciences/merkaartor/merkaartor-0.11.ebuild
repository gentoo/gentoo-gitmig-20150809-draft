# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-0.11.ebuild,v 1.3 2008/11/24 17:59:25 hanno Exp $

EAPI="1"

inherit qt4

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.irule.be/bvh/c++/merkaartor/"
SRC_URI="http://www.irule.be/pipe/Merkaartor-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"
DEPEND="x11-libs/qt-webkit:4
	x11-libs/qt-gui:4"
S="${WORKDIR}/${PN}"

src_compile() {
	if use nls; then
		lrelease Merkaartor.pro || die "lrelease failed"
	fi
	eqmake4 Merkaartor.pro PREFIX=/usr || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"
}
