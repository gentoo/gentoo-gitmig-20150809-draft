# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html/howto-html-20031006.ebuild,v 1.2 2004/03/14 00:14:30 mr_bones_ Exp $

MY_P="Linux-html-HOWTOs-${PV}"
S=${WORKDIR}/HOWTO

DESCRIPTION="The LDP howtos, html format."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://www.linuxdoc.org"

SLOT="0"
LICENSE="GPL-2 LDP"
KEYWORDS="~x86 ~ppc ~sparc"

src_install() {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/html
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	cp -R * ${D}/usr/share/doc/howto/html
}
