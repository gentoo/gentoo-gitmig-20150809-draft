# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-0.0.9.ebuild,v 1.2 2008/07/28 21:37:31 carlo Exp $

EAPI=1

inherit qt4

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.irule.be/bvh/c++/merkaartor/"
SRC_URI="http://www.irule.be/bvh/c++/merkaartor//versions/Merkaartor-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="=x11-libs/qt-4.3*:4"

S=${WORKDIR}/${PN}

src_compile() {
	eqmake4 Merkaartor.pro || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	dobin release/merkaartor || die "dobin failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"
}
