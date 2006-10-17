# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DFB++/DFB++-0.9.23.ebuild,v 1.2 2006/10/17 23:38:39 vapier Exp $

DESCRIPTION="C++ bindings for DirectFB"
HOMEPAGE="http://www.directfb.org/dfb++.xml"
SRC_URI="http://www.directfb.org/downloads/Extras/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/DirectFB-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
