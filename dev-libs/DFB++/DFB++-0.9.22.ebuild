# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DFB++/DFB++-0.9.22.ebuild,v 1.2 2005/05/06 02:43:30 vapier Exp $

DESCRIPTION="C++ bindings for DirectFB"
HOMEPAGE="http://www.directfb.org/dfb++.xml"
SRC_URI="http://www.directfb.org/downloads/Extras/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="~dev-libs/DirectFB-${PV}"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
