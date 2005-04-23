# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-1.0.2.ebuild,v 1.7 2005/04/23 18:55:09 ka0ttic Exp $

IUSE=""

inherit libtool multilib

MY_P="${P/pp/++}"

DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND=">=dev-libs/libxml2-2.5.8"

S="${WORKDIR}/${MY_P}"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	elibtoolize
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dosed -i 's|^\(Cflags.*-I.* \)-I.*$|\1|' \
		/usr/$(get_libdir)/pkgconfig/${MY_P%.*}.pc
	dodoc AUTHORS ChangeLog NEWS README*
}
