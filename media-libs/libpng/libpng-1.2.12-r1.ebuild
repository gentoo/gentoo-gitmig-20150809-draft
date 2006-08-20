# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.12-r1.ebuild,v 1.7 2006/08/20 21:07:19 wormo Exp $

inherit eutils autotools multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/libpng/${P}.tar.bz2
	doc? ( http://www.libpng.org/pub/png/libpng-manual.txt )"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc-macos ppc64 s390 sh ~sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	use doc && cp "${DISTDIR}"/libpng-manual.txt .

	epatch "${FILESDIR}"/1.2.7-gentoo.diff

	# Fixes for #136452
	epatch "${FILESDIR}"/${P}-no-asm.patch
	eautoreconf
}

src_compile() {
	econf || die
	mv pngconf.h pngconf.h.in
	emake pngconf.h || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
	use doc && dodoc libpng-manual.txt
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	if [[ -f ${ROOT}/usr/$(get_libdir)/libpng.so.3.1.2.1 ]] ; then
		rm -f "${ROOT}"/usr/$(get_libdir)/libpng.so.3.1.2.1
	fi
}
