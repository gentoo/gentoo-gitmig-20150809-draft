# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-23.1.ebuild,v 1.3 2004/01/29 21:57:49 gmsoft Exp $

inherit distutils

MY_P=${P/n/N}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical Python adds a fast, compact, multidimensional array language facility to Python."
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://www.pfdubois.com/numpy/"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa"
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




