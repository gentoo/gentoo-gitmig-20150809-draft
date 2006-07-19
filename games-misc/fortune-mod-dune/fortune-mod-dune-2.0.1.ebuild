# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-dune/fortune-mod-dune-2.0.1.ebuild,v 1.8 2006/07/19 19:45:58 flameeyes Exp $

MY_P=${PN}-quotes.${PV}
DESCRIPTION="Quotes from Frank Herbert's Dune Chronicles"
HOMEPAGE="http://dune.s31.pl/"
SRC_URI="http://dune.s31.pl/${MY_P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/share/fortune
	doins * || die
}
