# Copyright 2003 Gentoo Technologies, Imc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-fi/ispell-fi-20000903.ebuild,v 1.1 2003/06/13 12:54:28 seemant Exp $

S="${WORKDIR}"
DESCRIPTION="Finnish dictionary for ispell"
SRC_URI="http://ispell-fi.sourceforge.net/finnish.dict.bz2 http://ispell-fi.sourceforge.net/finnish.medium.aff.bz2"
HOMEPAGE="http://ispell-fi.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="app-text/ispell
	sys-apps/bzip2"

RDEPEND="app-text/ispell"


src_compile() {
	buildhash finnish.dict finnish.medium.aff finnish.hash
}

src_install () {
	insinto /usr/lib/ispell
	doins finnish.medium.aff finnish.hash
}
