# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbio/wmbio-1.01.ebuild,v 1.1 2003/11/02 03:04:52 pyrania Exp $

S=${WORKDIR}/wmbio/src
DESCRIPTION="a Window Maker applet that shows your biorhythm"
SRC_URI="http://wmbio.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbio/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	rm wmbio
	emake || die
}

src_install ()
{
	dobin wmbio
	cd ..
	dodoc README INSTALL COPYING NEWS
}
