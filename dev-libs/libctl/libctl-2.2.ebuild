# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libctl/libctl-2.2.ebuild,v 1.1 2004/01/06 20:03:59 george Exp $


DESCRIPTION="Guile-based library implementing flexible control files for scientific simulations"
SRC_URI="http://ab-initio.mit.edu/libctl/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"

LICENSE="GPL-2"
KEYWORDS="~x86"

SLOT="0"

DEPEND="dev-util/guile"

src_compile() {
	#econf --prefix=${D}/usr --mandir=${D}/usr/man || die
	econf || die "econf failed"
	MAKEOPTS="-j1" emake || die # Note: emake gives strange errors.
}

src_install() {
	einstall || die
	dodoc COPYING NEWS AUTHORS COPYRIGHT ChangeLog
	dodoc examples/*.h examples/*.c examples/*.scm examples/*.ctl
	dodoc examples/README examples/Makefile.in examples/Makefile
}
