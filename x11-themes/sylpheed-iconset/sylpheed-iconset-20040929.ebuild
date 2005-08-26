# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-iconset/sylpheed-iconset-20040929.ebuild,v 1.4 2005/08/26 14:15:29 agriffis Exp $

DESCRIPTION="Iconset for sylpheed-claws"
HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~ppc x86"
IUSE=""

DEPEND="virtual/sylpheed"

src_install() {
	dodir /usr/share/sylpheed-claws/themes
	dodoc README
	rm -f README INSTALL
	chmod 644 */*
	cp -r * ${D}/usr/share/sylpheed-claws/themes
	dodir /usr/share/sylpheed
	dosym /usr/share/sylpheed-claws/themes /usr/share/sylpheed/themes
}
