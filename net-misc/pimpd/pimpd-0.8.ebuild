# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pimpd/pimpd-0.8.ebuild,v 1.12 2004/06/25 00:04:57 agriffis Exp $

DESCRIPTION="RFC1413-compliant identd server supporting masqueraded connections"
HOMEPAGE="http://cats.meow.at/~peter/pimpd.html"
SRC_URI="http://cats.meow.at/~peter/pimpd_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

src_compile() {
	make CFLAGS="$CFLAGS" || die
}

src_install() {
	dosbin pimpd
	dodoc README
}
