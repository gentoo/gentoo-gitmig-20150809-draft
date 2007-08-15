# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html/howto-html-20070202.ebuild,v 1.4 2007/08/15 03:19:20 jer Exp $

# Grab and rename this file:
# http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html/Linux-html-HOWTOs.tar.bz2

DESCRIPTION="The LDP howtos, html format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-html-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sparc ~x86"
IUSE=""

S=${WORKDIR}/HOWTO

src_install() {
	dodir /usr/share/doc/howto/html
	dosym howto /usr/share/doc/HOWTO
	cp -R * "${D}"/usr/share/doc/howto/html || die "cp failed"
}
