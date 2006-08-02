# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epsilon/epsilon-0.4.0.ebuild,v 1.4 2006/08/02 03:31:33 tgall Exp $

inherit distutils eutils

DESCRIPTION="Epsilon is a Python utilities package, most famous for its Time class."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodEpsilon"
SRC_URI="mirror://gentoo/Epsilon-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.1"

S="${WORKDIR}/Epsilon-${PV}"

DOCS="README NAME.txt NEWS.txt"

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	trial epsilon || die "trial failed"
}
