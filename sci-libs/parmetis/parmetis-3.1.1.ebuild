# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/parmetis/parmetis-3.1.1.ebuild,v 1.2 2010/12/22 20:05:13 bicatali Exp $

EAPI=2
inherit eutils autotools

MYP=ParMetis-${PV}

DESCRIPTION="Parallel graph partitioner"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/parmetis/"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/${MYP}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="free-noncomm"
SLOT="0"
IUSE="doc static-libs"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}
	!sci-libs/metis"

S="${WORKDIR}/${MYP}"

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	cd "${S}"
	eautoreconf
	export CC=mpicc
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README CHANGES
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Manual/*.pdf || die
	fi
}
