# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-at-linux/fortune-mod-at-linux-20030120.ebuild,v 1.4 2004/11/24 21:32:50 swegener Exp $

MY_P="fortune-mod-at.linux-${PV}"

DESCRIPTION="Quotes from at.linux"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc hppa"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${MY_P}"

src_install () {
	cd "${S}"
	insinto /usr/share/fortune
	doins at.linux at.linux.dat
}
