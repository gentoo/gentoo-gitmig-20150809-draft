# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.0_pre20030513.ebuild,v 1.1 2003/05/24 11:31:17 brain Exp $

inherit eutils kde-functions

IUSE=""
S="${WORKDIR}/qsa-x11-free-20030513"
DESCRIPTION="QSA version ${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86" 
SRC_URI="ftp://ftp.trolltech.com/qsa/qsa-x11-free-20030513.tar.gz"
HOMEPAGE="http://www.trolltech.com/"
DEPEND=">=x11-libs/qt-3.1.2-r3"

set-qtdir 3.1

src_compile() {
	epatch ${FILESDIR}/${P}-libdir-patch.diff
	./configure -prefix ${D}${QTDIR} || die
	emake || die
}

src_install() {
    into ${QTDIR}
	dolib.so lib/*
	insinto ${QTDIR}/plugins/designer/
	doins plugins/designer/* -m0775
	dodoc INSTALL
}
