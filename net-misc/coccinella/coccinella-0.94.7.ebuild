# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/coccinella/coccinella-0.94.7.ebuild,v 1.3 2004/07/15 02:42:48 agriffis Exp $

NAME=Coccinella
S="${WORKDIR}/${NAME}-${PV}"
DESCRIPTION="Virtual net-whiteboard."
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Linux-x86.tar.gz"
#http://unc.dl.sourceforge.net/sourceforge/coccinella/Coccinella-0.94.7Linux-x86.tar.gz
HOMEPAGE="http://hem.fyristorg.com/matben"
LICENSE="GPL-2"
DEPEND="dev-lang/tk"
KEYWORDS="~x86"
IUSE=""
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
