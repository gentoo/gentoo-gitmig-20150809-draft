# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/eugene/eugene-3.5d.ebuild,v 1.1 2009/01/04 05:16:38 weaver Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://www.inra.fr/mia/T/EuGene/"
SRC_URI="http://mulcyber.toulouse.inra.fr/gf/download/frsrelease/220/3675/${P}-1.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/gd[png]
	media-libs/libpng
	doc? ( dev-lang/tcl
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-latexextra
		)"
RDEPEND=""

S="${WORKDIR}/${P}-1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ( ! use doc ); then
		sed -i -e '/SUBDIRS/ s/doc//' \
			-e '/INSTALL.*doc/ s/\(.*\)//' \
			Makefile.am || die
		eautoreconf
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
}
