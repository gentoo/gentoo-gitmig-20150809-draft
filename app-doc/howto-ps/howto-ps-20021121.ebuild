# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-ps/howto-ps-20021121.ebuild,v 1.5 2003/09/06 22:17:40 msterret Exp $

MY_P="Linux-ps-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The LDP howtos, postscript format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="x86 ppc sparc "

src_install() {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/ps
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	cd ${WORKDIR}
	insinto /usr/share/doc/howto/ps
	doins *
}
