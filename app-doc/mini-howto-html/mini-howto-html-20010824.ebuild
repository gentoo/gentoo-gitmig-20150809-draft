# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-html/mini-howto-html-20010824.ebuild,v 1.2 2002/04/27 04:55:29 seemant Exp $

MY_P="Linux-mini-html-HOWTOs-${PV}"
S=${WORKDIR}/HOWTO/mini

DESCRIPTION="The LDP mini-howtos, html format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto/mini
    dodir /usr/share/doc/howto/mini/html
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${S}
    cp -R * ${D}/usr/share/doc/howto/mini/html
    
}
