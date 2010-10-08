# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-norbert-tretkowski/fortune-mod-norbert-tretkowski-20030120.ebuild,v 1.8 2010/10/08 03:53:52 leio Exp $

MY_P=fortune-mod-norbert.tretkowski-${PV}
DESCRIPTION="Quotes from Norbert Tretkowski"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/share/fortune
	doins norbert.tretkowski norbert.tretkowski.dat || die
}
