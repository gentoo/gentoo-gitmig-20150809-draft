# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synaptics/synaptics-0.12.0.ebuild,v 1.4 2003/11/24 04:13:46 spyderous Exp $

# This ebuild overwrites synaptics files installed by <= xfree-4.3.0-r3
# and xfree-4.3.99.14 >= X >= xfree-4.3.99.8.

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://w1.894.telia.com/~u89404340/touchpad/"
SRC_URI="http://w1.894.telia.com/~u89404340/touchpad/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"
RDEPEND="virtual/x11
	>=x11-base/xfree-4.3.0-r4"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	# This Makefile sucks. no prefix, no DESTDIR, nothing useful.
	# At some point I'd like to fix that and submit upstream.
	# It still doesn't respect CFLAGS.
	epatch ${FILESDIR}/${PN}-0.11.8-makefile-fixup.patch
	# If we don't do this, it won't compile anything and use binaries instead.
	rm ${PN}/{*.o,synclient}
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/X11R6/{bin,lib/modules/input}
	make install || die
	dodoc {COMPATIBILITY,FEATURES,FILES,INSTALL,LICENSE,NEWS,PARAMETER,TODO,VERSION}
	use nls && dodoc INSTALL.DE
}
