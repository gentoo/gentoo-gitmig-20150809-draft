# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/vanessa-socket/vanessa-socket-0.0.5_beta4.ebuild,v 1.1 2003/03/15 07:44:11 george Exp $

DESCRIPTION="Simplifies TCP/IP socket operations."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/perdition/download/BETA/1.11beta5/vanessa_socket-0.0.5beta4.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=vanessa-logger-0.0.4_beta2"
S=${WORKDIR}/vanessa_socket-0.0.5beta4

src_compile() {
	econf

	emake || die
}

src_install() {
	einstall
	dodoc README NEWS AUTHORS TODO
}
