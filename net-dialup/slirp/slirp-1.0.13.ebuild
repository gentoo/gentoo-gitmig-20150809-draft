# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slirp/slirp-1.0.13.ebuild,v 1.1 2005/04/20 22:57:50 mrness Exp $

DESCRIPTION="Emulates a PPP or SLIP connection over a terminal"
HOMEPAGE="http://slirp.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/slirp/${P}.tar.gz"

KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="Artistic"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	cd src
	./configure || die "configure failed"
	make || die "make failed"
}

src_install() {
	dobin src/slirp
	cp src/slirp.man slirp.1
	doman slirp.1
	dodoc docs/* README.NEXT README ChangeLog COPYRIGHT
}
