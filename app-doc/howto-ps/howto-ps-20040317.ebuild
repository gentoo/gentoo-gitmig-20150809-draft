# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-ps/howto-ps-20040317.ebuild,v 1.2 2004/06/07 00:57:14 dragonheart Exp $

DESCRIPTION="The LDP howtos, postscript format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-ps-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/ps
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/ps
	doins * || die
}
