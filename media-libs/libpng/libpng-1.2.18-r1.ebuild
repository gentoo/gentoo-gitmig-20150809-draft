# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.18-r1.ebuild,v 1.3 2007/08/19 12:18:33 nixnut Exp $

inherit libtool multilib eutils

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/libpng/${P}.tar.bz2
	doc? ( http://www.libpng.org/pub/png/libpng-manual.txt )"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 m68k ~mips ppc ~ppc64 s390 sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use doc && cp "${WORKDIR}"/${PN}-manual.txt .
	epatch "${FILESDIR}"/1.2.7-gentoo.diff
	epatch "${FILESDIR}"/${P}-gray.patch #181318

	# So we get sane .so versioning on FreeBSD
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
	use doc && dodoc libpng-manual.txt
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	if [[ -f ${ROOT}/usr/$(get_libdir)/libpng.so.3.1.2.1 ]] ; then
		rm -f "${ROOT}"/usr/$(get_libdir)/libpng.so.3.1.2.1
	fi
}
