# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.4.ebuild,v 1.12 2004/07/15 00:58:08 agriffis Exp $

DESCRIPTION="An utillity that displays its input in a text box on your root window"
HOMEPAGE="http://de-fac.to/bob/xrootconsole/"
SRC_URI="http://de-fac.to/bob/xrootconsole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make BINDIR=${D}usr/bin/ install || die "install failed"
}
