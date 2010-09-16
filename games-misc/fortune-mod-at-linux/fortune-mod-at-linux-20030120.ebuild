# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-at-linux/fortune-mod-at-linux-20030120.ebuild,v 1.11 2010/09/16 17:10:36 mr_bones_ Exp $

MY_P="fortune-mod-at.linux-${PV}"
DESCRIPTION="Quotes from at.linux"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="unicode"

RDEPEND="games-misc/fortune-mod"
DEPEND="${RDEPEND}
	unicode? ( virtual/libiconv )"

S=${WORKDIR}/${MY_P}

src_compile() {
	# bug #322111
	if use unicode ; then
		iconv --from-code=ISO-8859-1 --to-code=UTF-8 at.linux > at.linux-utf8
		mv at.linux-utf8 at.linux
		strfile -s at.linux
	fi
}

src_install() {
	insinto /usr/share/fortune
	doins at.linux at.linux.dat || die
}
