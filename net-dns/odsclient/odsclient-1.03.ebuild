# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/odsclient/odsclient-1.03.ebuild,v 1.1 2008/01/21 19:15:11 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Client for the Open Domain Server's dynamic dns"
HOMEPAGE="http://www.ods.org/"
SRC_URI="http://www.ods.org/dl/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/C=gcc -Wall/C=$(tc-getCC)/g" \
		-e "s/CFLAGS=-O2/CFLAGS=${CFLAGS}/g" \
		Makefile || die "sed failed"

	epatch "${FILESDIR}"/${PV}-gentoo.patch
}

src_install() {
	dosbin odsclient
	dodoc README
}
