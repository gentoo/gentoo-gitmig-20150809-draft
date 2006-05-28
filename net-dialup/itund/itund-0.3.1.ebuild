# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/itund/itund-0.3.1.ebuild,v 1.2 2006/05/28 22:57:24 sbriesen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="ItunD (ISDN tunnel Daemon) provides a network tunnel over ISDN lines using CAPI"
HOMEPAGE="http://sourceforge.net/projects/itund/"
SRC_URI="mirror://sourceforge/itund/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
DEPEND="sys-libs/zlib
	net-dialup/capi4k-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch Makefile to use our CFLAGS
	sed -i -e "s:^\(CFLAGS=.*\) -O2 :\1 ${CFLAGS} :g" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin itund
	dodoc CHANGES README
}
