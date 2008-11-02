# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-fi/ispell-fi-20000903.ebuild,v 1.15 2008/11/02 19:36:08 welp Exp $

inherit multilib

DESCRIPTION="Finnish dictionary for ispell"
HOMEPAGE="http://ispell-fi.sourceforge.net/"
SRC_URI="http://ispell-fi.sourceforge.net/finnish.dict.bz2
	http://ispell-fi.sourceforge.net/finnish.medium.aff.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="alpha ~amd64 ~hppa ~mips ppc sparc x86"

DEPEND="app-text/ispell
	app-arch/bzip2"
RDEPEND="app-text/ispell"

S=${WORKDIR}

src_compile() {
	buildhash finnish.dict finnish.medium.aff finnish.hash || die
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins finnish.medium.aff finnish.hash || die
}
