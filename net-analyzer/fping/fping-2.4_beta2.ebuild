# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-2.4_beta2.ebuild,v 1.1 2002/06/28 11:54:12 bangert Exp $

S=${WORKDIR}/fping-2.4b2_to-ipv6
DESCRIPTION="A utility to ping multiple hosts at once"
SRC_URI="http://www.fping.com/download/fping-2.4b2_to-ipv6.tar.gz"
HOMEPAGE="http://www.fping.com/"
SLOT="0"

src_compile() {

	./configure --prefix=/usr \
		--host=${CHOST} || die
		
	make || die
}

src_install () {

	dosbin fping
	doman fping.8
	dodoc COPYING ChangeLog README
}

