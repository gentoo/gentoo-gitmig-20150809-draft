# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.4.ebuild,v 1.3 2002/08/14 23:44:15 murphy Exp $ 

S=${WORKDIR}/${P}

DESCRIPTION="An utillity that displays its input in a text box on your root window"
SRC_URI="http://de-fac.to/bob/xrootconsole/${P}.tar.gz"

HOMEPAGE="http://de-fac.to/bob/xrootconsole/"

LICENSE="GPL"

DEPEND="x11-base/xfree"
RDEPEMD="${DEPEND}"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake || die "emake failed"
}
src_install () {
	
	dodir /usr
	dodir /usr/bin
	make BINDIR=${D}usr/bin/ install || die "install failed"
}
