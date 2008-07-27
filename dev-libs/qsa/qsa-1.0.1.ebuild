# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.0.1.ebuild,v 1.8 2008/07/27 20:15:59 carlo Exp $

EAPI=1

inherit eutils qt3

IUSE=""
S="${WORKDIR}/${PN}-x11-free-${PV}"
DESCRIPTION="Qt Script for Applications."
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
SRC_URI="ftp://ftp.trolltech.com/qsa/source/${PN}-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-examples.diff
	epatch "${FILESDIR}"/${P}-sandbox-fix.diff
}

src_compile() {
	./configure -prefix "${D}${QTDIR}" -no-ide || die "configure failed"
	emake || die "make failed"
}

src_install() {

	sed -e "s:${S}:${QTBASE}:g" "${S}"/.qmake.cache > "${D}/${QTBASE}"/.qmake.cache

	make install
	dodoc INSTALL README
}
