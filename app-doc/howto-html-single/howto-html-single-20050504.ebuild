# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20050504.ebuild,v 1.1 2005/05/05 03:40:46 vapier Exp $

# Grab and rename this file:
# http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/Linux-html-single-HOWTOs.tar.bz2

DESCRIPTION="The LDP howtos, html single-page format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-html-single-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/doc/howto/html-single
	doins * || die
	dosym howto /usr/share/doc/HOWTO
}
