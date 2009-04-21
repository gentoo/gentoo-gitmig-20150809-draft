# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.36-r1.ebuild,v 1.11 2009/04/21 09:10:26 armin76 Exp $

inherit eutils multilib

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://www.libtom.org/"
SRC_URI="http://www.libtom.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-shared-lib.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
}

src_compile() {
	emake -f makefile.shared IGNORE_SPEED=1 || die
}

src_install() {
	make -f makefile.shared install DESTDIR="${D}" LIBPATH="/usr/$(get_libdir)" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
