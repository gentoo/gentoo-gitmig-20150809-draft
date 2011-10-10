# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.9.5-r1.ebuild,v 1.1 2011/10/10 20:40:39 ssuominen Exp $

# this ebuild is only for the libtiff.so.3 and libtiffxx.so.3 SONAME for ABI compat

EAPI=4
inherit libtool multilib

DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images"
HOMEPAGE="http://www.remotesensing.org/libtiff/"
SRC_URI="ftp://ftp.remotesensing.org/pub/libtiff/${P}.tar.gz"

LICENSE="as-is"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+cxx jbig jpeg zlib"

RDEPEND="jpeg? ( virtual/jpeg )
	jbig? ( media-libs/jbigkit )
	zlib? ( sys-libs/zlib )
	!media-libs/tiff-compat
	!=media-libs/tiff-3*:0"
DEPEND="${RDEPEND}"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable cxx) \
		$(use_enable zlib) \
		$(use_enable jpeg) \
		$(use_enable jbig) \
		--without-x
}

src_install() {
	exeinto /usr/$(get_libdir)
	doexe libtiff/.libs/libtiff$(get_libname 3)
	use cxx && doexe libtiff/.libs/libtiffxx$(get_libname 3)
}
