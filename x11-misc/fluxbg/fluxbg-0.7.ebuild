# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $ Header: $

DESCRIPTION="fluxbg is a tool for comfortable background changing."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://fluxbg.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	x11-misc/commonbox-utils
	>=sys-devel/autoconf-2.52
	>=dev-cpp/gtkmm-2.2.3"

src_install () {
	make install \
	prefix=${D}/usr || die "make install failed"

	dodoc AUTHORS COPYING CREDITS INSTALL NEWS README
}

