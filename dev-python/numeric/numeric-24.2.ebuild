# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-24.2.ebuild,v 1.4 2006/07/28 20:05:01 the_paya Exp $

inherit distutils eutils

MY_P=Numeric-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical Python adds a fast, compact, multidimensional array language facility to Python."
HOMEPAGE="http://numeric.scipy.org/"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/python-2.3"

src_install() {
	distutils_src_install
	distutils_python_version

	# Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${PYVER}/site-packages/NumTut
	doins Demo/NumTut/* || die
}
