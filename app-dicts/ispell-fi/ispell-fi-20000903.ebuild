# Copyright 2003 Gentoo Technologies, Imc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-fi/ispell-fi-20000903.ebuild,v 1.3 2003/08/06 06:49:25 vapier Exp $

DESCRIPTION="Finnish dictionary for ispell"
HOMEPAGE="http://ispell-fi.sourceforge.net/"
SRC_URI="http://ispell-fi.sourceforge.net/finnish.dict.bz2
	http://ispell-fi.sourceforge.net/finnish.medium.aff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="app-text/ispell
	sys-apps/bzip2"
RDEPEND="app-text/ispell"

S="${WORKDIR}"

src_compile() {
	buildhash finnish.dict finnish.medium.aff finnish.hash
}

src_install() {
	insinto /usr/lib/ispell
	doins finnish.medium.aff finnish.hash
}
