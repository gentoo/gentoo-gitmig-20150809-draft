# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-text/howto-text-20030826.ebuild,v 1.1 2003/08/27 09:24:45 msterret Exp $

MY_P="Linux-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The LDP howtos, text format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="x86 ppc sparc "

#As of 2003-07-24, the mini-HOWTOs are now merged into the full set of HOWTOs
DEPEND="!app-doc/mini-howto-text"

src_install() {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/text
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	cd ${WORKDIR}
	gzip -9 *
	insinto /usr/share/doc/howto/text
	doins *
}
