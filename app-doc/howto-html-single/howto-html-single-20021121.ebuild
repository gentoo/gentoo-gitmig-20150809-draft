# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20021121.ebuild,v 1.1 2002/11/25 05:28:17 danarmak Exp $

MY_P="Linux-html-single-HOWTOs-${PV}"
S=${WORKDIR}

DESCRIPTION="The LDP howtos, html single-page format."

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/html-single
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO
	
	cd ${S}
	insinto /usr/share/doc/howto/html-single
	doins *
	
}
