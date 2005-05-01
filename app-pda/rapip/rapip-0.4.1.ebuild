# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/rapip/rapip-0.4.1.ebuild,v 1.10 2005/05/01 16:51:09 hansmi Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - KDE System Tray utility"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc
	app-pda/synce-libsynce"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
