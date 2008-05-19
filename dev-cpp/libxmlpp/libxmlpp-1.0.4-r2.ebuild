# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-1.0.4-r2.ebuild,v 1.7 2008/05/19 21:01:54 dang Exp $

inherit libtool multilib

MY_P="${P/pp/++}"
DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.5.8"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5"

S="${WORKDIR}/${MY_P}"
MAKEOPTS="${MAKEOPTS} -j1"

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dosed -i 's|^\(Cflags.*-I.* \)-I.*$|\1|' \
		/usr/$(get_libdir)/pkgconfig/${MY_P%.*}.pc
	dodoc AUTHORS ChangeLog NEWS README*
}
