# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20031006.ebuild,v 1.1 2003/10/06 13:16:45 lanius Exp $

MY_P="Linux-html-single-HOWTOs-${PV}"
S=${WORKDIR}

DESCRIPTION="The LDP howtos, html single-page format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="~x86 ~ppc ~sparc"

src_install() {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/html-single
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/html-single
	doins *
}
