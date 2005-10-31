# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/easysok/easysok-0.3.5.ebuild,v 1.1 2005/10/31 08:37:45 mr_bones_ Exp $

inherit eutils kde

DESCRIPTION="Sokoban clone with editor, solver, and other neat goodies"
HOMEPAGE="http://easysok.sourceforge.net/"
SRC_URI="mirror://sourceforge/easysok/${P}-kde3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

need-kde 3

src_unpack () {
	kde_src_unpack
	cd "${S}"
	if use ppc; then
		epatch "${FILESDIR}"/image_effect-ppc.patch
	fi
}
