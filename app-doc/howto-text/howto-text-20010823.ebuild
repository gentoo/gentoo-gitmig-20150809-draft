# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-text/howto-text-20010823.ebuild,v 1.9 2002/12/09 04:17:38 manson Exp $

MY_P="Linux-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The LDP howtos, text format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org/"

SLOT="0"
LICENSE="LDP GPL-2"
KEYWORDS="x86 ppc sparc "

src_install() {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/text
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO
	
	cd ${WORKDIR}
	insinto /usr/share/doc/howto/text
	doins *
}
