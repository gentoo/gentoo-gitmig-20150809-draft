# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fbset/fbset-2.1.ebuild,v 1.25 2004/06/28 16:06:36 vapier Exp $

inherit gcc

DESCRIPTION="A utility to set the framebuffer videomode"
HOMEPAGE="http://linux-fbdev.org/"
SRC_URI="http://home.tvd.be/cr26864/Linux/fbdev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/libc"

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
