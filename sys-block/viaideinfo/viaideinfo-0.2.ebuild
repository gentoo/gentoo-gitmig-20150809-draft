# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/viaideinfo/viaideinfo-0.2.ebuild,v 1.1 2005/12/08 21:06:53 dsd Exp $

DESCRIPTION="Query VIA IDE controllers for various information"
HOMEPAGE="http://www.reactivated.net/software/viaideinfo"
SRC_URI="http://www.reactivated.net/software/viaideinfo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-apps/pciutils-2.2.0"

src_install() {
	make install DESTDIR=${D}
	dodoc ChangeLog NEWS README THANKS
}

