# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gquilt/gquilt-0.19.ebuild,v 1.1 2007/04/05 06:14:20 nerdboy Exp $

DESCRIPTION="A Python/GTK wrapper for quilt"
HOMEPAGE="http://users.bigpond.net.au/Peter-Williams/"
SRC_URI="mirror://sourceforge/gquilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-util/quilt
	>=dev-python/pygtk-2"

src_install() {
	make DESTDIR="${D}" PREFIX="/usr" install || die "make install failed"
	dodoc ChangeLog
}
