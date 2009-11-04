# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/ast/ast-5.2.0.ebuild,v 1.1 2009/11/04 01:39:55 bicatali Exp $

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
RDEPEND="sci-libs/pgplot"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# dont patch/sed Makefile.am because it requires special upstream automake
	# not shipped
	epatch "${FILESDIR}"/${PN}-5.1.0-makefile.in.patch
}

#src_configure() {
#	PATH=".:${PATH}" econf
#}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"usr/{docs,help,manifests,news,share} || die
	dodoc ast.news fac_1521_err
	if use doc; then
		dodoc *.ps || die "doc install failed"
	fi
}
