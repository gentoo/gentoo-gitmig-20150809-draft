# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lrmi/lrmi-0.8.ebuild,v 1.4 2004/08/07 19:36:18 slarti Exp $

IUSE=""
DESCRIPTION="LRMI is a library for calling real mode BIOS routines under Linux."
HOMEPAGE="http://www.sourceforge.net/projects/lrmi/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="MIT"
DEPEND="virtual/libc"
RDEPEND=""
SRC_URI="mirror://sourceforge/lrmi/${P}.tar.gz"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin vbetest

	dolib.so liblrmi.so.0.0
	dosym liblrmi.so.0.0 /usr/lib/liblrmi.so.0
	dosym liblrmi.so.0 /usr/lib/liblrmi.so

	insinto /usr/include
	doins lrmi.h vbe.h
}
