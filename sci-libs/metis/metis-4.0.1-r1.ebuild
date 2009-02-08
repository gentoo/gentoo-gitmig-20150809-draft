# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/metis/metis-4.0.1-r1.ebuild,v 1.7 2009/02/08 15:33:49 klausman Exp $

inherit autotools eutils

MYP=${PN}-4.0
DESCRIPTION="A package for unstructured serial graph partitioning"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/metis/index.html"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/${MYP}.tar.gz"

KEYWORDS="alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
LICENSE="free-noncomm"

IUSE="doc"
SLOT="0"

DEPEND=""
RDEPEND="!sci-libs/parmetis"

S="${WORKDIR}/${MYP}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES || die "dodoc failed"
	use doc && dodoc Doc/manual.ps
}
