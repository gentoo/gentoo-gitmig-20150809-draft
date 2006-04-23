# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-0.9.5.ebuild,v 1.11 2006/04/23 16:48:00 kumba Exp $

inherit flag-o-matic

DESCRIPTION="A parallel version of BZIP2"
HOMEPAGE="http://compression.ca/pbzip2/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sparc x86"
IUSE="static"

DEPEND="app-arch/bzip2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:-O3:$(CXXFLAGS) $(LDFLAGS):g' Makefile || die
}

src_compile() {
	use static && append-ldflags -static
	emake pbzip2 || die "Failed to build"
}

src_install() {
	dobin pbzip2 || die "Failed to install"
	dodoc AUTHORS ChangeLog README
	doman pbzip2.1
}
