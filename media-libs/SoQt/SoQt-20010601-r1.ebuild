# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-20010601-r1.ebuild,v 1.13 2004/02/26 05:35:49 weeve Exp $

DESCRIPTION="A Qt Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.coinn3d.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 -sparc"

DEPEND="virtual/x11
	virtual/opengl
	=x11-libs/qt-2.3*
	=media-libs/coin-${PV}*"

S=${WORKDIR}/${PN}

src_compile() {
	econf --qith-qt-dir=/usr/qt/2 || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
	docinto txt
	dodoc docs/qtcomponents.doxygen
}
