# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qt-dcgui/qt-dcgui-0.2.4.ebuild,v 1.4 2003/03/20 13:29:24 seemant Exp $

inherit kde-functions

MY_P=${P/qt-/}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha ~mips ~hppa ~arm"

need-qt 3
newdepend ">=dev-libs/libxml2-2.4.22
		~net-p2p/dclib-${PV}"

src_compile() {
	export CPPFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"

	econf --with-libdc=/usr \
		--with-qt-dir=${QTDIR} \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
