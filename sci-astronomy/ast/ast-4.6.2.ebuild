# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/ast/ast-4.6.2.ebuild,v 1.3 2009/01/09 22:43:14 josejx Exp $

EAPI=2
inherit eutils versionator

MYP="${PN}-$(replace_version_separator 2 '-')"
DESCRIPTION="Library for handling World Coordinate Systems in astronomy"
HOMEPAGE="http://www.starlink.ac.uk/~dsb/ast/ast.html"
SRC_URI="http://www.starlink.ac.uk/~dsb/${PN}/${MYP}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# dont do sed in Makefile.am because it requires special starlink automake
	sed -i \
		-e 's/@STAR_LATEX_DOCUMENTATION@//' \
		-e 's/ast.news//' \
		-e 's/LICENCE//' \
		-e 's/starfacs_DATA =.*/starfacs_DATA =/' \
		-e '/$(INSTALL_DATA) $$MF/d' \
		Makefile.in || die
}

src_configure() {
	PATH=.:${PATH} econf
}

src_install() {
	emake DESTDIR="${D}" \
		install-exec install-includeHEADERS || die "emake install failed"
	dodoc ast.news fac_1521_err
	if use doc; then
		dodoc *.ps || die "doc install failed"
	fi
}
