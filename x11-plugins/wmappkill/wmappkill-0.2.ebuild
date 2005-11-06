# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmappkill/wmappkill-0.2.ebuild,v 1.3 2005/11/06 03:34:53 metalgod Exp $

IUSE=""
S=${WORKDIR}/wmAppKill-${PV}
DESCRIPTION="WindowMaker DockApp: Lists all your running processes. You can kill any of them by double-clicking on their names."
SRC_URI="http://internettrash.com/users/beuz/${P}.tar.gz"
HOMEPAGE="http://internettrash.com/users/beuz/wmappkill.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
DEPEND="virtual/x11
	=gnome-base/libgtop-1*
	>=dev-util/pkgconfig-0.15.0
	>=sys-apps/sed-4"

src_compile() {
	mv Makefile Makefile.orig
	sed 's/^GCCOPTS/#GCCOPTS/' Makefile.orig > Makefile
	rm Makefile.orig
	emake GCCOPTS="${CFLAGS} `pkg-config --cflags libgtop`" || die
}

src_install () {
	dobin wmAppKill
	dodoc ChangeLog README
}
