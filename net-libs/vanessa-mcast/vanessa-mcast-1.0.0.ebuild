# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/vanessa-mcast/vanessa-mcast-1.0.0.ebuild,v 1.1 2004/08/31 15:23:34 tantive Exp $

DESCRIPTION="Multicast Helper Library"
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/vanessa_mcast/1.0.0/vanessa_mcast-1.0.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	>=dev-libs/vanessa-logger-0.0.6
	>=net-libs/vanessa-socket-0.0.7"

S=${WORKDIR}/vanessa_mcast-1.0.0

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS TODO INSTALL
}
