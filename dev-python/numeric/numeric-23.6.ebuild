# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-23.6.ebuild,v 1.1 2004/12/06 23:47:11 carlo Exp $

inherit distutils eutils

MY_P=${P/n/N}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical Python adds a fast, compact, multidimensional array language facility to Python."
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://www.pfdubois.com/numpy/"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
LICENSE="as-is"

# 2.1 gave sandbox violations see #21
DEPEND=">=dev-lang/python-2.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P/\.6/\.3}.patch
}

src_install() {

	distutils_src_install
	distutils_python_version

	#Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${PYVER}/site-packages/NumTut
	doins Demo/NumTut/*

}
