# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-text/howto-text-20040317.ebuild,v 1.1 2004/03/18 03:38:53 vapier Exp $

DESCRIPTION="The LDP howtos, text format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="x86 ppc sparc"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/text
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	gzip -9 *
	insinto /usr/share/doc/howto/text
	doins *
}
