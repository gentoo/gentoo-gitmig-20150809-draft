# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dcgui-qt/dcgui-qt-0.2.13.ebuild,v 1.1 2003/05/06 08:08:13 aliz Exp $

inherit kde-functions
need-qt 3

IUSE="ssl"

#MY_P=${P/qt-/}
S=${WORKDIR}/${P}
DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"


newdepend ">=dev-libs/libxml2-2.4.22
	=net-p2p/dclib-${PV}*
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf \
		--with-gnu-ld \
		`use_with ssl` \
		--with-libdc=/usr \
		--with-qt-dir=/usr/qt/3 \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
