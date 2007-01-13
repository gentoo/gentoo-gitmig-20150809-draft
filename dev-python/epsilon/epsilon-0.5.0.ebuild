# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epsilon/epsilon-0.5.0.ebuild,v 1.1 2007/01/13 23:34:14 dev-zero Exp $

inherit distutils

DESCRIPTION="Epsilon is a Python utilities package, most famous for its Time class."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodEpsilon"
SRC_URI="mirror://gentoo/Epsilon-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Epsilon-${PV}"

DOCS="README NAME.txt NEWS.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Rename to avoid file-collisions
	mv bin/benchmark bin/epsilon-benchmark
	sed -i \
		-e "s#bin/benchmark#bin/epsilon-benchmark#" \
		setup.py || die "sed faild"
}

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	trial epsilon || die "tests failed"
}
