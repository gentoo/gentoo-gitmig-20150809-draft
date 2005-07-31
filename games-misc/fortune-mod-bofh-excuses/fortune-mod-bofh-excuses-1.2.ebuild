# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-bofh-excuses/fortune-mod-bofh-excuses-1.2.ebuild,v 1.8 2005/07/31 14:16:25 corsair Exp $

DESCRIPTION="Excuses from Bastard Operator from Hell"
HOMEPAGE="http://www.stlim.net/staticpages/index.php?page=20020814005536450"
SRC_URI="http://www.stlim.net/downloads/fortune-bofh-excuses-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins bofh-excuses.dat bofh-excuses
}
