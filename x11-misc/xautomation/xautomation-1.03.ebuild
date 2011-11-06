# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautomation/xautomation-1.03.ebuild,v 1.2 2011/11/06 17:12:51 maekke Exp $

DESCRIPTION="Control X from command line and find things on screen"
HOMEPAGE="http://hoopajoo.net/projects/xautomation.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto
	media-libs/libpng"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog || die
}
