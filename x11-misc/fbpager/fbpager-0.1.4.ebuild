# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpager/fbpager-0.1.4.ebuild,v 1.7 2005/07/09 17:58:25 swegener Exp $

DESCRIPTION="A Pager for fluxbox"
HOMEPAGE="http://fluxbox.sourceforge.net/fbpager"
SRC_URI="http://fluxbox.org/download/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="x86 ~sparc ~mips ~amd64 ppc"
IUSE=""
DEPEND="virtual/x11"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "To run fbpager inside the FluxBox slit, use fbpager -w"
	einfo
}

