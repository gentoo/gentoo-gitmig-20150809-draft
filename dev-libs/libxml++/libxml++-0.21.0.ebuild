# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml++/libxml++-0.21.0.ebuild,v 1.1 2003/03/03 05:32:17 vladimir Exp $

DESCRIPTION="libxml++ is a C++ wrapper for the libxml XML parser library."
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/libxmlplusplus/${P}.tar.gz"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=dev-libs/libxml2-2.5.1"

src_compile() {
	econf \
		--prefix=/usr || die "Configure failed"
	emake || die "Compile failed"
}

src_install() {
	einstall install || die "Install failed"
	dodoc AUTHORS COPYING ChangeLog README*
}
