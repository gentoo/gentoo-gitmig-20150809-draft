# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20020328.ebuild,v 1.3 2002/07/21 02:51:18 cardoe Exp $

MY_P="Linux-html-single-HOWTOs-${PV}"
S=${WORKDIR}

DESCRIPTION="The LDP howtos, html single-page format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
    
    dodir /usr/share/doc/howto
    dodir /usr/share/doc/howto/html-single
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${S}
    insinto /usr/share/doc/howto/html-single
    doins *
    
}
