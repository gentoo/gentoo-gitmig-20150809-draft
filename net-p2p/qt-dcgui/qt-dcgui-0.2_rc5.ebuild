# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qt-dcgui/qt-dcgui-0.2_rc5.ebuild,v 1.1 2003/01/10 17:09:49 vapier Exp $

MY_P="${P/qt-/}"
MY_P="${MY_P/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="=x11-libs/qt-3*
	>=dev-libs/libxml2-2.4.22
	~net-p2p/dclib-${PV}"

src_compile() {
	export CPPFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"

	econf --with-libdc=/usr \
		--with-qt-dir=/usr/qt/3 \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
