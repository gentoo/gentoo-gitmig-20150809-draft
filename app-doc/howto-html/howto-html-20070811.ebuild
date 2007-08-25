# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html/howto-html-20070811.ebuild,v 1.2 2007/08/25 11:47:07 vapier Exp $

# Download from
# www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html/Linux-html-HOWTOs-${PV}.tar.bz2
# and mirror it.

DESCRIPTION="The LDP howtos, html format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-html-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

RESTRICT="strip binchecks"

S=${WORKDIR}/HOWTO

src_install() {
	insinto /usr/share/doc/howto/html
	doins -r * || die
}
