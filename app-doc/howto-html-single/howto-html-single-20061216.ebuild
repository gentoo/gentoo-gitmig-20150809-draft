# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20061216.ebuild,v 1.5 2007/08/15 21:26:27 dertobi123 Exp $

DESCRIPTION="The LDP howtos, html single-page format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/Linux-html-single-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sparc ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/doc/howto/html-single
	doins * || die
	dosym howto /usr/share/doc/HOWTO
}
