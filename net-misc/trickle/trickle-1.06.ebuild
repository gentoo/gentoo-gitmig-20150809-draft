# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/trickle/trickle-1.06.ebuild,v 1.2 2004/04/26 12:44:43 agriffis Exp $

DESCRIPTION="a portable lightweight userspace bandwidth shaper"
SRC_URI="http://www.monkey.org/~marius/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.monkey.org/~marius/trickle/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="BSD"
IUSE=""

DEPEND="virtual/glibc
	dev-libs/libevent
	sys-apps/sed"
RDEPEND="virtual/glibc"

src_compile() {
	econf || die "econf failed"
	make PREFIX=/usr || die
}

src_install() {
	einstall || die
}
