# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-text/howto-text-20040317.ebuild,v 1.4 2004/08/29 10:26:55 blubb Exp $

DESCRIPTION="The LDP howtos, text format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/text
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	gzip -9 *
	insinto /usr/share/doc/howto/text
	doins *
}
