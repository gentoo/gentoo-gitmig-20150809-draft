# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/ast/ast-5.7.2.ebuild,v 1.1 2011/07/25 17:58:44 bicatali Exp $

EAPI=4
inherit eutils versionator

MYP=${PN}-$(replace_version_separator 2 '-')

DESCRIPTION="Library for handling World Coordinate Systems in astronomy"
HOMEPAGE="http://starlink.jach.hawaii.edu/starlink/AST"
SRC_URI="${HOMEPAGE}?action=AttachFile&do=get&target=${MYP}.tar.gz -> ${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc static-libs"
RDEPEND="sci-libs/pgplot
	!x11-libs/libast"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MYP}

src_prepare() {
	# dont patch/sed Makefile.am
	# requires special upstream automake not shipped
	epatch "${FILESDIR}"/${PV}-as-needed.patch
	epatch "${FILESDIR}"/${PV}-no-emsrep.patch
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -rf "${ED}"usr/{docs,help,manifests,news,share} || die
	dodoc ast.news fac_1521_err
	use doc && dodoc *.ps
}
