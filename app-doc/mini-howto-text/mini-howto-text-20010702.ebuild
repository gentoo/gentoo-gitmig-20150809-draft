# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-text/mini-howto-text-20010702.ebuild,v 1.3 2001/08/02 20:45:02 danarmak Exp $

P="Linux-mini-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP mini-howtos, text format."

SRC_URI="http://www.ibiblio.org/pub/linux/docs/HOWTO/mini/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto/mini
    dodir /usr/share/doc/howto/mini/text
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/mini/text
    doins *
    
}