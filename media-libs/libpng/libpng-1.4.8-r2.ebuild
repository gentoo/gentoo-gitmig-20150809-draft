# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.4.8-r2.ebuild,v 1.5 2011/09/20 20:31:14 grobian Exp $

# this ebuild is only for the libpng14.so.14 SONAME for ABI compat

EAPI=4

inherit eutils libtool multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz
	apng? ( mirror://sourceforge/${PN}-apng/${PN}-master/${PV}/${P}-apng.patch.gz )"

LICENSE="as-is"
SLOT="1.4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="apng"

RDEPEND="sys-libs/zlib
	!=media-libs/libpng-1.4*:0"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

pkg_setup() {
	if ! has_version media-libs/libpng:${SLOT}; then
		rm -f "${EROOT}"/usr/$(get_libdir)/libpng14$(get_libname 14)
	fi
}

src_prepare() {
	use apng && epatch "${WORKDIR}"/${P}-apng.patch
	elibtoolize
}

src_configure() {
	econf --disable-static
}

src_compile() {
	emake libpng14.la
}

src_install() {
	local libn=libpng14$(get_libname 14)
	newlib.so .libs/$(readlink .libs/${libn}) ${libn}
}
