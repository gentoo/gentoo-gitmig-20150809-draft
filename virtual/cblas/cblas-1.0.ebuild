# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/cblas/cblas-1.0.ebuild,v 1.8 2010/01/11 10:56:05 ulm Exp $

DESCRIPTION="Virtual for BLAS C implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="|| (
		sci-libs/cblas-reference
		>=sci-libs/blas-atlas-3.7.39
		>=sci-libs/gsl-1.9-r1
		>=sci-libs/mkl-9.1.023
	)"
DEPEND=""
