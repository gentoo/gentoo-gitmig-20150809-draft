# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/cirkuit/cirkuit-0.2.2.ebuild,v 1.1 2009/12/25 15:09:22 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="An application to generate publication-ready figures"
HOMEPAGE="http://wwwu.uni-klu.ac.at/magostin/cirkuit.html"
SRC_URI="http://wwwu.uni-klu.ac.at/magostin/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="virtual/poppler-qt4"
RDEPEND="${DEPEND}
	virtual/latex-base
	media-libs/netpbm
	dev-texlive/texlive-pstricks
	virtual/ghostscript
	app-text/ps2eps
	media-gfx/pdf2svg"

DOCS="Changelog README"
