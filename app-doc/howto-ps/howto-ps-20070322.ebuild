# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-ps/howto-ps-20070322.ebuild,v 1.1 2007/03/22 18:21:23 armin76 Exp $

# Grab and rename this file:
# http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/ps/Linux-ps-HOWTOs.tar.bz2

DESCRIPTION="The LDP howtos, postscript format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-ps-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/doc/howto/ps
	doins * || die "doins failed"
	dosym howto /usr/share/doc/HOWTO
}
