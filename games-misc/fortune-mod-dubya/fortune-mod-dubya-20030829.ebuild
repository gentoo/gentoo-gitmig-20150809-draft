# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-dubya/fortune-mod-dubya-20030829.ebuild,v 1.1 2003/09/10 18:14:04 vapier Exp $

DESCRIPTION="Quotes from George W. Bush"
SRC_URI="http://dubya.seiler.us/files/dubya-${PV}.tar.gz"
HOMEPAGE="http://dubya.seiler.us"

S=${WORKDIR}/${PN/fortune-mod-/}

KEYWORDS="x86 ppc ~sparc ~mips"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="app-games/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins dubya dubya.dat
}
