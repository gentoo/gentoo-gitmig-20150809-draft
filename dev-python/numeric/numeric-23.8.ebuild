# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-23.8.ebuild,v 1.3 2005/08/22 22:34:17 lucass Exp $

inherit distutils eutils

MY_P=Numeric-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical Python adds a fast, compact, multidimensional array language facility to Python."
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://numeric.scipy.org/"

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
LICENSE="as-is"

# 2.1 gave sandbox violations see #21
DEPEND=">=dev-lang/python-2.2"

src_install() {

	distutils_src_install
	distutils_python_version

	#Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${PYVER}/site-packages/NumTut
	doins Demo/NumTut/*

}
