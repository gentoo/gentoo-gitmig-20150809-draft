# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.8.0.ebuild,v 1.13 2006/12/03 06:29:23 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="Extensible multimedia container format based on EBML"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-libs/libebml-0.7.6"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-respectflags.patch

	cd ${S}/make/linux
	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
}

src_compile() {
	cd ${S}/make/linux

	#fixes locale for gcc3.4.0 to close bug 52385
	append-flags $(test-flags -finput-charset=ISO8859-15)

	emake PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/$(get_libdir) \
		CXX="$(tc-getCXX)" || die "make failed"
}

src_install() {
	cd ${S}/make/linux

	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/ChangeLog
}
