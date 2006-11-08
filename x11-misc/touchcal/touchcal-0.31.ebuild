# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/touchcal/touchcal-0.31.ebuild,v 1.1 2006/11/08 14:23:37 dsd Exp $

DESCRIPTION="Touchscreen calibration utility"
HOMEPAGE="http://touchcal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
DEPEND="sys-libs/ncurses"

src_install() {
	emake install DESTDIR=${D}
	dodoc README ChangeLog
}

