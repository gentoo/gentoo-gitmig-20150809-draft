# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgstats/gpgstats-0.5.ebuild,v 1.1 2005/09/19 03:44:19 robbat2 Exp $

DESCRIPTION="GPGstats calculates statistics on the keys in your key-ring"
HOMEPAGE="http://www.vanheusden.com/gpgstats/"
SRC_URI="http://www.vanheusden.com/gpgstats/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-crypt/gpgme"
DEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	sed -i.orig -e 's,^LDFLAGS=,LDFLAGS=-shared ,g' ${S}/Makefile || die "sed failed"
}

src_compile() {
	emake DEBUG=''
}

src_install() {
	dobin gpgstats
}
