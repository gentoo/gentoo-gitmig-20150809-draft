# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/vanessa-socket/vanessa-socket-0.0.7.ebuild,v 1.1 2004/08/25 14:35:24 tantive Exp $

DESCRIPTION="Simplifies TCP/IP socket operations."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/vanessa_socket/0.0.7/vanessa_socket-0.0.7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/vanessa-logger-0.0.6"

S=${WORKDIR}/vanessa_socket-0.0.7

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS TODO
}
