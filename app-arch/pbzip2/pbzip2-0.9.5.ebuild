# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-0.9.5.ebuild,v 1.7 2006/03/27 11:39:04 corsair Exp $

inherit eutils

DESCRIPTION="A parallel version of BZIP2"
HOMEPAGE="http://compression.ca/pbzip2/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc-macos ppc64 ~s390 sparc x86"
IUSE="static"

DEPEND="virtual/libc
	app-arch/bzip2"

pkg_setup() {
	if use static
	then
		built_with_use app-arch/bzip2 static || \
			die "You must compile bzip2 with USE=static"
	fi
}

src_unpack() {
	unpack ${A}
	sed -i -e 's:-O3:${CFLAGS}:g' ${P}/Makefile || die
}

src_compile() {
	if use static
	then
		cp -f /usr/$(get_libdir)/libbz2.a ${S}
		emake pbzip2-static || die "Failed to build"
	else
		emake pbzip2 || die "Failed to build"
	fi
}

src_install() {
	dobin pbzip2 || die "Failed to install"
	dodoc AUTHORS ChangeLog README || Die "Failed to install docs"
	doman pbzip2.1 || die "Failed to install man page"
}
