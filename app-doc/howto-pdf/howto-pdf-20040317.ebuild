# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-pdf/howto-pdf-20040317.ebuild,v 1.2 2004/03/19 01:12:05 vapier Exp $

DESCRIPTION="The LDP howtos, pdf format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-pdf-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="x86 ppc sparc"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/pdf
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/pdf
	doins * || die
}
