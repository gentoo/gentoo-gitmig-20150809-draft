# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dyndnsupdate/dyndnsupdate-0.6.15.ebuild,v 1.6 2004/07/15 02:45:06 agriffis Exp $

inherit eutils

DESCRIPTION="updates the DNS for your hostname/hostnames and other variables at dyndns.org"
HOMEPAGE="http://xzabite.org/dyndnsupdate/"
SRC_URI="http://xzabite.org/dyndnsupdate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-resolution-segfault-fix.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "Failed to compile."
}

src_install() {
	dobin dyndnsupdate
	keepdir /var/dyndnsupdate
	doman man/dyndnsupdate.8.gz
	dodoc ChangeLog INSTALL README
}
