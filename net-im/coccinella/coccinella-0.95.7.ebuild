# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/coccinella/coccinella-0.95.7.ebuild,v 1.2 2005/08/28 06:22:40 redhatter Exp $

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
	insinto /etc/env.d
	doins ${FILESDIR}/97coccinella
	dodoc CHANGES README.txt READMEs/README-jabber READMEs/README-smileys
}

pkg_postinst() {
	einfo "To run coccinella just type coccinella"
}
