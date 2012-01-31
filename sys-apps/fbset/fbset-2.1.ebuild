# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fbset/fbset-2.1.ebuild,v 1.34 2012/01/31 16:12:39 ssuominen Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A utility to set the framebuffer videomode"
HOMEPAGE="http://users.telenet.be/geertu/Linux/fbdev/"
SRC_URI="http://users.telenet.be/geertu/Linux/fbdev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="static"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CC =/s:gcc:$(tc-getCC):" \
		-e "/^CC =/s:-O2:${CFLAGS}:" \
		-e 's/^modes.tab.c/modes.tab.h modes.tab.c/' \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	use static && append-ldflags -static
	emake || die "emake failed"
}

src_install() {
	dobin fbset modeline2fb || die "dobin failed"
	doman *.[58]
	dodoc etc/fb.modes.* INSTALL
}
