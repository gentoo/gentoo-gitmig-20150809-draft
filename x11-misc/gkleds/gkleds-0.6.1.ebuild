# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Written by Erik Grinaker <erikg@wired-networks.net>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkleds/gkleds-0.6.1.ebuild,v 1.4 2002/08/14 23:44:15 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gkrellm plugin for monitoring keyboard LEDs"
SRC_URI="http://www.stud.ifi.uio.no/~oyvinha/gkleds/${P}.tar.gz"
HOMEPAGE="http://www.stud.ifi.uio.no/~oyvinha/gkleds/"
DEPEND="app-admin/gkrellm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	make || die
}

src_install() {
	mkdir -p ${D}/usr/lib/gkrellm/plugins || die
	cp gkleds.so ${D}/usr/lib/gkrellm/plugins/ || die

	dodoc COPYING Changelog License TODO INSTALL README
}
