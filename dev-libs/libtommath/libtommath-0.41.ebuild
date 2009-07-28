# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.41.ebuild,v 1.3 2009/07/28 21:53:31 vostorga Exp $

inherit eutils multilib

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://www.libtom.org/"
SRC_URI="http://www.libtom.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	epatch "${FILESDIR}"/${P}-CC.patch
}

src_compile() {
	emake CC=$(tc-getCC) -f makefile.shared IGNORE_SPEED=1 || die "emake failed"
}

src_install() {
	make -f makefile.shared install DESTDIR="${D}" LIBPATH="/usr/$(get_libdir)" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*.c
}
