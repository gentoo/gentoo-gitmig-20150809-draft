# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-html-single/mini-howto-html-single-20010824.ebuild,v 1.5 2002/08/02 05:03:34 seemant Exp $

MY_P="Linux-mini-html-single-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The LDP mini-howtos, html-single format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	
	dodir /usr/share/doc/howto/mini
	dodir /usr/share/doc/howto/mini/html-single
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO
	
	cd ${WORKDIR}
	insinto /usr/share/doc/howto/mini/html-single
	doins *
	
}
