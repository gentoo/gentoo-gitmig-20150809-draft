# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-text/howto-text-20010823.ebuild,v 1.1 2001/08/23 10:32:23 pm Exp $

P="Linux-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP howtos, text format."

SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto
    dodir /usr/share/doc/howto/text
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/text
    doins *
    
}
