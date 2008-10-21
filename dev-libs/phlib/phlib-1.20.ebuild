# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/phlib/phlib-1.20.ebuild,v 1.5 2008/10/21 14:07:00 loki_val Exp $

inherit eutils

DESCRIPTION="phlib is a collection of support functions and classes used by Goldwater and the DGEE"
HOMEPAGE="http://www.nfluid.com/"
SRC_URI="http://www.nfluid.com/download/src/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i s/cflags/CFLAGS/ configure
	epatch "${FILESDIR}/${PN}-types.patch"
	epatch "${FILESDIR}/${PN}-soname.patch"
}

src_compile() {
	CFLAGS="${CFLAGS} -fPIC -Wall"
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
}
