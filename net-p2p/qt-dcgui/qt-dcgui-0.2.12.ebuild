# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qt-dcgui/qt-dcgui-0.2.12.ebuild,v 1.2 2003/04/30 06:26:38 aliz Exp $

inherit kde-functions
need-qt 3

IUSE="ssl"

MY_P=dcgui-qt-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"


newdepend ">=dev-libs/libxml2-2.4.22
	=net-p2p/dclib-${PV}*
	ssl? ( dev-libs/openssl )"

src_compile() {
	#workaround

	econf \
		--with-gnu-ld \
		`use_with ssl` \
		--with-libdc=/usr \
		--with-qt-dir=/usr/qt/3 \
		|| die
	make distclean
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
