# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-1.0.2.ebuild,v 1.2 2004/02/22 09:35:15 obz Exp $

inherit libtool

MY_P=${P/pp/++}
DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-libs/libxml2-2.5.8"

S=${WORKDIR}/${MY_P}
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	elibtoolize
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install|| die "Install failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README*
}
