# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dyndnsupdate/dyndnsupdate-0.6.15.ebuild,v 1.1 2003/10/30 04:57:33 vapier Exp $

DESCRIPTION="updates the DNS for your hostname/hostnames and other variables at dyndns.org"
HOMEPAGE="http://xzabite.org/dyndnsupdate/"
SRC_URI="http://xzabite.org/dyndnsupdate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "Failed to compile."
}

src_install() {
	dobin dyndnsupdate
	dodir /var/dyndnsupdate
	doman man/dyndnsupdate.8.gz
	dodoc ChangeLog INSTALL README
}
