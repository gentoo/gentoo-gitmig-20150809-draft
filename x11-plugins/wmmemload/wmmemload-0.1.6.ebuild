# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemload/wmmemload-0.1.6.ebuild,v 1.9 2007/07/22 04:53:18 dberkholz Exp $

IUSE=""
DESCRIPTION="dockapp that displays memory and swap space usage."
SRC_URI="http://www.markstaggs.net/wmmemload/${P}.tar.gz"
HOMEPAGE="http://www.markstaggs.net/"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
LICENSE="GPL-2"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_compile()
{
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install ()
{
	einstall || die "make install failed"
}
