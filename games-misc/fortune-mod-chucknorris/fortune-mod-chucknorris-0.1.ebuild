# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-chucknorris/fortune-mod-chucknorris-0.1.ebuild,v 1.6 2009/10/14 23:59:30 mr_bones_ Exp $

DESCRIPTION="Chuck Norris Facts"
HOMEPAGE="http://www.k-lug.org/~kessler/projects.html"
SRC_URI="http://www.k-lug.org/~kessler/chucknorris.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${PN/mod-/}

src_install() {
	insinto /usr/share/fortune
	doins chucknorris chucknorris.dat || die
}
