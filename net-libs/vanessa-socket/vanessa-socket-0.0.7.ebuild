# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/vanessa-socket/vanessa-socket-0.0.7.ebuild,v 1.3 2005/01/21 19:07:46 xmerlin Exp $

DESCRIPTION="Simplifies TCP/IP socket operations."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/vanessa_socket/0.0.7/vanessa_socket-0.0.7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/vanessa-logger-0.0.6"

S=${WORKDIR}/vanessa_socket-0.0.7

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS TODO
}
