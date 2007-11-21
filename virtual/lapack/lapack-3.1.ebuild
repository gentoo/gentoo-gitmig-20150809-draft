# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/lapack/lapack-3.1.ebuild,v 1.1 2007/11/21 00:20:13 bicatali Exp $

DESCRIPTION="Virtual for Linear Algebra Package FORTRAN 77 (LAPACK) implementation"
HOMEPAGE="http://www.gentoo.org/proj/en/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="|| (
		>=sci-libs/lapack-reference-3.1
		>=sci-libs/lapack-atlas-3.8.0
		>=sci-libs/mkl-10
		>=sci-libs/acml-4
	)"
DEPEND=""
