# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-iconset/sylpheed-iconset-20031130.ebuild,v 1.4 2004/03/30 10:26:43 mr_bones_ Exp $

DESCRIPTION="Iconset for sylpheed-claws"
HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha"
IUSE=""

DEPEND="virtual/sylpheed"

src_install() {
	dodir /usr/share/sylpheed-claws/themes
	dodoc README
	rm README INSTALL
	chmod 644 */*
	cp -r * ${D}/usr/share/sylpheed-claws/themes
	dodir /usr/share/sylpheed
	dosym /usr/share/sylpheed-claws/themes /usr/share/sylpheed/themes
}
