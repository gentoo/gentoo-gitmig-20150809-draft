# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg-compat/jpeg-compat-6b-r1.ebuild,v 1.5 2009/10/06 22:33:23 maekke Exp $

EAPI=2
inherit eutils libtool multilib toolchain-funcs

PATCH_VER=1.6

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format (transition package)"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/jpegsrc.v${PV}.tar.gz
	mirror://gentoo/jpeg-6b-patches-${PATCH_VER}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/libtool
	!<media-libs/jpeg-7"

S=${WORKDIR}/${P/-compat}

pkg_setup() {
	if ! has_version media-libs/jpeg-compat ; then
		if [[ -e ${ROOT}/usr/$(get_libdir)/libjpeg.so.62 ]] ; then
			elog "Removing libjpeg.so.62 manually from media-libs/jpeg"
			rm -f "${ROOT}/usr/$(get_libdir)/libjpeg.so.62"
		fi
	fi
}

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	rm libtool-wrap
	ln -s libtool libtool-wrap
	elibtoolize
}

src_configure() {
	tc-export AR CC RANLIB
	econf \
		--enable-shared \
		--disable-static \
		--enable-maxmem=64
}

src_install() {
	exeinto /usr/$(get_libdir)
	doexe .libs/libjpeg.so.62 || die
}

pkg_preinst() {
	if [ "${ROOT}"usr/$(get_libdir)/libjpeg.so.62.0.0 ]; then
		rm -f "${ROOT}"usr/$(get_libdir)/libjpeg.so.62.0.0
	fi
}
