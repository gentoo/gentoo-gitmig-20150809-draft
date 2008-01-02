# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/cblas/cblas-1.0.ebuild,v 1.4 2008/01/02 16:47:59 armin76 Exp $

DESCRIPTION="Virtual for BLAS C implementation"
HOMEPAGE="http://www.gentoo.org/proj/en/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="|| (
		sci-libs/cblas-reference
		>=sci-libs/blas-atlas-3.7.39
		>=sci-libs/gsl-1.9-r1
		>=sci-libs/mkl-9.1.023
	)"
DEPEND=""
