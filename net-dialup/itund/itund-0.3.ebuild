# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/itund/itund-0.3.ebuild,v 1.3 2005/08/20 20:13:00 sbriesen Exp $

inherit eutils

DESCRIPTION="ItunD (ISDN tunnel Daemon) provides a network tunnel over ISDN lines using CAPI"
HOMEPAGE="http://sourceforge.net/projects/itund/"
SRC_URI="mirror://sourceforge/itund/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="sys-libs/zlib
	net-dialup/capi4k-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch Makefile to use our CFLAGS
	sed -i -e "s:^\(CFLAGS=.*\) -O2 :\1 ${CFLAGS} :g" Makefile

	# apply CAPI V3 patch conditionally
	grep 2>/dev/null -q CAPI_LIBRARY_V2 /usr/include/capiutils.h \
		&& epatch "${FILESDIR}/${P}-capiv3.patch"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin itund
	dodoc CHANGES README
}
