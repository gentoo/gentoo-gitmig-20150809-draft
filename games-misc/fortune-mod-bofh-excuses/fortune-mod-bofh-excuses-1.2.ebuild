# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-bofh-excuses/fortune-mod-bofh-excuses-1.2.ebuild,v 1.2 2003/09/10 18:39:25 vapier Exp $

S=${WORKDIR}/${PN/mod-/}
DESCRIPTION="Excuses from Bastard Operator from Hell"
SRC_URI="http://www.stlim.net/downloads/fortune-bofh-excuses-${PV}.tar.gz"
HOMEPAGE="http://www.stlim.net/staticpages/index.php?page=20020814005536450"

SLOT="0"
KEYWORDS="x86 ppc ~mips ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins bofh-excuses.dat bofh-excuses
}
