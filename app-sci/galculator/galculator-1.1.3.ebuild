# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/galculator/galculator-1.1.3.ebuild,v 1.1 2003/11/07 01:04:19 leonardop Exp $

DESCRIPTION="A GTK2 based algebraic and RPN calculator"
HOMEPAGE="http://galculator.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-1.3.13
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README THANKS TODO
}

