# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/kochi-substitute/kochi-substitute-20030809-r3.ebuild,v 1.9 2004/11/04 22:18:07 vapier Exp $

inherit font

DESCRIPTION="Kochi Japanese TrueType fonts with Wadalab Fonts"
HOMEPAGE="http://efont.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/efont/5411/${P}.tar.bz2"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos sparc x86"
IUSE=""

S=${WORKDIR}/${PN}-${PV:0:8}

FONT_SUFFIX="ttf"

DOCS="README.ja COPYING ChangeLog docs/README"

src_install() {

	font_src_install

	cd docs
	for d in kappa20 k14goth ayu20gothic wadalab shinonome* naga10; do
		docinto $d
		dodoc $d/*
	done

}
