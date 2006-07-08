# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-fvl/fortune-mod-fvl-20030120.ebuild,v 1.9 2006/07/08 08:13:51 corsair Exp $

DESCRIPTION="Quotes from Felix von Leitner (fefe)"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install () {
	insinto /usr/share/fortune
	doins fvl fvl.dat
}
