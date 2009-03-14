# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/suitesparse/suitesparse-3.2.0.ebuild,v 1.1 2009/03/14 12:28:00 bicatali Exp $

EAPI=2

DESCRIPTION="Meta package for a suite of sparse matrix tools"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SuiteSparse/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="metis doc"
DEPEND=""
RDEPEND=">=sci-libs/ufconfig-${PV}
	>=sci-libs/amd-2.2[doc?]
	>=sci-libs/btf-1.0.1
	>=sci-libs/camd-2.2.0[doc?]
	>=sci-libs/ccolamd-2.7.1
	>=sci-libs/cholmod-1.7-r1[doc?,metis?]
	>=sci-libs/colamd-2.7.1
	>=sci-libs/cxsparse-2.2.2
	>=sci-libs/klu-1.0.1[doc?]
	>=sci-libs/ldl-2.0.1[doc?]
	>=sci-libs/spqr-1.1[doc?,metis?]
	>=sci-libs/umfpack-5.2[doc?]"
