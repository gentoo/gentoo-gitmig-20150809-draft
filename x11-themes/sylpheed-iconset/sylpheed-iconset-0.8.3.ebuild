# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-iconset/sylpheed-iconset-0.8.3.ebuild,v 1.1 2002/10/13 10:21:41 bcowan Exp $

DESCRIPTION="Iconset for sylpheed-claws"

HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="${RDEPEND}"
RDEPEND="virtual/sylpheed"

MY_P="${P}claws"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.gz"

S=${WORKDIR}/${MY_P}

src_install () {
	dodir /usr/share/sylpheed/themes
	dodoc README
	rm README
	cp -a * ${D}/usr/share/sylpheed/themes
}
