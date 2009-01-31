# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-1.0.5.ebuild,v 1.5 2009/01/31 21:07:39 dang Exp $

inherit gnome2 eutils

MY_PN="${PN/pp/++}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.5.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog NEWS README*"

src_unpack() {
	gnome2_src_unpack

	# gcc 4.3 build fix, see bug #218779
	epatch "${FILESDIR}/${PN}-1.0.5-gcc43.patch"
}

src_install() {
	gnome2_src_install
	dosed -i 's|^\(Cflags.*-I.* \)-I.*$|\1|' \
		/usr/$(get_libdir)/pkgconfig/${MY_PN}-1.0.pc
}
