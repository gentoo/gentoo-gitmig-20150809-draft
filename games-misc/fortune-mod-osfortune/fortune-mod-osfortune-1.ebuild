# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-osfortune/fortune-mod-osfortune-1.ebuild,v 1.3 2003/09/16 15:06:20 dholm Exp $

DESCRIPTION="Open sources fortune file"
HOMEPAGE="http://www.dibona.com/opensources/index.shtml"
SRC_URI="http://www.dibona.com/opensources/osfortune.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips ~ppc"

DEPEND="games-misc/fortune-mod"
RDEPEND=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/fortune
	doins osfortune osfortune.dat
}
