# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-discworld/fortune-mod-discworld-0.1.ebuild,v 1.5 2010/02/16 23:52:20 hanno Exp $

MY_P=${PN/-mod/}
DESCRIPTION="Quotes from Discworld novels"
HOMEPAGE="http://www.splitbrain.org/projects/fortunes/discworld"
SRC_URI="http://www.splitbrain.org/_media/projects/fortunes/${MY_P}.tgz"

LICENSE="fairuse"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/share/fortune
	doins discworld discworld.dat || die
}
