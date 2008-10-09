# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lrmi/lrmi-0.10-r1.ebuild,v 1.3 2008/10/09 20:35:19 maekke Exp $

inherit eutils

DESCRIPTION="library for calling real mode BIOS routines under Linux"
HOMEPAGE="http://www.sourceforge.net/projects/lrmi/"
SRC_URI="mirror://sourceforge/lrmi/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/lrmi-0.10-kernel-2.6.26.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin vbetest || die "dobin"

	dolib.a liblrmi.a || die "dolib.a"
	dolib.so liblrmi.so.${PV} || die "dolib.so"
	dosym liblrmi.so.${PV} /usr/lib/liblrmi.so
	dosym liblrmi.so.${PV} /usr/lib/liblrmi.so.${PV%%.*}

	insinto /usr/include
	doins lrmi.h vbe.h || die "doins include"
}
