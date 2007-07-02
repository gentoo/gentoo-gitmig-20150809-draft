# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi-kernel/mindi-kernel-1.0.ebuild,v 1.6 2007/07/02 15:27:41 peper Exp $

DESCRIPTION="Mindi-kernel provides a basic kernel image for a mindi created bootdisk"
HOMEPAGE="http://www.microwerks.net/~hugo/mindi/"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="userpriv"

RDEPEND=">=sys-apps/mindi-0.85"

src_install() {
	dodir /usr/share/mindi
	cp * --parents -rdf ${D}/usr/share/mindi/
}
