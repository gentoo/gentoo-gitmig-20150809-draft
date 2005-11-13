# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lrmi/lrmi-0.9.ebuild,v 1.1 2005/11/13 04:28:58 vapier Exp $

DESCRIPTION="library for calling real mode BIOS routines under Linux"
HOMEPAGE="http://www.sourceforge.net/projects/lrmi/"
SRC_URI="mirror://sourceforge/lrmi/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin vbetest || die "dobin"

	dolib.a liblrmi.a || die "dolib.a"
	dolib.so liblrmi.so || die "dolib.so"
	dosym liblrmi.so /usr/lib/liblrmi.so.0
	dosym liblrmi.so.0 /usr/lib/liblrmi.so.0.0

	insinto /usr/include
	doins lrmi.h vbe.h || die "doins include"
}
