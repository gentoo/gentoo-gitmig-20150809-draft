# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-pdf/howto-pdf-20010823.ebuild,v 1.1 2001/08/23 10:32:22 pm Exp $

P="Linux-pdf-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP howtos, pdf format."

SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/pdf/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto
    dodir /usr/share/doc/howto/pdf
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/pdf
    doins *
    
}
