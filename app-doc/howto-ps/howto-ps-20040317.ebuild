# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-ps/howto-ps-20040317.ebuild,v 1.4 2004/08/29 10:31:05 blubb Exp $

DESCRIPTION="The LDP howtos, postscript format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-ps-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/ps
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/ps
	doins * || die
}
