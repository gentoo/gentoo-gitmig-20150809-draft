# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-iconset/sylpheed-iconset-20040206.ebuild,v 1.1 2004/02/29 23:23:55 pyrania Exp $

DESCRIPTION="Iconset for sylpheed-claws"

HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

DEPEND="${RDEPEND}"
RDEPEND="virtual/sylpheed"

SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.gz"

S=${WORKDIR}/${P}

src_install () {
	dodir /usr/share/sylpheed-claws/themes
	dodoc README
	rm README INSTALL
	chmod 644 */*
	cp -r * ${D}/usr/share/sylpheed-claws/themes
	dodir /usr/share/sylpheed
	dosym /usr/share/sylpheed-claws/themes /usr/share/sylpheed/themes
}
