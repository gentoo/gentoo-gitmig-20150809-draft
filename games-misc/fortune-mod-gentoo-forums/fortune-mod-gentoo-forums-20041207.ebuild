# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-gentoo-forums/fortune-mod-gentoo-forums-20041207.ebuild,v 1.1 2004/12/07 21:03:59 squinky86 Exp $

IUSE="offensive"

DESCRIPTION="Fortune database of quotes from forums.gentoo.org"
HOMEPAGE="http://forums.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~squinky86/files/gentoo-forums-${PV}.gz
	offensive? http://dev.gentoo.org/~squinky86/files/gentoo-forums-offensive-${PV}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~hppa ~sparc ~mips ~alpha"

DEPEND="games-misc/fortune-mod"

S="${WORKDIR}"

src_compile () {
	mv gentoo-forums-${PV} gentoo-forums
	use offensive && cat gentoo-forums-offensive-${PV} >> gentoo-forums
	strfile gentoo-forums
}

src_install () {
	insinto /usr/share/fortune
	doins gentoo-forums gentoo-forums.dat
}
