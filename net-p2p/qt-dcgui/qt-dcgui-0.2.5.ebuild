# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qt-dcgui/qt-dcgui-0.2.5.ebuild,v 1.2 2003/02/13 15:22:41 vapier Exp $

inherit kde-functions

MY_P="${P/qt-/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

need-qt 3
newdepend ">=dev-libs/libxml2-2.4.22
		~net-p2p/dclib-${PV}"

src_compile() {
	econf --with-libdc=/usr \
		--with-qt-dir=/usr/qt/3 \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
