# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Paarg Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-html-single/mini-howto-html-single-20010824.ebuild,v 1.1 2001/08/25 09:14:45 danarmak Exp $

P="Linux-mini-html-single-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP mini-howtos, html-single format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto/mini
    dodir /usr/share/doc/howto/mini/html-single
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/mini/html-single
    doins *
    
}
