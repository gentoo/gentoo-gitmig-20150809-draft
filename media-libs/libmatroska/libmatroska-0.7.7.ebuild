# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.7.7.ebuild,v 1.1 2005/07/14 12:30:39 flameeyes Exp $

IUSE=""

inherit flag-o-matic eutils

DESCRIPTION="Extensible multimedia container format based on EBML"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=dev-libs/libebml-0.7.3"

src_unpack() {
	unpack ${A}

	cd ${S}/make/linux
	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
}

src_compile() {
	cd ${S}/make/linux

	#fixes locale for gcc3.4.0 to close bug 52385
	append-flags $(test_flag -finput-charset=ISO8859-15)

	emake PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/$(get_libdir) || die "make failed"
}

src_install() {
	cd ${S}/make/linux

	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc ${S}/ChangeLog
}
