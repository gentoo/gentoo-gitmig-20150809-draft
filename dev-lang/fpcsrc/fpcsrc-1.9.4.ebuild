# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpcsrc/fpcsrc-1.9.4.ebuild,v 1.1 2004/10/31 04:20:05 chriswhite Exp $

inherit rpm

DESCRIPTION="The sources of the Free Pascal compiler"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/beta/linux-i386-${PV}/fpc-${PV}-0.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_unpack() {
	rpm_unpack ${DISTDIR}/fpc-${PV}-0.src.rpm
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	cd ${WORKDIR}
	tar -zxf fpc-${PV}-src.tar.gz
	dodir /usr/share/src/fpc-${PV}
	mv ${WORKDIR}/compiler ${D}usr/share/src/fpc-${PV}
	mv ${WORKDIR}/demo ${D}usr/share/src/fpc-${PV}
	mv ${WORKDIR}/fcl ${D}usr/share/src/fpc-${PV}
	mv ${WORKDIR}/packages ${D}usr/share/src/fpc-${PV}
	mv ${WORKDIR}/rtl ${D}usr/share/src/fpc-${PV}
}
