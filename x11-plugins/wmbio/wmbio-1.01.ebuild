# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.01.ebuild,v 1.3 2004/01/25 22:35:20 pyrania Exp $

S=${WORKDIR}/wmbio/src
DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="mirror://sourceforge/wmbio/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbio/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	cp Makefile Makefile_
	sed -e 's:cc:cc ${CFLAGS}:' Makefile_ > Makefile

	emake || die
}

src_install ()
{
	dobin wmbio
	cd ..
	dodoc README INSTALL COPYING NEWS Changelog
}
