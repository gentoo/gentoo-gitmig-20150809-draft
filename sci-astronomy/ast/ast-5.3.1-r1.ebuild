# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/ast/ast-5.3.1-r1.ebuild,v 1.1 2010/06/10 08:58:48 xarthisius Exp $

EAPI=2
inherit eutils versionator

MYP="${PN}-$(replace_version_separator 2 '-')"

DESCRIPTION="Library for handling World Coordinate Systems in astronomy"
HOMEPAGE="http://starlink.jach.hawaii.edu/starlink/AST"
SRC_URI="${HOMEPAGE}?action=AttachFile&do=get&target=${MYP}.tar.gz -> ${MYP}.tar.gz"

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
	epatch "${FILESDIR}"/${PN}-5.1.0-makefile.in.patch \
		"${FILESDIR}"/${P}-gcc44.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"usr/{docs,help,manifests,news,share} || die
	dodoc ast.news fac_1521_err
	if use doc; then
		dodoc *.ps || die "doc install failed"
	fi
}
