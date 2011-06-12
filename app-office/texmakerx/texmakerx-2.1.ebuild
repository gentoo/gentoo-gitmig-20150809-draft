# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmakerx/texmakerx-2.1.ebuild,v 1.1 2011/06/12 07:33:48 jlec Exp $

EAPI=4

inherit base qt4-r2

DESCRIPTION="Fork of the LaTeX IDE TexMaker"
HOMEPAGE="http://texmakerx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/TexMakerX%202.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEPEND="
	app-text/poppler[qt4]
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/qt-gui-4.6.1:4
	>=x11-libs/qt-core-4.6.1:4
	>=x11-libs/qt-webkit-4.6.1:4
	>=app-text/hunspell-1.2.4"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/${P/-/}

PATCHES=( "${FILESDIR}/${P}-hunspell.patch" )

src_prepare() {
	find hunspell -delete
	sed 's:hunspell/hunspell:hunspell:g' -i *.h || die
	qt4-r2_src_prepare
}
