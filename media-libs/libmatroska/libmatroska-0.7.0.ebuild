# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.7.0.ebuild,v 1.12 2004/12/11 22:27:39 weeve Exp $

inherit flag-o-matic gcc eutils

DESCRIPTION="Extensible multimedia container format based on EBML"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips ~alpha hppa amd64 ~ia64"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/libebml-0.7.0"

src_compile() {
	cd ${S}/make/linux

	# This is needed on amd64 to create shared libraries that make
	# use of matroska, like libvlcplugin from vlc.
	# Travis Tilley <lv@gentoo.org> 09 Apr 2004
	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC

	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile

	#fixes locale for gcc3.4.0 to close bug 52385
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		append-flags -finput-charset=ISO8859-15
	fi

	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/lib || die "make failed"
}

src_install() {
	cd ${S}/make/linux
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/LICENSE.*
}
