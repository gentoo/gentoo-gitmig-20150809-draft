# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-at-linux/fortune-mod-at-linux-20030120.ebuild,v 1.3 2004/10/15 23:14:29 gmsoft Exp $

DESCRIPTION="Quotes from at.linux"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${S}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc hppa"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/fortune-mod-at.linux-${PV}"

src_install () {
	cd "${S}"
	insinto /usr/share/fortune
	doins at.linux at.linux.dat
}
