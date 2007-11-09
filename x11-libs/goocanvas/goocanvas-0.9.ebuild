# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-0.9.ebuild,v 1.3 2007/11/09 19:47:32 lavajoe Exp $

inherit libtool

IUSE=""

DESCRIPTION="GooCanvas is a canvas widget for GTK+ using the cairo 2D library for drawing."
HOMEPAGE="http://sourceforge.net/projects/goocanvas/"
SRC_URI="mirror://sourceforge/goocanvas/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

DEPEND="
	>=x11-libs/gtk+-2.10.0
	x11-libs/cairo
	dev-util/pkgconfig
"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Needed for FreeBSD - Please do not remove
	elibtoolize
}

src_install() {
	einstall || die
}
