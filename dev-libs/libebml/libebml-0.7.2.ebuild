# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.7.2.ebuild,v 1.10 2005/03/20 23:02:42 weeve Exp $

IUSE=""

inherit flag-o-matic eutils

DESCRIPTION="Extensible binary format library (kinda like XML)"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc64 ~alpha ~ppc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/libebml-shared.patch
}

src_compile() {
	cd ${S}/make/linux

	# This fix is necessary due to libebml being used to generate
	# shared libraries, such as the vlc plugin for mozilla. on archs
	# that require shared objects to be compiled with -fPIC, this
	# really shouldn't happen, but libebml doesn't produce an so.
	# Travis Tilley <lv@gentoo.org>
	append-flags -fPIC

	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
	make PREFIX=/usr || die "make failed"
}

src_install() {
	cd ${S}/make/linux
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/LICENSE.*
}
