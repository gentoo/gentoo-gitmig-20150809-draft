# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3.ebuild,v 1.5 2004/07/20 12:57:23 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/x11
	=x11-libs/libdockapp-0.4.0-r1"

src_compile()
{
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	einstall || die "make install failed"
	dodoc AUTHORS README NEWS INSTALL COPYING
}
