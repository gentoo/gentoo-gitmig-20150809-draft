# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basqet/basqet-0.1.3.ebuild,v 1.1 2010/01/16 20:39:26 spatz Exp $

EAPI="2"
inherit eutils qt4

DESCRIPTION="Keep your notes, pictures, ideas, and information in Baskets"
HOMEPAGE="http://code.google.com/p/basqet/"
SRC_URI="http://basqet.googlecode.com/files/${P}-src.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/release_${PV}"

src_configure() {
	eqmake4 "${PN}".pro PREFIX="${D}/usr" || die "configure failed"
}

src_install() {
	emake install || die "install failed"
}
