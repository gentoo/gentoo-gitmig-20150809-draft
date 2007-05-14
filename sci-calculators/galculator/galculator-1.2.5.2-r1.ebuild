# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/galculator/galculator-1.2.5.2-r1.ebuild,v 1.1 2007/05/14 19:32:21 drac Exp $

DESCRIPTION="GTK+ based algebraic and RPN calculator."
HOMEPAGE="http://galculator.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	gnome? ( gnome-base/gnome-desktop )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	use gnome || sed -i -e 's:gnome-calc2.png:calc:' "${S}"/galculator.desktop.in
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
