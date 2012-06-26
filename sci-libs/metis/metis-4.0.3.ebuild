# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/metis/metis-4.0.3.ebuild,v 1.4 2012/06/26 22:50:29 bicatali Exp $

EAPI=4

inherit autotools eutils fortran-2

DESCRIPTION="A package for unstructured serial graph partitioning"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/metis/"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/OLD/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~amd64-fbsd ~x86-linux"
LICENSE="free-noncomm"
IUSE="doc static-libs"

DEPEND="virtual/fortran"
RDEPEND="${DEPEND}
	!sci-libs/parmetis"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.0.1-autotools.patch
	sed -i -e "s/4.0.1/${PV}/" configure.ac || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc Doc/manual.ps
}
