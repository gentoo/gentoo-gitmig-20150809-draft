# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-0.0.10.ebuild,v 1.1 2008/03/24 21:40:13 hanno Exp $

inherit qt4

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.irule.be/bvh/c++/merkaartor/"
SRC_URI="http://www.irule.be/bvh/c++/merkaartor//versions/Merkaartor-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(qt4_min_version 4.3.3)"

S=${WORKDIR}/${PN}

src_compile() {
	eqmake4 Merkaartor.pro || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	dobin release/merkaartor || die "dobin failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"
}
