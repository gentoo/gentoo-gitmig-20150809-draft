# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemload/wmmemload-0.1.6.ebuild,v 1.7 2005/09/17 10:10:30 agriffis Exp $

IUSE=""
DESCRIPTION="dockapp that displays memory and swap space usage."
SRC_URI="http://www.markstaggs.net/wmmemload/${P}.tar.gz"
HOMEPAGE="http://www.markstaggs.net/"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
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
