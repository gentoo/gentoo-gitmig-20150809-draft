# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gchempaint/gchempaint-0.8.7.ebuild,v 1.1 2008/03/29 23:48:48 je_fro Exp $

inherit autotools gnome2

DESCRIPTION="2D chemical structures editor for the Gnome-2 desktop"
HOMEPAGE="http://www.nongnu.org/gchempaint/"
SRC_URI="http://savannah.nongnu.org/download/gchempaint/0.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-chemistry/gchemutils-0.8.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	gnome2_src_compile --disable-update-databases
}
