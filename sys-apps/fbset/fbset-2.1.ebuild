# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fbset/fbset-2.1.ebuild,v 1.4 2002/07/10 16:17:57 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility to set the framebuffer videomode"
SRC_URI="http://home.tvd.be/cr26864/Linux/fbdev/${P}.tar.gz"
HOMEPAGE="http://linux-fbdev.org"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	make || die
}

src_install () {
	dobin fbset modeline2fb
	doman *.[58]
	dodoc etc/fb.modes.*
	dodoc INSTALL
}

