# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rlog/rlog-1.3.7.ebuild,v 1.3 2006/12/09 05:15:23 vanquirius Exp $

DESCRIPTION="A C++ logging library"
SRC_URI="http://arg0.net/users/vgough/download/${P}.tgz"
HOMEPAGE="http://arg0.net/wiki/rlog"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
IUSE=""

src_install () {
	dodoc AUTHORS README
	make DESTDIR="${D}" install || die
}
