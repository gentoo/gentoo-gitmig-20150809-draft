# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-martin-piskernig/fortune-mod-martin-piskernig-20030120.ebuild,v 1.6 2006/07/17 05:22:03 vapier Exp $

MY_P=fortune-mod-martin.piskernig-${PV}
DESCRIPTION="Quotes from Martin Piskernig"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/share/fortune
	doins martin.piskernig martin.piskernig.dat || die
}
