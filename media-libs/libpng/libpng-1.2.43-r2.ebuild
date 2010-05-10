# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.43-r2.ebuild,v 1.3 2010/05/10 15:47:51 ranger Exp $

EAPI=3
inherit libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib
	!<media-libs/libpng-1.2.43-r1"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

pkg_setup() {
	if [[ -e ${ROOT}/usr/$(get_libdir)/libpng12.so.0.43.0 ]]; then
		rm -f "${ROOT}"/usr/$(get_libdir)/libpng12.so.0.43.0
	fi
}

src_prepare() {
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
}
