# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-iconset/sylpheed-iconset-20030523.ebuild,v 1.1 2003/05/25 17:15:39 bcowan Exp $

DESCRIPTION="Iconset for sylpheed-claws"

HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"

DEPEND="${RDEPEND}"
RDEPEND="virtual/sylpheed"

SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.gz"

S=${WORKDIR}/${P}

src_install () {
	dodir /usr/share/sylpheed-claws/themes
	dodoc README
	rm README
	cp -a * ${D}/usr/share/sylpheed-claws/themes
}
