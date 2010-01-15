# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r9.ebuild,v 1.1 2010/01/15 05:06:21 vapier Exp $

# this ebuild is only for the libjpeg.so.62 SONAME for ABI compat

EAPI="2"

inherit eutils libtool multilib toolchain-funcs

PATCH_VER="2"
DESCRIPTION="library to load, handle and manipulate images in the JPEG format (transition package)"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="mirror://gentoo/jpegsrc.v${PV}.tar.gz
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="as-is"
SLOT="62"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="!~media-libs/jpeg-6b:0
	!media-libs/jpeg-compat"

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	elibtoolize
}

src_configure() {
	tc-export CC
	econf \
		--enable-shared \
		--disable-static \
		--enable-maxmem=64
}

src_compile() {
	emake libjpeg.la || die
}

src_install() {
	exeinto /usr/$(get_libdir)
	doexe .libs/libjpeg.so.62 || die
}

pkg_preinst() {
	if [ "${ROOT}"usr/$(get_libdir)/libjpeg.so.62.0.0 ] ; then
		rm -f "${ROOT}"usr/$(get_libdir)/libjpeg.so.62.0.0
	fi
}
