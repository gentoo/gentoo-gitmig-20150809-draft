# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-0.4.ebuild,v 1.2 2006/12/14 22:07:19 hansmi Exp $

IUSE=""

DESCRIPTION="GooCanvas is a canvas widget for GTK+ using cairo 2D"
HOMEPAGE="http://goocanvas.sourceforge.net/"
SRC_URI="mirror://sourceforge/goocanvas/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc"

DEPEND="
	>=x11-libs/gtk+-2.8.0
	x11-libs/cairo
	dev-util/pkgconfig
"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
