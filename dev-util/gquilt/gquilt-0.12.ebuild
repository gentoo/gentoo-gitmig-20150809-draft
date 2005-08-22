# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gquilt/gquilt-0.12.ebuild,v 1.2 2005/08/22 00:01:04 metalgod Exp $

DESCRIPTION="A Python/GTK wrapper for quilt"
HOMEPAGE="http://users.bigpond.net.au/Peter-Williams/"
SRC_URI="http://users.bigpond.net.au/Peter-Williams/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-util/quilt
	>=dev-python/pygtk-2"

src_install() {
	make DESTDIR="${D}" PREFIX="/usr" install || die "make install failed"
	dodir /usr/share/pixmaps
	dosym /usr/lib/gquilt/icon.xpm /usr/share/pixmaps/gquilt.xpm
	dodoc ChangeLog
}
