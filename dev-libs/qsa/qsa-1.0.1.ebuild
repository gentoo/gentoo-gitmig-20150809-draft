# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.0.1.ebuild,v 1.7 2007/03/14 21:40:21 troll Exp $

inherit eutils qt3

IUSE=""
S="${WORKDIR}/${PN}-x11-free-${PV}"
DESCRIPTION="QSA version ${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
SRC_URI="ftp://ftp.trolltech.com/qsa/source/${PN}-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND="$(qt_min_version 3.2)"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-no-examples.diff
	epatch ${FILESDIR}/${P}-sandbox-fix.diff
}

src_compile() {
	./configure -prefix ${D}${QTDIR} -no-ide || die "configure failed"
	emake || die "make failed"
}

src_install() {

	sed -e "s:${S}:${QTBASE}:g" ${S}/.qmake.cache > ${D}/${QTBASE}/.qmake.cache

	make install
	dodoc INSTALL README LICENSE.GPL
}
