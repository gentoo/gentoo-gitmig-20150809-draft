# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.6.3.ebuild,v 1.13 2004/11/01 11:19:23 kloeri Exp $

inherit flag-o-matic

IUSE=""

DESCRIPTION="Extensible multimedia container format based on EBML."
SRC_URI="http://matroska.free.fr/downloads/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.matroska.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 alpha ~ia64 ~hppa ~mips sparc"

DEPEND="virtual/libc
	>=dev-libs/libebml-0.6.4"

src_compile() {
	cd ${S}/make/linux

	# This is needed on amd64 to create shared libraries that make
	# use of matroska, like libvlcplugin from vlc.
	# Travis Tilley <lv@gentoo.org> 09 Apr 2004
	use amd64 && append-flags -fPIC

	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/lib || die "make failed"
}

src_install () {
	cd ${S}/make/linux
	einstall || die "make install failed"
	dodoc ${S}/LICENSE.*
}
