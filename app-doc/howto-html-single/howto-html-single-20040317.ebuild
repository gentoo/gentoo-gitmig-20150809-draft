# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20040317.ebuild,v 1.4 2004/08/29 10:29:12 blubb Exp $

DESCRIPTION="The LDP howtos, html single-page format."
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-html-single-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/html-single
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/html-single
	doins * || die
}
