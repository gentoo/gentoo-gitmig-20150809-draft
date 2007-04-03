# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-1.0.1.ebuild,v 1.1 2007/04/03 21:28:55 wolf31o2 Exp $

DESCRIPTION="A parallel version of BZIP2"
HOMEPAGE="http://compression.ca/pbzip2/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="static"

DEPEND="app-arch/bzip2"

src_unpack() {
	unpack ${A}
	sed -i -e 's:-O3:${CFLAGS}:g' ${P}/Makefile || die
}

src_compile() {
	if use static ; then
		cp -f /usr/$(get_libdir)/libbz2.a ${S}
		emake pbzip2-static || die "Failed to build"
	else
		emake pbzip2 || die "Failed to build"
	fi
}

src_install() {
	dobin pbzip2 || die "Failed to install"
	dodoc AUTHORS ChangeLog README
	doman pbzip2.1 || die "Failed to install man page"
}
