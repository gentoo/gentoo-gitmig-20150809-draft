# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/blas/blas-1.0.ebuild,v 1.5 2009/12/15 16:01:18 abcd Exp $

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
HOMEPAGE="http://www.gentoo.org/proj/en/science/"
SRC_URI=""
LICENSE="GPL-2"
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
