# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-2.1_beta2.ebuild,v 1.2 2009/11/11 20:48:13 jer Exp $

EAPI=2
inherit kde4-base

MY_P=${P/_beta/b}

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~x86"
SLOT="4"
IUSE="debug +pdf +png"

RDEPEND="
	|| (
		>=kde-base/okular-${KDE_MINIMAL}[pdf?,ps]
		app-text/acroread
	)
	virtual/latex-base
	virtual/tex-base
	pdf? (
		app-text/dvipdfmx
		app-text/ghostscript-gpl
	)
	png? (
		app-text/dvipng
		media-gfx/imagemagick[png]
	)
"

S=${WORKDIR}/${MY_P}

src_install() {
	kde4-base_src_install

	# TODO: come back later and see if there still is a collision
	rm -f "${D}/${KDEDIR}"/share/{apps/katepart/syntax/{bibtex,latex}.xml,icons/hicolor/{64x64,22x22}/actions/{preview,output_win}.png}
}
