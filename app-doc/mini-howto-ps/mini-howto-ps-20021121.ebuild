# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-ps/mini-howto-ps-20021121.ebuild,v 1.6 2004/03/14 00:14:31 mr_bones_ Exp $

MY_P="Linux-mini-ps-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The LDP mini-howtos, ps format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org/"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="x86 ppc sparc"

src_install() {
	dodir /usr/share/doc/howto/mini
	dodir /usr/share/doc/howto/mini/ps
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	cd ${WORKDIR}
	insinto /usr/share/doc/howto/mini/ps
	doins *
}
