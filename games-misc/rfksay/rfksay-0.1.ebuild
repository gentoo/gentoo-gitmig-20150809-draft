# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/rfksay/rfksay-0.1.ebuild,v 1.7 2004/09/23 08:56:40 mr_bones_ Exp $

inherit games

DESCRIPTION="Like cowsay, but different because it involves robots and kittens"
HOMEPAGE="http://www.robotfindskitten.org/"
#SRC_URI="http://www.redhotlunix.com/${PN}.tar.gz"
SRC_URI="mirror://gentoo/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}"

src_install() {
	dogamesbin kittensay rfksay robotsay || die "dogamesbin failed"
	prepgamesdirs
}
