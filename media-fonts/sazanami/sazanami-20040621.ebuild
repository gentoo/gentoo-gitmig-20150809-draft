# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sazanami/sazanami-20040621.ebuild,v 1.3 2004/07/14 17:08:31 agriffis Exp $

inherit font

DESCRIPTION="Sazanami Japanese TrueType fonts"
HOMEPAGE="http://efont.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/efont/9984/${P}.tar.bz2"

# oradano, misaki, mplus -> as-is
# shinonome, ayu, kappa -> public-domain
LICENSE="as-is public-domain"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE=""

FONT_SUFFIX="ttf"

DOCS="docs/README"

src_install() {

	font_src_install

	cd doc
	for d in oradano misaki mplus shinonome ayu kappa; do
		docinto $d
		dodoc $d/*
	done

}
