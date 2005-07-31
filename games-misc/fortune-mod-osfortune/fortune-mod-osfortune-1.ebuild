# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-osfortune/fortune-mod-osfortune-1.ebuild,v 1.10 2005/07/31 14:34:57 corsair Exp $

inherit eutils

DESCRIPTION="Open sources fortune file"
HOMEPAGE="http://www.dibona.com/opensources/index.shtml"
SRC_URI="http://www.dibona.com/opensources/osfortune.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="games-misc/fortune-mod"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/spelling.patch"
	strfile osfortune
}

src_install() {
	insinto /usr/share/fortune
	doins osfortune osfortune.dat
}
