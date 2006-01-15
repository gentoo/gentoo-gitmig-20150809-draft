# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet-gtk/gnunet-gtk-0.7.0.ebuild,v 1.3 2006/01/15 04:20:53 dang Exp $

DESCRIPTION="Graphical front end for GNUnet."
HOMEPAGE="http://www.gnu.org/software/GNUnet/"
SRC_URI="mirror://gnu//gnunet/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6.0
	>=net-p2p/gnunet-${PV}
	>=gnome-base/libglade-2.0"

src_compile() {
	econf --with-gnunet=/usr || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} install || die
}
