# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.30.ebuild,v 1.1 2003/04/30 00:03:45 vapier Exp $

DESCRIPTION="small SSH 2 server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/"
SRC_URI="http://matt.ucc.asn.au/dropbear/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin dropbear dropbearkey
	dodoc CHANGES README TODO
}
