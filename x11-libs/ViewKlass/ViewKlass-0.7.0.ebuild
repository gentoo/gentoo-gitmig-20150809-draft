# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ViewKlass/ViewKlass-0.7.0.ebuild,v 1.7 2009/05/05 07:37:23 ssuominen Exp $

IUSE=""

DESCRIPTION="An implementation of the ViewKit user interface library"
SRC_URI="mirror://sourceforge/viewklass/${P}.tar.gz"
RESTRICT="mirror"
HOMEPAGE="http://viewklass.sourceforge.net"
LICENSE="LGPL-2.1"

RDEPEND="x11-libs/openmotif"
DEPEND="${RDEPEND}"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

src_compile() {
	./configure --prefix=/usr || die "./configure failed"
	make CXXFLAGS="${CXXFLAGS} -I. -I/usr/X11R6/include" \
		CFLAGS="${CXXFLAGS} -I. -I/usr/X11R6/include" || die
}

src_install () {
	dodir /usr/lib
	make prefix="${D}/usr" install || die
}
