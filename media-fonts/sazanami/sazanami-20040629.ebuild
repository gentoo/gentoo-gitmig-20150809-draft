# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sazanami/sazanami-20040629.ebuild,v 1.7 2004/10/18 04:01:17 matsuu Exp $

inherit font

DESCRIPTION="Sazanami Japanese TrueType fonts"
HOMEPAGE="http://efont.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/efont/10087/${P}.tar.bz2"

# oradano, misaki, mplus -> as-is
# shinonome, ayu, kappa -> public-domain
LICENSE="as-is public-domain"
SLOT="0"
KEYWORDS="x86 alpha ppc ~ppc64 ~ppc-macos amd64 sparc"
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
