# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemload/wmmemload-0.1.6.ebuild,v 1.3 2004/09/02 18:22:40 pvdabeel Exp $

IUSE=""
DESCRIPTION="dockapp that displays memory and swap space usage."
SRC_URI="http://www.markstaggs.net/wmmemload/${P}.tar.gz"
HOMEPAGE="http://www.markstaggs.net/"

SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ppc"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_compile()
{
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install ()
{
	einstall || die "make install failed"
}
