# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/coccinella/coccinella-0.94.7.ebuild,v 1.1 2004/02/29 15:11:44 bass Exp $

NAME=Coccinella
S="${WORKDIR}/${NAME}-${PV}"
DESCRIPTION="Virtual net-whiteboard."
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Linux-x86.tar.gz"
#http://unc.dl.sourceforge.net/sourceforge/coccinella/Coccinella-0.94.7Linux-x86.tar.gz
HOMEPAGE="http://hem.fyristorg.com/matben"
LICENSE="GPL-2"
DEPEND="dev-lang/tk"
KEYWORDS="~x86"
SLOT="0"

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/coccinella
	cp -r ${WORKDIR}/${NAME}-${PV}/* ${D}/opt/coccinella/
	dosym /opt/coccinella/Whiteboard.tcl /opt/coccinella/coccinella
	insinto /etc/env.d
	doins ${FILESDIR}/97coccinella
	dodoc CHANGES README README-jabber README-smileys TechNotes
}

pkg_postinst() {
	einfo "To run coccinella run /opt/coccinella/Whiteboard.tcl"
}
