# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.36-r1.ebuild,v 1.3 2006/03/04 02:23:33 vapier Exp $

inherit eutils multilib

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://math.libtomcrypt.org/"
SRC_URI="http://math.libtomcrypt.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-shared-lib.patch
}

src_compile() {
	emake -f makefile.shared IGNORE_SPEED=1 || die
}

src_install() {
	make -f makefile.shared install DESTDIR="${D}" LIBPATH="/usr/$(get_libdir)" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
