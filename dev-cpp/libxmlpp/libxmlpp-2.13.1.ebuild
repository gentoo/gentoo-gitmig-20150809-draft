# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-2.13.1.ebuild,v 1.5 2007/08/27 15:21:26 angelos Exp $

inherit gnome2 eutils

MY_PN="${PN/pp/++}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 ~hppa ~ppc sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.6.1
	>=dev-cpp/glibmm-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog NEWS README*"

src_unpack() {
	unpack ${A}
	cd ${S}

	# don't waste time building the examples
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install
	dosed -i 's|^\(Cflags.*-I.* \)-I.*$|\1|' \
		/usr/$(get_libdir)/pkgconfig/${MY_PN}-${SLOT}.pc

	rm -fr ${D}/usr/share/doc/libxml++*
	use doc && dohtml docs/reference/${PV%.*}/html/*
}
