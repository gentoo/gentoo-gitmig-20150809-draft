# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-artwork/xfce4-artwork-0.0.4.ebuild,v 1.6 2004/04/17 19:22:43 aliz Exp $

IUSE=""
DESCRIPTION="Xfce4 extra artwork"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://download.berlios.de/xfce-goodies/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ~ppc ~alpha ~sparc amd64"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	xfce-base/xfce4-base"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README
}
