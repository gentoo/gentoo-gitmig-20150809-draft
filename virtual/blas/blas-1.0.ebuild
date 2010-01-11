# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/blas/blas-1.0.ebuild,v 1.6 2010/01/11 10:55:38 ulm Exp $

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""
RDEPEND="|| (
		sci-libs/blas-reference
		>=sci-libs/blas-atlas-3.7.39
		sci-libs/blas-goto
		>=sci-libs/mkl-9.1.023
		sci-libs/acml
	)"
DEPEND=""
