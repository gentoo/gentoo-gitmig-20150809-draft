# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-ps/howto-ps-20010706.ebuild,v 1.1 2001/08/07 18:11:50 danarmak Exp $

P="Linux-ps-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP howtos, postscript format."

SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/ps/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto
    dodir /usr/share/doc/howto/ps
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/ps
    doins *
    
}