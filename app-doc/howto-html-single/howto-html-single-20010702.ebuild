# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20010702.ebuild,v 1.2 2001/08/02 20:45:02 danarmak Exp $

P="Linux-html-single-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The LDP howtos, html single-page format."

SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/${P}-${PV}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto
    dodir /usr/share/doc/howto/html-single
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/html-single
    doins *
    
}