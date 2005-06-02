# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rlog/rlog-1.3.6.ebuild,v 1.2 2005/06/02 17:32:12 genstef Exp $

DESCRIPTION="A C++ logging library"
SRC_URI="http://arg0.net/users/vgough/download/${P}.tgz"
HOMEPAGE="http://arg0.net/users/vgough/rlog/"
LICENSE="LGPL-2"
KEYWORDS="x86 ~amd64"
SLOT="0"
IUSE=""

src_install () {
	dodoc AUTHORS COPYING INSTALL README
	make DESTDIR=${D} install
}
