# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautomation/xautomation-0.96.ebuild,v 1.10 2008/01/09 08:39:32 nelchael Exp $

DESCRIPTION="Control X from command line and find things on screen"
HOMEPAGE="http://hoopajoo.net/projects/xautomation.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc x86"
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
}
