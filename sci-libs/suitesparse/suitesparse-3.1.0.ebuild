# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/suitesparse/suitesparse-3.1.0.ebuild,v 1.1 2008/02/05 18:49:21 bicatali Exp $

DESCRIPTION="Meta package for a suite of sparse matrix tools"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SuiteSparse/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=">=sci-libs/ufconfig-${PV}
	>=sci-libs/amd-2.2.0
	>=sci-libs/btf-1.0.1
	>=sci-libs/camd-2.2.0
	>=sci-libs/ccolamd-2.7.1
	>=sci-libs/cholmod-1.6
	>=sci-libs/colamd-2.7.1
	>=sci-libs/csparse-2.2.1
	>=sci-libs/cxsparse-2.2.1
	>=sci-libs/klu-1.0.1
	>=sci-libs/ldl-2.0.1
	>=sci-libs/umfpack-5.2.0"
