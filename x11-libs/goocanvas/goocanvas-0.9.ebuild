# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-0.9.ebuild,v 1.1 2007/08/20 18:45:22 hansmi Exp $

IUSE=""

DESCRIPTION="GooCanvas is a canvas widget for GTK+ using the cairo 2D library for drawing."
HOMEPAGE="http://goocanvas.sourceforge.net/"
SRC_URI="mirror://sourceforge/goocanvas/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="
	>=x11-libs/gtk+-2.10.0
	x11-libs/cairo
	dev-util/pkgconfig
"

src_install() {
	einstall || die
}
