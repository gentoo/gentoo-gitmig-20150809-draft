# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.00.ebuild,v 1.1 2002/10/19 20:55:55 mjc Exp $

IUSE="gtk"

myarch=`uname -m`
S="${WORKDIR}/${PN}-distrib-${PV}"
DESCRIPTION="A new client for eDonkey, for file sharing."
SRC_URI="http://savannah.nongnu.org/download/mldonkey/stable/${P}.shared.${myarch}-Linux.tar.bz2"
HOMEPAGE="http://go.to/mldonkey"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="gtk? ( x11-libs/gtk+ )"

src_compile() {
	einfo "Nothing to compile for ${P}."
}
src_install () {
	dodoc ChangeLog Readme.txt TODO
	rm -f ${WORKDIR}/${PN}-distrib-${PV}/ChangeLog
	rm -f ${WORKDIR}/${PN}-distrib-${PV}/Readme.txt
	rm -f ${WORKDIR}/${PN}-distrib-${PV}/TODO
	rm -f ${WORKDIR}/${PN}-distrib-${PV}/mldonkey_gui_started_for_macosx
	dodir /opt/mldonkey
	cp -r ${WORKDIR}/${PN}-distrib-${PV}/* ${D}/opt/mldonkey
	insinto /etc/env.d
	doins ${FILESDIR}/97mldonkey
}
pkg_postinst () {
	einfo "The client command is mldonkey."
	einfo "The GUI needs GTK and the command is mldonkey_gui"
	einfo "mldonkey read the config from the dir where you are, and"
	einfo "create it if don't exist, so run the command ever in the"
	einfo "ever in the same dir. I spear to solve it in next relase"
}
