# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/easysok/easysok-0.3.4.ebuild,v 1.2 2004/12/16 14:26:49 josejx Exp $

inherit kde eutils
need-kde 3

DESCRIPTION="Sokoban clone with editor, solver, and other neat goodies"
HOMEPAGE="http://easysok.sourceforge.net/"
SRC_URI="mirror://sourceforge/easysok/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

src_unpack () {
	unpack ${A}
	cd ${S}
	if use ppc; then
		epatch ${FILESDIR}/image_effect-ppc.patch
	fi
}
