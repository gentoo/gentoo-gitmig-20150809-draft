# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzip/libzip-0.8.ebuild,v 1.1 2008/01/13 18:31:05 philantrop Exp $

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="http://www.nih.at/libzip/"
SRC_URI="http://www.nih.at/libzip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README THANKS AUTHORS
}
