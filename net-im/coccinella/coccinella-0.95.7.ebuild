# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/coccinella/coccinella-0.95.7.ebuild,v 1.3 2007/04/28 17:34:49 swegener Exp $

NAME=Coccinella
S="${WORKDIR}/${NAME}-${PV}Src"
DESCRIPTION="Virtual net-whiteboard."
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Src.tar.gz"
HOMEPAGE="http://hem.fyristorg.com/matben"
LICENSE="GPL-2"
DEPEND="dev-lang/tk"
KEYWORDS="~mips ~x86"
IUSE=""
SLOT="0"

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/coccinella
	cp -R "${S}"/* ${D}/opt/coccinella/
	fperms 0755 /opt/coccinella/Coccinella.tcl
	dosym Coccinella.tcl /opt/coccinella/coccinella
	doenvd ${FILESDIR}/97coccinella
	dodoc CHANGES README.txt READMEs/README-jabber READMEs/README-smileys
}

pkg_postinst() {
	einfo "To run coccinella just type coccinella"
}
