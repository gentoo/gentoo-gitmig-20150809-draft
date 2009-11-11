# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kletterwizard/kletterwizard-0.9.8.ebuild,v 1.12 2009/11/11 12:29:03 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="KLetterWizard is a KDE application which simplifies letter writing and produces output via LaTeX."
HOMEPAGE="http://www.kluenter.de/klw"
SRC_URI="http://www.kluenter.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="kdeenablefinal"

DEPEND="virtual/latex-base
	=kde-base/kghostview-3.5*"
RDEPEND="${DEPEND}
	|| ( >=dev-texlive/texlive-latexextra-2008 dev-tex/latex-unicode )"

need-kde 3.5

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	myconf="--with-texmf-path=/usr/share/texmf"
	kde_src_compile
}

pkg_postinst() {
	einfo "Running texhash to complete install..."
	texhash
}
