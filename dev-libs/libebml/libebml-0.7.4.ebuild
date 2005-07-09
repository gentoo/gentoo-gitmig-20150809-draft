# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.7.4.ebuild,v 1.3 2005/07/09 01:31:27 vapier Exp $

IUSE=""

inherit flag-o-matic eutils

DESCRIPTION="Extensible binary format library (kinda like XML)"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}

	if use ppc-macos; then
		sed -i \
			-e 's/\.so/\.dylib/g' \
			-e 's/\.dylib.0/\.0.dylib/g' \
			-e 's/$(CXX) -shared -Wl,-soname,$(LIBRARY_SO_VER)/$(LD)/' \
			-e 's/LD=$(CXX)/LD=libtool/' ${S}/make/linux/Makefile \
				|| die "sed Makefile failed"
	fi

	sed -i -e 's:CXXFLAGS=:CXXFLAGS+=:g' ${S}/make/linux/Makefile
}

src_compile() {
	cd ${S}/make/linux

	# This fix is necessary due to libebml being used to generate
	# shared libraries, such as the vlc plugin for mozilla. on archs
	# that require shared objects to be compiled with -fPIC, this
	# really shouldn't happen, but libebml doesn't produce an so.
	# Travis Tilley <lv@gentoo.org>
	append-flags -fPIC

	emake PREFIX=/usr || die "make failed"
}

src_install() {
	cd ${S}/make/linux
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/ChangeLog
}
