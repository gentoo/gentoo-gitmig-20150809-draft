# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dyndnsupdate/dyndnsupdate-0.6.14.ebuild,v 1.4 2003/02/13 14:49:11 vapier Exp $

DESCRIPTION="updates the DNS for your hostname/hostnames and other variables at dyndns.org"
SRC_URI="http://xzabite.org/dyndnsupdate/${P}.tar.gz"
HOMEPAGE="http://xzabite.org/dyndnsupdate/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=""

src_compile() {
	cp Makefile Makefile.old
	sed "s/^\(CFLAGS = \).*/\1$CFLAGS/" Makefile.old > Makefile
	emake || die "Failed to compile."
}

src_install() {                               
	dobin dyndnsupdate
	dodir /var/dyndnsupdate
	doman man/dyndnsupdate.8.gz
	dodoc COPYING ChangeLog INSTALL README
}
