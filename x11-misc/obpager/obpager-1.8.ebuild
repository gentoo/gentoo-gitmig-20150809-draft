# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obpager/obpager-1.8.ebuild,v 1.2 2005/02/05 17:00:23 kloeri Exp $

DESCRIPTION="Lightweight pager designed to be used with NetWM-compliant window manager"
HOMEPAGE="http://obpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="virtual/x11"

src_compile() {
	emake || die
}

src_install() {
	dobin obpager
	dodoc COPYING README
}
