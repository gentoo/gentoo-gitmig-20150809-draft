# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="A C++ logging library"
SRC_URI="http://arg0.net/users/vgough/download/${P}.tgz"
HOMEPAGE="http://arg0.net/users/vgough/rlog/"
LICENSE="LGPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_install () {
	dodoc AUTHORS COPYING INSTALL README
	make DESTDIR=${D} install
}
