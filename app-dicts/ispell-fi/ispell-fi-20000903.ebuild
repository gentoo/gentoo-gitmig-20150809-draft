# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-fi/ispell-fi-20000903.ebuild,v 1.14 2008/11/01 12:06:04 pva Exp $

inherit multilib

DESCRIPTION="Finnish dictionary for ispell"
HOMEPAGE="http://ispell-fi.sourceforge.net/"
SRC_URI="http://ispell-fi.sourceforge.net/finnish.dict.bz2
	http://ispell-fi.sourceforge.net/finnish.medium.aff.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha ~hppa ~mips"

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
