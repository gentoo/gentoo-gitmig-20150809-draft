# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Numeric/Numeric-22.0.ebuild,v 1.3 2003/06/21 22:30:23 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="numerical python module"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz"
HOMEPAGE="http://www.pfdubois.com/numpy/"

# 2.1 gave sandbox violations see #21
DEPEND=">=dev-lang/python-2.2"

SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha"
LICENSE="as-is"

src_compile() {
  
#The ebuild as is uses a small local version of BLAS and LAPACK provided
#by the Numeric package. If I ever get ATLAS and LAPACK ebuilds finished,
#we'll need to edit (sed) setup.py to use the real libraries.

	python setup.py build || die    

}

src_install() {

	python setup.py install --prefix=${D}/usr || die 

	dodoc MANIFEST PKG-INFO README

#grab python verision so ebuild doesn't depend on it
	local pv
	pv=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')

#Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${pv}/site-packages/NumTut
	doins Demo/NumTut/*

}




