# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-html/mini-howto-html-20020328.ebuild,v 1.3 2002/08/02 05:03:34 seemant Exp $

MY_P="Linux-mini-html-HOWTOs-${PV}"
S=${WORKDIR}/HOWTO/mini
DESCRIPTION="The LDP mini-howtos, html format."
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"
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
