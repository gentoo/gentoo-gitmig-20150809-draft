# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.7.4.ebuild,v 1.8 2005/03/20 23:08:49 weeve Exp $

IUSE=""

inherit flag-o-matic gcc eutils

DESCRIPTION="Extensible multimedia container format based on EBML"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc64 ~ppc"

DEPEND=">=dev-libs/libebml-0.7.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/libmatroska-shared.patch

	cd ${S}/make/linux
	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
}

src_compile() {
	cd ${S}/make/linux

	# This is needed on amd64 to create shared libraries that make
	# use of matroska, like libvlcplugin from vlc.
	# Travis Tilley <lv@gentoo.org> 09 Apr 2004
	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC

	#fixes locale for gcc3.4.0 to close bug 52385
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		append-flags -finput-charset=ISO8859-15
	fi

	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/$(get_libdir) || die "make failed"
}

src_install() {
	cd ${S}/make/linux

	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ../../ChangeLog
}
