# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.7.6.ebuild,v 1.7 2006/04/17 18:52:26 flameeyes Exp $

inherit eutils toolchain-funcs flag-o-matic

IUSE=""

DESCRIPTION="Extensible binary format library (kinda like XML)"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ppc ~ppc-macos ~ppc64 sparc ~x86"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-respectflags.patch"

	if use ppc-macos; then
		sed -i \
			-e 's/\.so/\.dylib/g' \
			-e 's/\.dylib.0/\.0.dylib/g' \
			-e 's/$(CXX) -shared -Wl,-soname,$(LIBRARY_SO_VER)/$(LD)/' \
			-e 's/LD=$(CXX)/LD=libtool/' ${S}/make/linux/Makefile \
				|| die "sed Makefile failed"
	fi
}

src_compile() {
	cd ${S}/make/linux

	# miscompiles with -O2 and higher
	replace-flags -O[23] -O1

	emake PREFIX=/usr CXX="$(tc-getCXX)"|| die "make failed"
}

src_install() {
	cd ${S}/make/linux
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/ChangeLog
}
