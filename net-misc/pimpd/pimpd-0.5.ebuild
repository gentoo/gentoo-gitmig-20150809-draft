# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pimpd/pimpd-0.5.ebuild,v 1.11 2003/09/05 22:01:49 msterret Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="pimpd is a (hopefully) RFC1413-compliant identd server supporting Linux 2.2.x masqueraded connections and Linux 2.4.x connection tracking for use with NAT."
SRC_URI="http://cats.meow.at/~peter/pimpd-0.5.tar.gz"
HOMEPAGE="http://cats.meow.at/~peter/pimpd.html"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	try make CFLAGS="$CFLAGS"
}

src_install () {
	dosbin pimpd
	dodoc README
}
