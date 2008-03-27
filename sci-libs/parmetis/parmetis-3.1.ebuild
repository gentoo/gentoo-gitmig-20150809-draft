# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/parmetis/parmetis-3.1.ebuild,v 1.1 2008/03/27 19:01:47 bicatali Exp $

inherit eutils autotools

MYP=ParMetis-${PV}

DESCRIPTION="Parallel graph partitioner"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/parmetis/"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/${MYP}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="free-noncomm"
SLOT="0"
IUSE="doc"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}
	!sci-libs/metis"

S="${WORKDIR}/${MYP}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
	export CC=mpicc
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc REAME CHANGES
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Manual/*.pdf || die
	fi
}
