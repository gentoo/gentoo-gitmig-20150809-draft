# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.0.2.ebuild,v 1.1 2003/07/20 14:57:57 caleb Exp $

DESCRIPTION="A Qt Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/x11 
	virtual/opengl 
	>=x11-libs/qt-2.3*
	>=media-libs/coin-${PV}*"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
	docinto txt
	dodoc docs/qtcomponents.doxygen
}
