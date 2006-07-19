# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-osfortune/fortune-mod-osfortune-1.ebuild,v 1.13 2006/07/19 19:55:05 flameeyes Exp $

inherit eutils

DESCRIPTION="Open sources fortune file"
HOMEPAGE="http://www.dibona.com/opensources/index.shtml"
SRC_URI="http://www.dibona.com/opensources/osfortune.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/spelling.patch
	strfile osfortune || die
}

src_install() {
	insinto /usr/share/fortune
	doins osfortune osfortune.dat || die
}
