# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-html/mini-howto-html-20021121.ebuild,v 1.1 2002/11/25 05:28:18 danarmak Exp $

MY_P="Linux-mini-html-HOWTOs-${PV}"
S=${WORKDIR}/HOWTO/mini
DESCRIPTION="The LDP mini-howtos, html format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org"
SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Mini-HOWTOs from http://www.linuxdoc.org in HTML format"
KEYWORDS="x86 sparc sparc64 ppc"

src_install () {
	
	dodir /usr/share/doc/howto/mini
	dodir /usr/share/doc/howto/mini/html
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO
	
	cd ${S}
	cp -R * ${D}/usr/share/doc/howto/mini/html
	
}
