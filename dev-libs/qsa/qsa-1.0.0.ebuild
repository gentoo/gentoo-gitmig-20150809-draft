# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.0.0.ebuild,v 1.1 2003/07/03 13:34:39 brain Exp $

inherit eutils kde-functions

IUSE=""
S="${WORKDIR}/${PN}-x11-free-${PV}"
DESCRIPTION="QSA version ${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86" 
SRC_URI="ftp://ftp.trolltech.com/qsa/source/${PN}-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"
DEPEND=">=x11-libs/qt-3.1.2-r3"

set-qtdir 3.1

src_compile() {
	epatch ${FILESDIR}/${P}-no-examples.diff
	epatch ${FILESDIR}/${P}-sandbox-fix.diff
	./configure -prefix ${D}${QTDIR} -no-ide || die
	emake || die
}

src_install() {
    make install
	dodoc INSTALL README LICENSE.GPL
}
