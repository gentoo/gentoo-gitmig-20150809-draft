# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/Numeric/Numeric-20.3.ebuild,v 1.4 2002/07/27 05:40:14 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="numerical python module"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz"
HOMEPAGE="http://www.pfdubois.com/numpy/"

# 2.1 gave sandbox violations see #21
DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

src_compile() {
  
#The ebuild as is uses a small local version of BLAS and LAPACK provided
#by the Numeric package. If I ever get ATLAS and LAPACK ebuilds finished,
#we'll need to edit (sed) setup.py to use the real libraries.

	python setup_all.py build || die    

}

src_install() {

	python setup_all.py install --prefix=${D}/usr || die 

	dodoc MANIFEST PKG-INFO README

#grab python verision so ebuild doesn't depend on it
	local pv
	pv=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')

#Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${pv}/site-packages/NumTut
	doins Demo/NumTut/*

}




