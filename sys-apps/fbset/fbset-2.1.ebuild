# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fbset/fbset-2.1.ebuild,v 1.22 2004/03/22 03:04:37 vapier Exp $

inherit gcc

DESCRIPTION="A utility to set the framebuffer videomode"
HOMEPAGE="http://linux-fbdev.org/"
SRC_URI="http://home.tvd.be/cr26864/Linux/fbdev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ia64 ppc64 s390"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CC =/s:gcc:$(gcc-getCC):" \
		-e "/^CC =/s:-O2:${CFLAGS}:" \
		Makefile || die
}

src_compile() {
	make || die
}

src_install() {
	dobin fbset modeline2fb || die
	doman *.[58]
	dodoc etc/fb.modes.* INSTALL
}
