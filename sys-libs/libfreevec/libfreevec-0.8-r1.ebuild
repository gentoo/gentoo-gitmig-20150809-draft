# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libfreevec/libfreevec-0.8-r1.ebuild,v 1.3 2007/01/04 18:33:28 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit flag-o-matic autotools

DESCRIPTION="Altivec enabled libc memory function"
HOMEPAGE="http://freevec.org"
SRC_URI="http://freevec.org/downloads/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-ppc -ppc64"
IUSE=""

DEPEND=">=sys-devel/gcc-3.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf

	# Remove those 2 functions for now
	sed -i -e "s:HAVE_ALTIVEC_H:NOT_BUILD:" ${S}/src/{strcpy.c,memmove.c}
	# fix uint/int mismatch
	sed -i -e "s:vector int8_t v:vector uint8_t v:" ${S}/src/strnlen.c
}

src_compile() {
	# Make it build always, better move HAVE_ALTIVEC_H in configure later
	append-flags -maltivec -mabi=altivec -DHAVE_ALTIVEC_H
	econf || die "econf failed"
	emake || die "emake failed"

}
src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc TODO README INSTALL
}

pkg_postinst() {
	ewarn "Beware that library has known bugs, DO NOT PRELOAD IT"
}
