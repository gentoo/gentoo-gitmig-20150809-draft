# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-0.21.0.ebuild,v 1.1 2003/06/19 00:41:50 liquidx Exp $

MY_P=${P/pp/++}
DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://sourceforge/libxmlplusplus/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.1"

S=${WORKDIR}/${MY_P}

src_install() {
	einstall install || die "Install failed"
#	dosym /usr/lib/libxml++-0.1.a /usr/lib/libxml++.a
#	dosym /usr/lib/libxml++-0.1.so /usr/lib/libxml++.so
	dodoc AUTHORS COPYING ChangeLog NEWS README*
}
