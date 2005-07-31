# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-humorixfortunes/fortune-mod-humorixfortunes-1.4-r1.ebuild,v 1.8 2005/07/31 14:30:48 corsair Exp $

MY_P=${P/fortune-mod-/}
DESCRIPTION="Extra fortune cookies for fortune"
HOMEPAGE="http://i-want-a-website.com/about-linux/downloads.shtml"
SRC_URI="http://humorix.org/downloads/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/fortune
	doins humorix-misc humorix-misc.dat
	doins humorix-stories humorix-stories.dat
}
