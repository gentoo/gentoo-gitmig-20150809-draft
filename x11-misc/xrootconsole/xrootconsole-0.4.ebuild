# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.4.ebuild,v 1.8 2003/09/10 05:37:16 vapier Exp $

DESCRIPTION="An utillity that displays its input in a text box on your root window"
HOMEPAGE="http://de-fac.to/bob/xrootconsole/"
SRC_URI="http://de-fac.to/bob/xrootconsole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="x11-base/xfree"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make BINDIR=${D}usr/bin/ install || die "install failed"
}
