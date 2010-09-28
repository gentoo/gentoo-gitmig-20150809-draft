# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upm/upm-0.85-r1.ebuild,v 1.1 2010/09/28 19:22:44 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="The micro Package Manager"
HOMEPAGE="http://u-os.org/upm.html"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/uos/sputnik/sources/${P}.tar.gz"

LICENSE="4F"
SLOT="0"
KEYWORDS="~alpha ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="sys-apps/fakeroot"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-static.patch # bug 264067
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile failed"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir /bin
	make DESTDIR="${D}" install || die "make install failed"
	dodir /usr/upm/installed
	dodir /var/upm/{binary,cache}
}
